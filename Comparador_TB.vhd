-- fpga4student.com: FPGA projects, Verilog projects, VHDL projects 
-- VHDL project: VHDL code for a comparator 
-- Testbench VHDL code for comparator
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all; 
ENTITY tb_comparator_VHDL IS
END tb_comparator_VHDL;
 
ARCHITECTURE behavior OF tb_comparator_VHDL IS 
 
    -- Component Declaration for the comparator in VHDL
 
    COMPONENT comparator_VHDL
    PORT(
         A : IN  std_logic_vector(1 downto 0);
         B : IN  std_logic_vector(1 downto 0);
         A_less_B : OUT  std_logic
        );
    END COMPONENT;
   --Inputs
   signal A : std_logic_vector(1 downto 0) := (others => '0');
   signal B : std_logic_vector(1 downto 0) := (others => '0');
  --Outputs
   signal A_less_B : std_logic;

BEGIN
 -- Instantiate the comparator in VHDL
   uut: comparator_VHDL 
   PORT MAP (
          A => A,
          B => B,
          A_less_B => A_less_B
        );

   -- Stimulus process
   stim_proc: process
   begin 
  -- create test cases for A_less_B
  for i in 0 to 7 loop 
           A <= std_logic_vector(to_unsigned(i,2));  
           B <= std_logic_vector(to_unsigned(i+1,2));  
           wait for 20 ns; 
      end loop;
      wait;
   end process;

END;