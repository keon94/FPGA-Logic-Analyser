--Ensures that read speeds do not exceed the write speeds of the FIFO. If that does happen, the FIFO can terminate
--operation prematurely, thus this unit is necessary.
----------------------------------------------------------------------------------

--This unit was intended to make sure that read speeds don't exceed write speeds, for if they do, the FIFO can come to a premature stop. 
--If such were to happen, this unit would null out the read_en signal if it were on; restoring it after a sufficient amount of time had passed.
--Currently this unit is disabled, and does nothing

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity read_synchroniser is
    Port(
        read_en : in std_logic;
        fpga_clk : in std_logic;
        min_off_time: in integer;
        read_en_out : out std_logic    
    );
end read_synchroniser;

architecture Behavioral of read_synchroniser is

signal counter : integer := 0;

begin

--process(fpga_clk) 
--begin
--    if(rising_edge(fpga_clk)) then
--        if(counter < min_off_time and read_en = '1') then
--            read_en_out <= '0';
--            counter <= counter + 1;
--        else
--            counter <= 0;
--            read_en_out <= read_en;
--        end if;
--    end if;
--end process;
       
read_en_out <= read_en;

end Behavioral;
