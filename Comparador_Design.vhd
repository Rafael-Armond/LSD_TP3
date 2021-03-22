-- Comparador de 8 bits
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity comparador_8bits is
    Port ( A,B : in std_logic_vector(7 downto 0);
           S   : out std_logic);
end comparador_8bits;

architecture comp_arch of comparador_8bits is
  begin
    comp: process
     begin
      if A<B then
        S <= '1';
      else 
        S <= '0';
      end if;
    end process comp;
end comp_arch;