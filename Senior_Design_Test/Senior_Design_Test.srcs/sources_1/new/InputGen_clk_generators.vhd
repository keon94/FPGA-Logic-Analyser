

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_generator is
    generic(
        N : integer     --The factor by which we are dividing the frequency
    );
    port(
        signal clk_in : in std_logic;
        signal clk_out : out std_logic
    );
end clk_generator;

architecture PulseGenerator of clk_generator is     -- the waveforms will look like: ___||___||___||____

signal clk_by_N : std_logic := '0';

begin

process(clk_in)
variable counter : integer := 0; 
begin
        if(rising_edge(clk_in)) then
            if(counter >= N - 1) then
                clk_by_N <= '1';
                counter := 0;
            else
                clk_by_N <= '0';
                counter := counter + 1;
            end if;
        end if;
end process;


clk_out <= clk_in when N < 2 else clk_by_N;

end PulseGenerator;

architecture FreqDivider of clk_generator is

signal clk_out_temp: STD_LOGIC := '0';
signal counter : integer range 0 to N - 1 := 0;

begin

    process (clk_in) begin
        if rising_edge(clk_in) then
            if (counter = N - 1) then
                clk_out_temp <= NOT(clk_out_temp);
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    
    clk_out <= clk_out_temp;

end FreqDivider;

