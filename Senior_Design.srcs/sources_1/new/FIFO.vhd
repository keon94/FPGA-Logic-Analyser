--The FIFO operates on two clocks. The FIFO write clock, and the USB read clock. 
--Data is written to the FIFO when:
      --The FIFO is not full -> the read address pointer and the write address pointer are unequal
      --Only on the rising edge of the FIFO write clock
--Data is read from the FIFO when:
      --The FIFO still contains iterms that have not been read
      --Only on the rising edge of the usb_read_clk and when the read_en signal is 1 
--On each read or write, only a single row in the FIFO is onsidered. All bits in the row are written to/read in parallel.


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FIFO is
    generic(
        mem_size : integer;             --depth of the FIFO
        mem_width : integer             --width of the FIFO
    );
    port(
        signal fifo_write_clk       : in std_logic;
        signal usb_read_clk         : in std_logic;
        signal read_en              : in std_logic;
        signal rst                  : in std_logic;
        signal data_in              : in std_logic_vector(mem_width-1 downto 0);
        signal data_out             : out std_logic_vector(mem_width-1 downto 0);
        signal fifo_state           : out std_logic;   -- a bit that indicates whether or not the FIFO is full
        signal num_of_data          : out integer range 0 to mem_size --number of data in the fifo at a given time (ready to be read)
    );    
end FIFO;

architecture Behavioral of FIFO is


type fifo_mem_type is array(0 to mem_size-1) of std_logic_vector(mem_width-1 downto 0);

signal zero_data                                            : std_logic_vector(mem_width-1 downto 0) := (others => '0'); --a zero FIFO row
signal write_address, read_address                          : integer range 0 to mem_size-1 := 0;   --address pointers for the FIFO
signal fifo_mem                                             : fifo_mem_type := (others => zero_data);   --the fifo iteself (an array of vectors)
signal master_write_controller, master_read_controller      : std_logic := '1'; --these signals become 0 once the FIFO terminates data-writes to itself and usb-reads from itself respectively
signal effective_write_clk, effective_read_en               : std_logic; --same as write_clk and read_en, except that they are overridden by the declared master signals once they become 0
signal first_write_cycle_passed                             : std_logic := '0'; --when the circuit starts, both the read and write pointers will be at the same location. By our design, this would indicate 
                                                                                --the termination of the fifo's operation, which is obviously not what we want so soon. This signal is to ensure that at least
                                                                                --least one write has been made to the FIFO before we start invoking the read-write address equality condition.
signal m_num_of_data                                        : integer range 0 to mem_size := 0; --a signal that tracks the number of remaining items in the FIFO - updated everytime the read or write addresses are updated.
signal total_writes, total_reads                            : integer range 0 to mem_size := 0; --the total amount of reads and writes made since the start of the circuit.


begin

    effective_write_clk <= master_write_controller and fifo_write_clk;  --when the master write controller becomes 0 the write clk becomes irrelevant, as we'll no longer be writing to the FIFO.
    effective_read_en <= master_read_controller and read_en;  --when the master read controller becomes 0 the read_en becomes irrelevant, as we'll no longer be reading from the FIFO (the FIFO operation is over).
    
    write_to_mem: process (effective_write_clk, rst)    --this process takes care of writing data to the current write_address of the FIFO. Only allowed on the rising edge of the write_clk
        begin
            if(rst = '1') then
                fifo_mem <= (others => zero_data);
            else 
                if(rising_edge(effective_write_clk)) then
                    fifo_mem(write_address) <= data_in;  
                end if;
            end if;
        end process;
                    
    read_from_mem: process(read_address, rst)   --this process takes care of the reading from the current read_address of the FIFO. Reading is done only when the Read_address pointer has been updated (thus triggering this process)
        begin
            if(rst = '1') then
                data_out <= (others => '0');
            else
                data_out <= fifo_mem(read_address);
            end if;
        end process;
                                          
    update_write_pointer: process (effective_write_clk, rst)   --update the write pointer on the rising edge of the write clk
        begin
            if(rst = '1') then
                write_address <= 0;
                first_write_cycle_passed <= '0';
                master_write_controller <= '1';
                total_writes <= 0;
            else                           
                if(rising_edge(effective_write_clk)) then
                    if(first_write_cycle_passed = '0' and (write_address /= read_address)) then  --this happens when the first write has been done, but no read. Now we know that the first write cycle has passed
                        first_write_cycle_passed <= '1';
                    end if; 
                    if(first_write_cycle_passed = '1' and (write_address = read_address)) then   --this happens when the write pointer and read pointer meet again, indicating that the FIFO is full.
                        master_write_controller <= '0'; --We shall inhibit any further writes
                        if( write_address = 0 ) then    --This is a corner-case: Since the current write location is the same as the current read location, we might corrupt the data we're reading if we allow writes here, so back off by one index.
                            write_address <= mem_size - 1;  --if we're at the top of the FIFO, move back to the bottom
                        else
                            write_address <= write_address - 1; --else, move back by an index
                        end if;                            
                    elsif(write_address >= mem_size - 1) then  --when the write pointer has reached the bottom of the FIFO, and we're still not done                         
                        write_address <= 0;     --circle back to the top
                        total_writes <= total_writes + 1;  
                    else 
                        write_address <= write_address + 1;     --else, just increment the current write_address (as we're still not done)
                        total_writes <= total_writes + 1;
                    end if;                               
                end if;
            end if;
          end process;
       
   update_read_pointer: process (usb_read_clk, rst) --update the read pointer in accordance with the usb clock
        begin
            if(rst = '1') then
                master_read_controller <= '1';
                read_address <= 0;
                total_reads <= 0;
            elsif(effective_read_en = '1' and rising_edge(usb_read_clk)) then   --we shall only read if we are on the rising edge of the usb read clock and read enable = 1
                total_reads <= total_reads + 1;
                if(master_write_controller = '0' and (write_address = read_address)) then   --if the read pointer clashes with the write pointer, we know we're done and the FIFO should come to a halt (no more reads - writes were already done a while back)
                    master_read_controller <= '0';
                elsif(read_address >= mem_size - 1) then     --else if at the bottom of the FIFO, circle back to the top                          
                    read_address <= 0;                   
                else 
                    read_address <= read_address + 1;       --otherwise increment it
                end if;
            end if;
        end process;
        
   update_statistics : process(total_writes, total_reads, rst)  --keeps track of the number of remaining items in the FIFO
        begin
            if(rst = '1') then
                m_num_of_data <= 0;
            else
                m_num_of_data <= total_writes - total_reads;    --at any given time, the remaining items in the FIFO is always equal to the diferent of total writes and reads
            end if;
        end process;
                
            
        
   fifo_state <= master_write_controller;   --when the master_write_controller = 0, we know the FIFO is full, so fifo_state = 0. 
   num_of_data <= m_num_of_data;
                                                     
end Behavioral;


