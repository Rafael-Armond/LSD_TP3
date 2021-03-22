library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity tb_comparador is 
end tb_comparador;

architecture tb of tb_comparador is

    component comparador_8bits is
        port (
            A,B : in std_logic_vector(7 downto 0);
            S : out std_logic  
        );
    end component;

    signal A : std_logic_vector(7 downto 0);
    signal B : std_logic_vector(7 downto 0);
    signal S : std_logic;

    -- Sinais para teste
    signal TESTE_S : std_logic;

    file input_file : text;

begin 
    dut: entity work.comparador_8bits 
        port map(
            A => A,
            B => B,
            S => S
        );
    
    tb_proc: process
    variable input_file_read : line; 
    variable input_file_col1 : std_logic_vector(7 downto 0); -- A
    variable input_file_col2 : std_logic_vector(7 downto 0); -- B
    variable input_file_col3 : std_logic; -- S
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
            TESTE_S <= input_file_col3;

            -- Verificação dos resultados
            assert S = TESTE_S report "Soma nao e igual" severity note;

            wait for 15 ns;
        end loop;

        file_close(input_file);
        wait;
    end process tb_proc;
end tb;