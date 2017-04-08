----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/26/2016 12:19:35 PM
-- Design Name: 
-- Module Name: clk_divider_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clk_generator_tb is
end clk_generator_tb;

architecture Behavioral of clk_generator_tb is
    component clk_generator
        port(
            signal clk_sel : in std_logic_vector(1 downto 0);
            signal fpga_clk : in std_logic;
            signal fifo_write_clk : out std_logic;
            signal fifo_read_en : out std_logic  
        );
    end component;
    
    signal clk_sel : std_logic_vector(1 downto 0) := "00";
    signal fpga_clk, fifo_write_clk, fifo_read_en : std_logic := '0';
    
    constant clk_period : time := 10 ns;
    
    
begin
    uut: clk_generator port map (
                    clk_sel => clk_sel,
                    fpga_clk => fpga_clk,
                    fifo_write_clk => fifo_write_clk,
                    fifo_read_en => fifo_read_en
                   );

    clk_process :process
    begin
        fpga_clk <= '0';
        wait for clk_period/2;
        fpga_clk <= '1';
        wait for clk_period/2;
    end process;
    
    uut_process: process
    begin
    
        clk_sel <= "01";
        
        wait for 6*clk_period;
        
        
        wait for 10*clk_period;
        
        
        wait for 10*clk_period;
        
        
        wait for 10*clk_period;
        
        wait;
        
    end process;
    
    
end Behavioral;
