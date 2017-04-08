----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/07/2017 02:52:54 PM
-- Design Name: 
-- Module Name: InputGen - Behavioral
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
use ieee.numeric_std.all;

entity input_generator is
generic(
    initial_time_lag                    : integer := 8;    --the initial wait cycles (based on the slow_fpga_clk) before the data begins getting generated. added for the purposes of simulating realism. set to 0 if undesired.
    num_of_inputs                       : integer;        --controlled by the logic_analyser.vhd module. set it there.         
    division_factor                     : integer := 1;      --the factor by which we slow down the fpga clock (or the sampling clock) so we could see the fpga LEDs blink (on the nexys4). 
                                                                    --probably no longer needed. if so, set this to 1. 
    relative_input_gen_slow_down_rate   : integer := 3;  --the factor by which 
    relative_read_en_division_factor    : integer := 7
);
Port(
    rst : in std_logic;
    clk : in std_logic;         --FPGA clk
    clk_out: out std_logic;     --FPGA sampling clk
    ckt_input : out std_logic_vector(1 downto 0);
    ckt_rst : out std_logic;
    read_en : out std_logic     --for testing only. On the Kelly board, the usb will have this signal.
);
end input_generator;

architecture Behavioral of input_generator is


component clk_generator is
    generic(
        N : integer
    );
    Port (
        clk_in : in  STD_LOGIC;
        clk_out: out STD_LOGIC
    );
end component;


constant max_input_value            : integer := integer(2**num_of_inputs - 1);
signal input_value                  : integer range 0 to max_input_value := 1; --garbage init value
signal slow_fpga_clk                     : std_logic;            --the slowed down fpga clk for testable purposes (to be able to see the LED lights on the Nexys4). The slow down is determined division_factor.
                                                        --probably not needed hereafter. If so, set division_factor to 1. 
signal data_clk                     : std_logic;        --rate at which data is generated ... that is, the frequency of the external circuit. 
signal init_time_lag_has_passed     : std_logic := '0';
signal internal_rst                 : std_logic := '0';     --rst button managed by the input gen itself
signal lag_cycles_counter           : integer range 0 to initial_time_lag := 0;         --keeps track of the number of cycles passed until the lag time is over

begin

--slows down the sampling clock for test purposes (won't, if N = 1)   
u_clk_divider: entity work.clk_generator(FreqDivider) 
generic map
(
    N => division_factor
)
port map
(
    clk_in => clk,
    clk_out => slow_fpga_clk
);

clk_out <= slow_fpga_clk;

--slows down the rate of data gen. relative to the slow clk (won't, if N = 1)
u_inputData_divider: entity work.clk_generator(FreqDivider) 
generic map
(
    N => relative_input_gen_slow_down_rate
)
port map
(
    clk_in => slow_fpga_clk,
    clk_out => data_clk
);

---Generates the read_en signal in a ____||____||____ format (Used in previous tests.) Probably won't be used anymore.
u_read_en_impluse_train: entity work.clk_generator(PulseGenerator) 
generic map
(
    N => relative_read_en_division_factor
)
port map
(
    clk_in => slow_fpga_clk,
    clk_out => read_en
);

--introduces an initial time lag. None if inital_time_lag was set to 0
u_initial_lag: process(slow_fpga_clk)

begin
    if(init_time_lag_has_passed = '0' and rising_edge(slow_fpga_clk)) then
        if(lag_cycles_counter < initial_time_lag) then
            lag_cycles_counter <= lag_cycles_counter + 1;
        else
            init_time_lag_has_passed <= '1';
            internal_rst <= '1';
        end if;
    elsif(internal_rst = '1') then
        internal_rst <= '0';
    end if;   
end process;

--Generate Input Pattern at every rising edge of the data_clk
u_input_generator: process(data_clk, rst)
begin
    if(rst = '1' or internal_rst = '1') then
        input_value <= 0;  
    elsif(init_time_lag_has_passed = '1' and rising_edge(data_clk)) then
        if(input_value = max_input_value) then
            input_value <= 0;
        else
            input_value <= input_value + 1;
        end if;
    end if;    
end process;

ckt_input <= std_logic_vector(to_unsigned(input_value , num_of_inputs)); 
ckt_rst <= not init_time_lag_has_passed;
   
end Behavioral;
