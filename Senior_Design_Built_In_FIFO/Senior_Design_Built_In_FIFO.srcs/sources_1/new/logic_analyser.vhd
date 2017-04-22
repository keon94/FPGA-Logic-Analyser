

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.math_real.all;

entity logic_analyser is
    generic(   
        n_of_inputs                 : integer := 4;    --Number of inputs we are sampling
        b_width                     : integer := 4;    --Number of samples per input that the buffer can store. 
                                                       --This number times n_of_inputs is the total data that a FIFO row will contain.
        fifo_mem_size               : integer := 32768    --Depth of the FIFO
    );

    Port ( 
        rst                         : in std_logic;     --an asynchronous master reset signal ... clears all data in the entire circuit
        clk                         : in std_logic;     --The FPGA sampling clock (determined by the control unit)
        usb_clk                     : in std_logic;     --The USB clock -- independent 
        read_en                     : in std_logic;     --The read enable signal supplied by the USB. The USB reads from a FIFO row when this is high and we are on the rising edge of the usb clock
        data_in                     : in std_logic_vector(n_of_inputs-1 downto 0);  --a vector of data coming from external circuits - (1 bit per circuit-node)
        data_out                    : out std_logic_vector(b_width*n_of_inputs-1 downto 0); --the vector contained in a FIFO row, given to the USB at every read. 
                                                                                            --The format is: [ckt1_sample1 , ... , cktN_sample1 , ... , ckt1_sample2, ... cktN_sample2, ...]
        fifo_remaining_data         : out std_logic_vector(integer(log2(real(fifo_mem_size)))-1 downto 0)          --keeps track of the the total number of data remaining in the FIFO (to be read). Updated everytime a read/write to the FIFO happens
    );
end logic_analyser;

architecture Behavioral of logic_analyser is

component FIFO
    generic(
        mem_size : integer;
        mem_width : integer
    );
    port(
        signal fpga_clk             : in std_logic;
        signal fifo_write_clk       : in std_logic;
        signal usb_read_clk         : in std_logic;
        signal read_en              : in std_logic;
        signal rst                  : in std_logic;
        signal data_in              : in std_logic_vector(mem_width-1 downto 0);
        signal data_out             : out std_logic_vector(mem_width-1 downto 0);
        signal fifo_full            : out std_logic;
        signal num_of_data          : out std_logic_vector(integer(log2(real(fifo_mem_size)))-1 downto 0)     
    );  
end component;

component Input_Buffer
    generic(
        num_of_inputs : integer;
        buffer_width : integer
    );
    
    port(
        fpga_clk                        : in std_logic;
        fifo_write_clk                  : in std_logic;
        rst                             : in std_logic;
        buffer_en                       : in std_logic;
        data_in                         : in std_logic_vector(num_of_inputs-1 downto 0);
        data_out                        : out std_logic_vector(num_of_inputs*buffer_width-1 downto 0)
    );
end component;

component write_clk_generator
    generic(
        N : integer
    );
    port(
        signal fifo_write_clk_en        : in std_logic;
        signal fpga_clk                 : in std_logic;
        signal fifo_write_clk           : out std_logic;
        signal off_time_factor          : out integer 
    );
end component;

component read_synchroniser is
    Port(
        read_en : in std_logic;
        fpga_clk : in std_logic;
        min_off_time: in integer;
        read_en_out : out std_logic    
    );
end component;

constant clk_division_factor                    : integer := b_width;   --the factor by which we will need to slow the write clk to the FIFO. 
                                                                        --this slow down is necessary because it takes b_width cycles for the buffer to fill up, at which point can writing to the FIFO occur.
constant fifo_mem_width                         : integer := b_width*n_of_inputs; --the number of bits in the FIFO's width (row)
signal write_clk, fifo_full, read_en_to_fifo    : std_logic;    --bunch of intermediate signals. refer to the elaborated schmatic for details.
                                                                --Note: FIFO state is a feedback signal from the FIFO, indicating whether it is full. If it is, the logic analyser shall cease data-intake operations.
signal data_from_buffer                         : std_logic_vector(fifo_mem_width-1 downto 0); --the data sent from the buffer to a FIFO row. The size is = to the total buffer size = FIFO width size
signal write_off_time                           : integer;  --unneeded for now, provided that we don't make use of the read sunchroniser module
signal write_clk_en                             : std_logic := '1';
signal buffer_en                                : std_logic := '1';

begin

write_clk_en <= buffer_en;

process(fifo_full)
begin
    if(rising_edge(fifo_full) and buffer_en <= '1') then
        buffer_en <= '0';
    end if;
end process;


u_clk_gen: write_clk_generator generic map
            (
                N => clk_division_factor
            )
            port map 
            (
                fifo_write_clk_en => write_clk_en,
                fpga_clk => clk,
                fifo_write_clk => write_clk,
                off_time_factor => write_off_time              
            );
--The intermediate buffer stage that prepares the data for a FIFO row
u_buffer: input_buffer generic map
            (
                num_of_inputs => n_of_inputs,
                buffer_width => b_width
            )
            port map
            (
                fpga_clk => clk,
                fifo_write_clk => write_clk,
                rst => rst,
                buffer_en => buffer_en,
                data_in => data_in,
                data_out => data_from_buffer
            );
            
--The FIFO itself
u_fifo: FIFO generic map
            (
                mem_size => fifo_mem_size, 
                mem_width => fifo_mem_width
            ) port map(
                fpga_clk => clk,
                fifo_write_clk => write_clk,
                usb_read_clk => usb_clk,
                read_en => read_en,
                rst => rst,
                data_in => data_from_buffer,
                data_out => data_out,
                fifo_full => fifo_full,
                num_of_data => fifo_remaining_data
            );

end Behavioral;
