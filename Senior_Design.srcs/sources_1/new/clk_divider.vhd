

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_generator is
    generic(
        N : integer
    );
    port(
        signal fpga_clk : in std_logic;
        signal fifo_write_clk : out std_logic;
        signal off_time_factor : out integer range 1 to 31
    );
end clk_generator;

architecture Behavioral of clk_generator is

signal clk_by_N : std_logic := '0';

begin


divider_process: process(fpga_clk)
variable counter : integer := 0; 
begin
        if(rising_edge(fpga_clk)) then
            if(counter = N - 1) then
                clk_by_N <= '1';
                counter := 0;
            else
                clk_by_N <= '0';
                counter := counter + 1;
            end if;
        end if;
end process;


fifo_write_clk <= fpga_clk when N < 2 else clk_by_N;
off_time_factor <= N;

end Behavioral;
