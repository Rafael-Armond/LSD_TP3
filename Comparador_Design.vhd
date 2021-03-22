-- Comparador de 2 bits
library IEEE;
use IEEE.std_logic_1164.all;
entity comparator_VHDL is
  port (
        A,B: in std_logic; 
        A_less_B: out std_logic 
  );
end comparator_VHDL;
architecture comparator_structural of comparator_VHDL is

begin

  A_less_B <= not(A) and B;

end comparator_structural;

-- Comparador de 8 bits
library IEEE;
use IEEE.std_logic_1164.all;

entity comparator_8bits is
  port (
        A,B: in std_logic_vector(7 downto 0); 
        A_less_B: out std_logic 
  );
end comparator_8bits;

architecture comparator_8bit_arch of comparator_8bits is

  component comparator_VHDL is
    port (
          A,B: in std_logic; 
          A_less_B: out std_logic 
    );
  end component;

signal temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8: std_logic; 

begin

comp1: comparator_VHDL
  port map(A(0),B(0),temp1);

comp2: comparator_VHDL
  port map(A(1),B(1),temp2);

comp3: comparator_VHDL
  port map(A(2),B(2),temp3);

comp4: comparator_VHDL
  port map(A(3),B(3),temp4);

comp5: comparator_VHDL
  port map(A(4),B(4),temp5);

comp6: comparator_VHDL
  port map(A(5),B(5),temp6);

comp7: comparator_VHDL
  port map(A(6),B(6),temp7);

comp8: comparator_VHDL
  port map(A(7),B(7),temp8);

 A_less_B <= temp1 and temp2 and temp3 and temp4 and temp5 and temp6 and temp7 and temp8;

end comparator_8bit_arch;