

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity input_buffer is

generic(
    num_of_inputs : integer;
    buffer_width : integer
);

Port (
    fpga_clk : in std_logic;
    fifo_write_clk : in std_logic;
    rst : in std_logic;
    buffer_en : in std_logic;
    data_in : in std_logic_vector(num_of_inputs-1 downto 0);
    data_out : out std_logic_vector(num_of_inputs*buffer_width-1 downto 0)
 );
 
end input_buffer;

architecture Behavioral of input_buffer is

type buffer_mem is array(0 to buffer_width-1) of std_logic_vector(num_of_inputs-1 downto 0);

signal zero_buffer : buffer_mem := (others => (others => '0'));
signal buffer_memory : buffer_mem := zero_buffer;
signal counter : integer := 0;
signal counter_max : integer := buffer_width - 1;
signal data_out_temp : std_logic_vector(num_of_inputs*buffer_width-1 downto 0) := (others => '0');

begin

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
            
    read_from_buffer: process(fifo_write_clk, rst)
    begin
        if(buffer_en = '1') then
            if(rst = '1') then
                data_out_temp <= (others => '0');
            elsif(rising_edge(fifo_write_clk)) then
                for i in 0 to buffer_width-1 loop
                    data_out_temp(num_of_inputs*(i+1)-1 downto num_of_inputs*i) <= buffer_memory(i);
                end loop;
            end if;
        end if;      
    end process;
    
    data_out <= data_out_temp;
    
end Behavioral;
