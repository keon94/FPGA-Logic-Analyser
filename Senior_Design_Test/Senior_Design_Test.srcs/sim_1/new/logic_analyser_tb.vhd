--A  general purpose testbench that tests the logic_analyser.vhd module. 
--It generates random data for the analyser in regular intervals, independent of the FPGA and USB clocks, and out of phase with both.
--The USB clock operates at a different (lower) frequency than the FPGA clock, and it is out of phase with it

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;
use ieee.numeric_std.all;

entity logic_analyser_tb is
end logic_analyser_tb;

architecture Behavioral of logic_analyser_tb is

constant clk_period : time := 10 ns;        --clock period for the fpga (the sampling rate)
constant usb_clk_period : time := 100 ns;    --clock period for the usb - must be longer than the clk period of the FIFO Write Clock, which is the fpga_clk_period*buffer_width
--constant data_clk_period : time := 15 ns;   --The rate at which random data is generated

--Required by the logic_anaylser module
constant n_of_inputs : integer := 2;    --number of external inputs (circuit nodes under measurement: target = 4)
constant b_width : integer := 4;        -- width of the buffer: for example, if set to 16 (and 4 for n_of_inputs) -> 16*4=64 is thus the width of the fifo
constant fifo_mem_size : integer := 8;  -- depth of the fifo

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
        --data_in             : in std_logic_vector(n_of_inputs-1 downto 0);
        data_out            : out std_logic_vector(b_width*n_of_inputs-1 downto 0);
        fifo_remaining_data : out integer range 0 to fifo_mem_size  
    );
end component;

signal rst, clk, usb_clk, read_en : std_logic := '0';
--signal data_in                    : std_logic_vector(n_of_inputs-1 downto 0) := (others => '0');
signal data_out                   : std_logic_vector(b_width*n_of_inputs-1 downto 0);
signal fifo_remaining_data        : integer range 0 to fifo_mem_size := 0;

-- introduce a clock lag (phase difference) for the usb and data relative to the fpga clock. This simulates additional realism.
signal initial_usb_delay_flag     : std_logic := '0';
signal initial_usb_delay          : time := 23ns;       --made up number
--signal initial_data_delay_flag    : std_logic := '0';
--signal initial_data_delay         : time := 17ns;       --made up number

--Required by the random data generator
--signal rand_num : integer := 0;

begin

    uut: logic_analyser port map(
        rst => rst,
        clk => clk,
        usb_clk => usb_clk,
        read_en => read_en,
        --data_in => data_in,
        data_out => data_out, 
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
        if(initial_usb_delay_flag = '0') then  --perform an initial delay for the purposes of realism (create a phase lag)
          initial_usb_delay_flag <= '1';
          wait for initial_usb_delay;
        end if;  
        usb_clk <= '0';
        wait for usb_clk_period/2;
        usb_clk <= '1';
        wait for usb_clk_period/2;    
    end process;

--  ***DATA IS CONTROLLED BY THE INPUT GENERATOR    
--    data_insertion : process
--        variable seed1, seed2: positive;               -- seed values for the random generator
--        variable rand: real;                            -- random real-number value in range 0 to 1.0  
--        variable range_of_rand : real := Real(2**n_of_inputs - 1);  --the max randomly generated data  
--    begin
--        if(initial_data_delay_flag = '0') then      --perform an initial delay for the purposes of realism (create a phase lag)
--          initial_data_delay_flag <= '1';
--          wait for initial_data_delay;
--        end if;        
--        uniform(seed1, seed2, rand);   -- generate random data
--        data_in <= std_logic_vector(to_unsigned(integer(rand*range_of_rand),n_of_inputs));  --vectorise the random data and send it to the logic analyser      
--        wait for data_clk_period;     
--    end process;
        
    
    process
    begin
        --turn read_en on and off at random times
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
