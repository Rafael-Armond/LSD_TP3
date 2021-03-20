-- Comparador de 8 bits
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity comparador_8bits is
    Port ( A,B : in std_logic_vector(0 to 7);
           G,S,E: out std_logic);
end comparador_8bits;

architecture comp_arch of comparador_8bits is
  begin
    comp: process
     begin
      if A=B then
        G <= '0';
        S <= '0';
        E <= '1';
      elsif A>B then
        G <= '1';
        S <= '0';
        E <= '0';
      elsif A<B then
        G <= '0';
        S <= '1';
        E <= '0';
      end if;
    end process comp;
end comp_arch;