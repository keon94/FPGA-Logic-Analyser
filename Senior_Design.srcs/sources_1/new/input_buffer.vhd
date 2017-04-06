--An intermediate memory stage that connects the inputs to the FIFO
--The buffer is a 2D array similar to the FIFO, whose size is buffer_width in width (number of columns) and num_of_inputs in depth (number of rows)
--The buffer operates on 2 clocks (like the FIFO). The clk by which data is written to it. This will be the fpga sampling clock. 
--           The other is  the fifo_write_clk, the clk by which data is flushed from it, to a row in the FIFO.
--At every rising edge of the fpga sampling clk, 1 bit from each external input will be read in parallel to the Buffer (each bit will occupy a single cell in each row).
--The fifo_write_clk will always be operating at a frequency of 1/buffer_width of the fpga_clk. This is because we require buffer_width many cycles to completely fill the buffer.


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity input_buffer is

generic(
    num_of_inputs : integer;
    buffer_width : integer
);

Port (
    fpga_clk            : in std_logic;
    fifo_write_clk      : in std_logic;
    rst                 : in std_logic;
    buffer_en           : in std_logic;     --the buffer will admit data (allow writes) as long as this signal is 1 
    data_in             : in std_logic_vector(num_of_inputs-1 downto 0);    --the input data received
    data_out            : out std_logic_vector(num_of_inputs*buffer_width-1 downto 0)       --the data that goes to the FIFO 
 );
 
end input_buffer;

architecture Behavioral of input_buffer is

type buffer_mem is array(0 to buffer_width-1) of std_logic_vector(num_of_inputs-1 downto 0);

signal zero_buffer      : buffer_mem := (others => (others => '0'));
signal buffer_memory    : buffer_mem := zero_buffer;
signal counter          : integer := 0;
signal counter_max      : integer := buffer_width - 1;
signal data_out_temp    : std_logic_vector(num_of_inputs*buffer_width-1 downto 0) := (others => '0');

begin
    --handles writing incoming data into the buffer. once the buffer is full, the read_from_buffer process sends off all the data to the FIFO.
    --this process then resets the buffer for the new incoming data. 
    write_to_buffer: process(fpga_clk, rst)
    begin
        if(buffer_en = '1') then
            if(rst = '1') then
                buffer_memory <= zero_buffer;
                counter <= 0;
            elsif(rising_edge(fpga_clk)) then
                buffer_memory(counter) <= data_in;
                counter <= counter + 1;
                if(counter = counter_max) then
                    counter <= 0;
                end if;
            end if;
        end if;
    end process;
     --sends the content of the buffer to the FIFO.       
    read_from_buffer: process(fifo_write_clk, rst)
    begin
        if(buffer_en = '1') then
            if(rst = '1') then
                data_out_temp <= (others => '0');
            elsif(rising_edge(fifo_write_clk)) then   --send the whole content of the buffer to the fifo. The format is [ckt1_sample1 , cktN_sample1, ... , ckt1_sample2, ... cktN_sample2, ...]
                for i in 0 to buffer_width-1 loop
                    data_out_temp(num_of_inputs*(i+1)-1 downto num_of_inputs*i) <= buffer_memory(i);
                end loop;
            end if;
        end if;      
    end process;
    
    data_out <= data_out_temp;
    
end Behavioral;
