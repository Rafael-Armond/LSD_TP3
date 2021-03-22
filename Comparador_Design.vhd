library ieee;
use ieee.std_logic_1164.all;

entity comparador_8bits is
    Port ( A,B : in std_logic_vector(0 to 7);
           S   : out std_logic);
end comparador_8bits;

architecture comp_arch of comparador_8bits is
  begin
    comp: process(A,B)
     begin
      if A<B then
        S <= '1';
	  else 
	    S <= '0';
      end if;
    end process comp;
end comp_arch;