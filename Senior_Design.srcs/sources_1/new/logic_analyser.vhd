

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity logic_analyser is
    generic(   
        n_of_inputs : integer := 2;
        b_width : integer := 4;
        fifo_mem_size : integer := 8   
    );

    Port ( 
        rst : in std_logic;
        clk : in std_logic;
        usb_clk : in std_logic;
        read_en : in std_logic;
        data_in : in std_logic_vector(n_of_inputs-1 downto 0);
        data_out : out std_logic_vector(b_width*n_of_inputs-1 downto 0);
        fifo_total_data : out integer;
        fifo_remaining_data : out integer range 0 to fifo_mem_size
    );
end logic_analyser;

architecture Behavioral of logic_analyser is

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
        signal total_data_recvd     : out integer;
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

component clk_generator
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

constant clk_division_factor : integer := b_width;
constant fifo_mem_width : integer := b_width*n_of_inputs;

signal write_clk, fifo_state, read_en_to_fifo : std_logic;
signal data_from_buffer : std_logic_vector(fifo_mem_width-1 downto 0);
signal write_off_time : integer;

begin

u_read_sync: read_synchroniser port map
            (
                read_en => read_en,
                fpga_clk => clk,
                min_off_time => write_off_time,
                read_en_out => read_en_to_fifo
            );
            

u_clk_gen: clk_generator generic map
            (
                N => clk_division_factor
            )
            port map 
            (
                fpga_clk => clk,
                fifo_write_clk => write_clk,
                off_time_factor => write_off_time              
            );

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
                buffer_en => fifo_state,
                data_in => data_in,
                data_out => data_from_buffer
            );
            

u_fifo: FIFO generic map
            (
                mem_size => fifo_mem_size, 
                mem_width => fifo_mem_width
            ) port map(
                fifo_write_clk => write_clk,
                usb_read_clk => usb_clk,
                read_en => read_en_to_fifo,
                rst => rst,
                data_in => data_from_buffer,
                data_out => data_out,
                fifo_state => fifo_state,
                total_data_recvd => fifo_total_data,
                num_of_data => fifo_remaining_data
            );

end Behavioral;
