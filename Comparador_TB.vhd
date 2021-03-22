library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity tb_comparator_8bits is 
end tb_comparator_8bits;

architecture tb of tb_comparator_8bits is

    component comparator_8bits is
        port (
            A : in std_logic_vector(7 downto 0);
            B : in std_logic_vector(7 downto 0);
            A_less_B : out std_logic  
        );
    end component;

    signal A : std_logic_vector(7 downto 0);
    signal B : std_logic_vector(7 downto 0);
    signal A_less_B : std_logic;

    -- Sinais para teste
    signal TESTE_LESS : std_logic;

    file input_file : text;

begin 
    dut: entity work.comparator_8bits 
        port map(
            A => A,
            B => B,
            A_less_B => A_less_B
        );
    
    tb_proc: process
    variable input_file_read : line; 
    variable input_file_col1 : std_logic_vector(7 downto 0); -- A 
    variable input_file_col2 : std_logic_vector(7 downto 0); -- B
    variable input_file_col3 : std_logic; -- A_less_B
    variable input_file_space : character; 

    begin 
        file_open(input_file, "file_comparador.txt", read_mode);

        while not endfile(input_file) loop 
            -- Entrada de dados do arquivo
            readline(input_file,input_file_read);
            read(input_file_read,input_file_col1);
            read(input_file_read,input_file_space);
            read(input_file_read,input_file_col2);
            read(input_file_read,input_file_space);
            read(input_file_read,input_file_col3);

            -- Associação 
            A <= input_file_col1;
            B <= input_file_col2;
            TESTE_LESS <= input_file_col3;

            -- Verificação dos resultados
            assert A_less_B = TESTE_LESS report "A nao e maior que B" severity note;

            wait for 15 ns;
        end loop;

        file_close(input_file);
        wait;
    end process tb_proc;
end tb;
