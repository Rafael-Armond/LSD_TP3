-- Testbench automatically generated online
-- at https://vhdl.lapinoo.net
-- Generation date : 22.3.2021 20:03:16 UTC

library ieee;
use ieee.std_logic_1164.all;

entity tb_comparator_VHDL is
end tb_comparator_VHDL;

architecture tb of tb_comparator_VHDL is

    component comparator_VHDL
        port (A        : in std_logic;
              B        : in std_logic;
              A_less_B : out std_logic);
    end component;

    signal A        : std_logic;
    signal B        : std_logic;
    signal A_less_B : std_logic;

begin

    dut : comparator_VHDL
    port map (A        => A,
              B        => B,
              A_less_B => A_less_B);

    stimuli : process
    begin
        -- EDIT Adapt initialization as needed
        A <= '0';
        B <= '0';

        -- EDIT Add stimuli here

        wait;
    end process;

end tb;

-- Configuration block below is required by some simulators. Usually no need to edit.

configuration cfg_tb_comparator_VHDL of tb_comparator_VHDL is
    for tb
    end for;
end cfg_tb_comparator_VHDL;