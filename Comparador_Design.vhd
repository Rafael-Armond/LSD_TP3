library IEEE;
use IEEE.std_logic_1164.all;
entity comparator_VHDL is
  port (
        A,B: in std_logic_vector(1 downto 0); 
        A_less_B: out std_logic 
  );
end comparator_VHDL;
architecture comparator_structural of comparator_VHDL is
signal temp1,temp2,temp3: std_logic; 

begin

 temp1 <= (not A(0)) and (not A(1)) and B(0);
 temp2 <= (not A(1)) and B(1);
 temp3 <= (not A(0)) and B(1) and B(0);

 A_less_B <= temp1 or temp2 or temp3;

end comparator_structural;