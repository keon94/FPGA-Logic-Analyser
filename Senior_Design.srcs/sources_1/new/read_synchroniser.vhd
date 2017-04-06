--Ensures that read speeds do not exceed the write speeds of the FIFO. If that does happen, the FIFO can terminate
--operation prematurely, thus this unit is necessary.
----------------------------------------------------------------------------------


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
