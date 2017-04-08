

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity logic_analyser is
    generic(   
        n_of_inputs                 : integer := 2;    --Number of inputs we are sampling
        b_width                     : integer := 4;    --Number of samples per input that the buffer can store. 
                                                       --This number times n_of_inputs is the total data that a FIFO row will contain.
        fifo_mem_size               : integer := 8     --Depth of the FIFO
    );

    Port ( 
        rst                         : in std_logic;     --an asynchronous master reset signal ... clears all data in the entire circuit
        clk                         : in std_logic;     --The FPGA sampling clock (determined by the control unit)
        usb_clk                     : in std_logic;     --The USB clock -- independent 
        read_en                     : in std_logic;     --The read enable signal supplied by the USB. The USB reads from a FIFO row when this is high and we are on the rising edge of the usb clock
--Overridden by the InputGen output
--        data_in                     : in std_logic_vector(n_of_inputs-1 downto 0);  --a vector of data coming from external circuits - (1 bit per circuit-node)
        data_out                    : out std_logic_vector(b_width*n_of_inputs-1 downto 0); --the vector contained in a FIFO row, given to the USB at every read. 
                                                                                            --The format is: [ckt1_sample1 , cktN_sample1, ... , ckt1_sample2, ... cktN_sample2, ...]
        fifo_remaining_data         : out integer range 0 to fifo_mem_size          --keeps track of the the total number of data remaining in the FIFO (to be read). Updated everytime a read/write to the FIFO happens
    );
end logic_analyser;

architecture Behavioral of logic_analyser is

component input_generator
generic(
    num_of_inputs : integer
);
Port(
    rst : in std_logic;
    clk : in std_logic;         --FPGA clk
    clk_out: out std_logic;     --FPGA sampling clk
    ckt_input : out std_logic_vector(1 downto 0);
    ckt_rst : out std_logic;
    read_en : out std_logic     --for testing only. On the Kelly board, the usb will have this signal.
);
end component;

component FIFO
    generic(
        mem_size : integer;
        mem_width : integer
    );
    port(
        signal fifo_write_clk       : in std_logic;
        signal usb_read_clk         : in std_logic;
        signal read_en              : in std_logic;
        signal rst                  : in std_logic;
        signal data_in              : in std_logic_vector(mem_width-1 downto 0);
        signal data_out             : out std_logic_vector(mem_width-1 downto 0);
        signal fifo_state           : out std_logic;
        signal num_of_data          : out integer range 0 to mem_size        
    );  
end component;

component Input_Buffer
    generic(
        num_of_inputs : integer;
        buffer_width : integer
    );
    
    port(
        fpga_clk : in std_logic;
        fifo_write_clk : in std_logic;
        rst : in std_logic;
        buffer_en : in std_logic;
        data_in : in std_logic_vector(num_of_inputs-1 downto 0);
        data_out : out std_logic_vector(num_of_inputs*buffer_width-1 downto 0)
    );
end component;

component write_clk_generator
    generic(
        N : integer
    );
    port(
        signal fpga_clk : in std_logic;
        signal fifo_write_clk : out std_logic;
        signal off_time_factor : out integer 
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
signal write_clk, fifo_state, read_en_to_fifo   : std_logic;    --bunch of intermediate signals. refer to the elaborated schmatic for details.
                                                                --Note: FIFO state is a feedback signal from the FIFO, indicating whether it is full. If it is, the logic analyser shall cease data-intake operations.
signal data_from_buffer                         : std_logic_vector(fifo_mem_width-1 downto 0); --the data sent from the buffer to a FIFO row. The size is = to the total buffer size = FIFO width size
signal write_off_time                           : integer;  --unneeded for now, provided that we don't make use of the read sunchroniser module

--For InputGen Purpose Signals
signal data_in                                  : std_logic_vector(n_of_inputs-1 downto 0);
signal slow_fpga_clk                                 : std_logic; --the fpga clk (sampling clk) coming from input_gen
signal generated_rst                            : std_logic; --the reset coming from input_gen
signal effective_rst                            : std_logic; -- rst OR gen_rst

begin

effective_rst <= rst or generated_rst;

u_input_gen: input_generator generic map
            (
                num_of_inputs => n_of_inputs
            )
            port map
            (
                rst => rst,
                clk => clk,
                clk_out => slow_fpga_clk, 
                ckt_input => data_in,
                ckt_rst => generated_rst,
                read_en => open
            );




--Currently this accomplishes nothing, so ignore it.
--u_read_sync: read_synchroniser port map
--            (
--                read_en => read_en,
--                fpga_clk => clk,
--                min_off_time => write_off_time,
--                read_en_out => read_en_to_fifo
--            );
            
--Generates the write clock for the FIFO
u_clk_gen: write_clk_generator generic map
            (
                N => clk_division_factor
            )
            port map 
            (
                fpga_clk => slow_fpga_clk,
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
                fpga_clk => slow_fpga_clk,
                fifo_write_clk => write_clk,
                rst => effective_rst,
                buffer_en => fifo_state,
                data_in => data_in,
                data_out => data_from_buffer
            );
            
--The FIFO itself
u_fifo: FIFO generic map
            (
                mem_size => fifo_mem_size, 
                mem_width => fifo_mem_width
            ) port map(
                fifo_write_clk => write_clk,
                usb_read_clk => usb_clk,
                read_en => read_en,
                rst => effective_rst,
                data_in => data_from_buffer,
                data_out => data_out,
                fifo_state => fifo_state,
                num_of_data => fifo_remaining_data
            );
            

end Behavioral;
