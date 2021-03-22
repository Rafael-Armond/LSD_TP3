library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all;


entity tb_rtl is
end tb_rtl;

architecture tb of tb_rtl is

    signal s   : std_logic_vector (7 downto 0);
    signal a   : std_logic_vector (7 downto 0);
    signal c   : std_logic;
    signal clk : std_logic := '1';
    signal clr : std_logic;
    signal d   : std_logic;
    constant T : time := 20 ns; 
    signal CLK_ENABLE : std_logic := '1';
    file input_buf : text;

begin

    dut : entity work.rtl
    port map (s   => s,
              a   => a,
              c   => c,
              clk => clk,
              clr => clr,
              d   => d);
	clk <= CLK_ENABLE and not clk after T/2;

    stimuli : process
    
     variable read_col_from_input_buf : line; 

    variable val_col1, val_col2, val_col3, val_col4, val_col5, val_col6,
    val_col7, val_col8: std_logic;
    
    variable val_SPACE : character;
    begin
        
        file_open(input_buf, "dados.txt",  read_mode); 

        while not endfile(input_buf) loop
        
        readline(input_buf, read_col_from_input_buf);
        
          read(read_col_from_input_buf, val_col1);
          read(read_col_from_input_buf, val_col2);
          read(read_col_from_input_buf, val_col3);
          read(read_col_from_input_buf, val_col4);
          read(read_col_from_input_buf, val_col5);
          read(read_col_from_input_buf, val_col6);
          read(read_col_from_input_buf, val_col7);
          read(read_col_from_input_buf, val_col8);
          
          s <= std_logic_vector(val_col1&val_col2&val_col3&val_col4&val_col5&val_col6&val_col7&val_col8);
          read(read_col_from_input_buf, val_SPACE);
          
          read(read_col_from_input_buf, val_col1);
          read(read_col_from_input_buf, val_col2);
          read(read_col_from_input_buf, val_col3);
          read(read_col_from_input_buf, val_col4);
          read(read_col_from_input_buf, val_col5);
          read(read_col_from_input_buf, val_col6);
          read(read_col_from_input_buf, val_col7);
          read(read_col_from_input_buf, val_col8);
          
          a <= std_logic_vector(val_col1&val_col2&val_col3&val_col4&val_col5&val_col6&val_col7&val_col8);
          
          read(read_col_from_input_buf, val_SPACE);
          
          read(read_col_from_input_buf, val_col1);
          
          
          c <= val_col1;
          
          
          read(read_col_from_input_buf, val_SPACE);
          
          read(read_col_from_input_buf, val_col1);
          
          clr <= val_col1;
          
          
          read(read_col_from_input_buf, val_SPACE);
          
          
          wait until rising_edge(CLK);

        end loop;
        
        file_close(input_buf); 
        wait for 5*T;
        CLK_ENABLE <= '0';     

        wait;
    end process;

end tb;
