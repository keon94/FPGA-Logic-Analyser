--generates the FIFO write clock from the FPGA sampling clock
--The output will be a periodic pulse wave, whose frequency is a specified fraction (1/N) of the FPGA sampling clock - each pulse will signal the FIFO to accept a write from the buffer.
--The Fraction N is determined by the logic analyser module: It must be equal to the width of the buffer: that is, the number of cycles needed to fill the buffer. 

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity write_clk_generator is
    generic(
        N : integer     --N is the factor by which we slow down the FIFO write clock relative to the FPGA sampling clock
    );
    port(
        signal fifo_write_clk_en     : in std_logic;
        signal fpga_clk              : in std_logic;
        signal fifo_write_clk        : out std_logic;
        signal off_time_factor       : out integer range 1 to 31 --Used by the read synchroniser module, which is disabled, hence this is irrelevant
    );
end write_clk_generator;

architecture Behavioral of write_clk_generator is

signal clk_by_N : std_logic := '0';

begin


divider_process: process(fpga_clk)
variable counter : integer := 0; 
begin
        if(rising_edge(fpga_clk)) then
            if(counter = N - 1) then
                clk_by_N <= '1';            --make the pulse for one cycle
                counter := 0;
            else
                clk_by_N <= '0';            --reset the write clk to 0. wait until N cycles pass.
                counter := counter + 1;
            end if;
        end if;
end process;


fifo_write_clk <= '0'       when fifo_write_clk_en = '0' else
                  fpga_clk  when N < 2 else 
                  clk_by_N;
off_time_factor <= N;

end Behavioral;
