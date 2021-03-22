-- Registrador de 8 bits
library ieee;
use ieee.std_logic_1164.all;

entity registrador is 
    port(
        in1 : in std_logic_vector(7 downto 0);
        load, clk, clr : in std_logic;
        out1 : out std_logic_vector(7 downto 0)
    );
end registrador;

architecture reg_arch of registrador is 
begin 
    reg: process(clk,clr)
    begin 
        if clr = '1' then 
            out1 <= "00000000";
        elsif rising_edge(clk) and load = '1' then 
            out1 <= in1;
        end if;
    end process reg;
end reg_arch;