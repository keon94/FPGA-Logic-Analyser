----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/25/2016 09:57:13 AM
-- Design Name: 
-- Module Name: FIFO_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity FIFO_tb is
--  Port ( );
end FIFO_tb;

architecture Behavioral of FIFO_tb is

component FIFO

    generic(
        mem_size : integer;
        mem_width : integer
    );
    port(
        signal write_clk            : in std_logic;
        signal read_en             : in std_logic;
        signal rst                  : in std_logic;
        signal data_in              : in std_logic_vector(mem_width-1 downto 0);
        signal data_out             : out std_logic_vector(mem_width-1 downto 0)
    );
    
end component;

constant clk_period : time := 10 ns;
constant read_factor : integer := 5;

signal write_clk , read_en, rst : std_logic;
signal data_in, data_out : std_logic_vector(3 downto 0);

begin

fifo_pm: FIFO generic map (mem_size => 8, mem_width => 4) port map(
        write_clk => write_clk,
        read_en => read_en,
        rst => rst,
        data_in => data_in,
        data_out => data_out
);

w_clk_process :process
    begin
        write_clk <= '0';
        wait for clk_period/2;
        write_clk <= '1';
        wait for clk_period/2;
end process;

r_clk_process :process
    begin
        read_en <= '1';
        wait for clk_period;
        read_en <= '0';
        wait for read_factor*clk_period/2;
end process;

process begin

rst <= '1';
wait for 0ns;
rst <= '0';
data_in <= "0000";

wait for clk_period;

data_in <= "0001";

wait for clk_period;

data_in <= "0010";

wait for clk_period;
data_in <= "0011";
wait for clk_period;
data_in <= "0100";
wait for clk_period;
data_in <= "0101";
wait for clk_period;
data_in <= "0110";
wait for clk_period;
data_in <= "0111";
wait for clk_period;
data_in <= "1000";
wait for clk_period;
data_in <= "1001";
wait for clk_period;
data_in <= "1010";
wait for clk_period;
data_in <= "1011";
wait for clk_period;
data_in <= "1100";
wait for clk_period;
wait;

end process;


end Behavioral;
