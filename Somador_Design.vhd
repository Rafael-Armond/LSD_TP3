---------------------------------------------------
-- Rafael Maia
-- Laboratorio de Sistemas Digitais - Trabalho 1 
-- Somador Ripple Carry de 8 Bits
---------------------------------------------------

----------------------------------------
-- Half Adder
----------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity half_adder is
    port (
        A,B : in std_logic;
        SUM : out std_logic;
        CARRY : out std_logic
    );
end half_adder;     

architecture dataflow of half_adder is
begin 
    SUM <= A xor B;
    CARRY <= A and B;
end dataflow;

----------------------------------------
-- Full Adder
----------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity full_adder is 
    port(
        A,B : in std_logic;
        CARRY_IN : in std_logic;
        SUM : out std_logic;
        CARRY : out std_logic
    );
end full_adder;

architecture full_adder_arch of full_adder is

    component half_adder is
        port (
            A,B : in std_logic;
            SUM : out std_logic;
            CARRY : out std_logic
        );
    end component half_adder; 

    signal X,Y,Z : std_logic;
begin

    CARRY <= Z or Y;

    HA1: half_adder
        port map(
            A => A,
            B => B,
            SUM => X,
            CARRY => Y
        );
    
    HA2: half_adder
        port map(
            A => X,
            B => CARRY_IN,
            SUM => SUM,
            CARRY => Z
        );

end full_adder_arch;

---------------------------------------- 
-- Ripple Carry Adder
----------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity ripple_carry is
    port (
        A : in std_logic_vector(7 downto 0);
        B : in std_logic_vector(7 downto 0);
        CARRY_IN : in std_logic;
        S : out std_logic_vector(7 downto 0);
        CARRY_OUT : out std_logic  
    );
end ripple_carry;

architecture ripple_carry_arch of ripple_carry is 

    component full_adder is 
    port(
        A,B : in std_logic;
        CARRY_IN : in std_logic;
        SUM : out std_logic;
        CARRY : out std_logic
    );
    end component full_adder;

    signal C1, C2, C3, C4, C5, C6, C7 : std_logic;

begin 
    FA1: full_adder
        port map(A(0), B(0), CARRY_IN, S(0), C1);
    FA2: full_adder
        port map(A(1), B(1), C1, S(1), C2);
    FA3: full_adder
        port map(A(2), B(2), C2, S(2), C3);
    FA4: full_adder
        port map(A(3), B(3), C3, S(3), C4);
    FA5: full_adder
        port map(A(4), B(4), C4, S(4), C5);
    FA6: full_adder
        port map(A(5), B(5), C5, S(5), C6);
    FA7: full_adder
        port map(A(6), B(6), C6, S(6), C7);
    FA8: full_adder
        port map(A(7), B(7), C7, S(7), CARRY_OUT);
end ripple_carry_arch;