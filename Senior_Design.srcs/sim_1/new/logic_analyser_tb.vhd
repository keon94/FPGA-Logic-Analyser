

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use ieee.numeric_std.all;

entity logic_analyser_tb is
end logic_analyser_tb;

architecture Behavioral of logic_analyser_tb is

constant clk_period : time := 10 ns;
constant usb_clk_period : time := 50 ns;
constant data_clk_period : time := 15 ns;
constant n_of_inputs : integer := 2;
constant b_width : integer := 4;        -- width of the buffer: 16 for the project  -> 16*4=64 is thus the width of the fifo
constant fifo_mem_size : integer := 8;  -- depth of the fifo

--the read rate must at the very least be (ON AVERAGE) 16 times slower than the clk rate of the fpga = so > 160 ns. The read_synchroniser unit takes care of this.

component logic_analyser
    generic(   
        n_of_inputs         : integer := n_of_inputs;
        b_width             : integer := b_width;
        fifo_mem_size       : integer := fifo_mem_size    
    );
    port(
        rst                 : in std_logic;
        clk                 : in std_logic;
        usb_clk             : in std_logic;
        read_en             : in std_logic;
        data_in             : in std_logic_vector(n_of_inputs-1 downto 0);
        data_out            : out std_logic_vector(b_width*n_of_inputs-1 downto 0);
        fifo_total_data     : out integer;
        fifo_remaining_data : out integer range 0 to fifo_mem_size  
    );
end component;

signal rst, clk, usb_clk, read_en : std_logic := '0';
signal data_in                    : std_logic_vector(n_of_inputs-1 downto 0) := (others => '0');
signal data_out                   : std_logic_vector(b_width*n_of_inputs-1 downto 0);
signal fifo_total_data            : integer := 0;
signal fifo_remaining_data        : integer range 0 to fifo_mem_size := 0;
signal initial_usb_delay_flag     : std_logic := '0';
signal initial_usb_delay          : time := 23ns;
signal initial_data_delay_flag    : std_logic := '0';
signal initial_data_delay         : time := 17ns;

signal rand_num : integer := 0;

begin

    uut: logic_analyser port map(
        rst => rst,
        clk => clk,
        usb_clk => usb_clk,
        read_en => read_en,
        data_in => data_in,
        data_out => data_out, 
        fifo_total_data => fifo_total_data,
        fifo_remaining_data => fifo_remaining_data
    );
    
    clock: process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;    
    end process;
    
    usb_clock: process
    begin
        if(initial_usb_delay_flag = '0') then
          initial_usb_delay_flag <= '1';
          wait for initial_usb_delay;
        end if;  
        usb_clk <= '0';
        wait for usb_clk_period/2;
        usb_clk <= '1';
        wait for usb_clk_period/2;    
    end process;
    
    data_insertion : process
        variable seed1, seed2: positive;               -- seed values for random generator
        variable rand: real;   -- random real-number value in range 0 to 1.0  
        variable range_of_rand : real := 3.0;    
    begin
        if(initial_data_delay_flag = '0') then
          initial_data_delay_flag <= '1';
          wait for initial_data_delay;
        end if;        
        uniform(seed1, seed2, rand);   -- generate random data
        data_in <= std_logic_vector(to_unsigned(integer(rand*range_of_rand),2));        
        wait for data_clk_period;     
    end process;
        
    
    process
    begin
        read_en <= '0';
        wait for 104ns;
        read_en <= '1';
        wait for 151ns;
        read_en <= '0';
        wait for 241ns;
        read_en <= '1';
        wait for 261ns;
        read_en <= '0';
        wait for 225ns;        
        read_en <= '1';
        wait for 243ns;        
        read_en <= '0';
        wait for 261ns;        
        read_en <= '1';
        wait for 253ns;        
        read_en <= '0';
        wait for 198ns;        
        read_en <= '1';
        wait for 180ns;        
        read_en <= '0';
        wait for 176ns;
        read_en <= '1';
        wait for 126ns;
        read_en <= '0';
        wait for 148ns;        
        read_en <= '1';
        wait for 138ns; 
        read_en <= '0';
        wait for 152ns;        
        read_en <= '1';
        wait for 181ns; 
        read_en <= '0';
        wait for 156ns;        
        read_en <= '1';  
    end process;
    
    
end Behavioral;
