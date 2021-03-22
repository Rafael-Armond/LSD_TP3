library ieee;
use ieee.std_logic_1164.all;
use std.textio.all;
use ieee.std_logic_textio.all;

entity tb_ripple_carry is 
end tb_ripple_carry;

architecture tb of tb_ripple_carry is

    component ripple_carry is
        port (
            A : in std_logic_vector(7 downto 0);
            B : in std_logic_vector(7 downto 0);
            CARRY_IN : in std_logic;
            S : out std_logic_vector(7 downto 0);
            CARRY_OUT : out std_logic  
        );
    end component;

    signal A : std_logic_vector(7 downto 0);
    signal B : std_logic_vector(7 downto 0);
    signal CARRY_IN : std_logic;
    signal S : std_logic_vector(7 downto 0);
    signal CARRY_OUT : std_logic;

    -- Sinais para teste
    signal TESTE_SOMA : std_logic_vector(7 downto 0);
    signal TESTE_CARRY_OUT : std_logic;

    file input_file : text;

begin 
    dut: entity work.ripple_carry 
        port map(
            A => A,
            B => B,
            CARRY_IN => CARRY_IN,
            S => S,
            CARRY_OUT => CARRY_OUT
        );
    
    tb_proc: process
    variable input_file_read : line; 
    variable input_file_col1 : std_logic_vector(7 downto 0); 
    variable input_file_col2 : std_logic_vector(7 downto 0); 
    variable input_file_col3 : std_logic; 
    variable input_file_col4 : std_logic_vector(7 downto 0); 
    variable input_file_col5 : std_logic; 
    variable input_file_space : character; 

    begin 
        file_open(input_file, "file_somador.txt", read_mode);

        while not endfile(input_file) loop 
            -- Entrada de dados do arquivo
            readline(input_file,input_file_read);
            read(input_file_read,input_file_col1);
            read(input_file_read,input_file_space);
            read(input_file_read,input_file_col2);
            read(input_file_read,input_file_space);
            read(input_file_read,input_file_col3);
            read(input_file_read,input_file_space);
            read(input_file_read,input_file_col4);
            read(input_file_read,input_file_space);
            read(input_file_read,input_file_col5);

            -- Associação 
            A <= input_file_col1;
            B <= input_file_col2;
            CARRY_IN <= input_file_col3;
            TESTE_SOMA <= input_file_col4;
            TESTE_CARRY_OUT <= input_file_col5;

            -- Verificação dos resultados
            assert S = TESTE_SOMA report "Soma nao e igual" severity note;
            assert CARRY_OUT = TESTE_CARRY_OUT report "Carry_out nao e igual" severity note;

            wait for 15 ns;
        end loop;

        file_close(input_file);
        wait;
    end process tb_proc;
end tb;