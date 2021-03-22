-- Componente: FSM Controller
library IEEE;
use IEEE.std_logic_1164.all;
-- entity

entity controllerFSM is
	port (	tot_it_p,m       : in std_logic;
			clk, clr         : in std_logic;
			d,tot_ld,tot_clr : out std_logic);
end controllerFSM;
-- architecture

architecture archRTL of controllerFSM is
	type state_type is (Ini,Esp,Adc,Disp);
	
	signal CS,NS : state_type;
	-- CS = current state e NS = next state
begin
	sync_proc: process(clk,NS,clr)
	begin

		if (clr = '1') then
			CS <= Ini;
		elsif (rising_edge(clk)) then
			CS <= NS;
		end if;
	end process sync_proc;
    
	comb_proc: process(CS,tot_it_p, m)
	begin
		-- previnir latch inesperado
		d <= '0';
		tot_ld <= '0';
		tot_clr <= '0';
		
		case CS is
			when Ini =>
			-- estado inicial
			report "Estado 0";
				d <= '0';
				tot_ld <= '0';
				tot_clr <= '1';
			-- cond. mudança de estado
				if (m = '0') and (tot_it_p='0') then 
					NS <= Ini;
				elsif(m='1')and(tot_it_p='0') then
					NS <= Ini;
				elsif (m='0') and (tot_it_p='1') then 
					NS <= Ini;
				elsif (tot_it_p ='1') and (m='1') then
					NS <= Ini;
				else NS <= Esp;
				end if;
			-------------------------------------------	
			when Esp => 
			-- estado de espera
			report "Estado 1";
				d <= '0';
				tot_ld <= '0';
				tot_clr <= '0';	
			-- cond. mudança de estado
				if (m='0')and (tot_it_p='0') then
					NS <= Disp;
				elsif (m='0')and(tot_it_p='1') then
					NS <= Esp;
				else NS <= Adc;
				end if;
			-------------------------------------------	
			when Adc =>
			-- estado de soma
			report "Estado 2";
				d <= '0';
				tot_ld <= '1';
				tot_clr <= '0';		
			-- cond. mudança de estado
				if (m='0')and(tot_it_p='0')then 
					NS <=Esp;
				elsif (m='1')and(tot_it_p='0')then 
					NS <=Esp;
				elsif (m='0')and(tot_it_p='1')then 
					NS <=Esp;
				else NS <= Esp;
				end if;
			--------------------------------------------
			when Disp =>
			-- estado de dispensa
			report "Estado 3";
				d <= '1';
				tot_ld <= '0';
				tot_clr <= '0';		
			-- cond. mudança de estado
				if (m='0')and(tot_it_p='0')then
					NS<=Ini;
				elsif (m='1')and(tot_it_p='0') then
					NS<=Ini;
				elsif (m='0')and(tot_it_p='1') then
					NS<=Ini;
				else NS<=Ini;
				end if;
			when others =>
			report "Estado indesejado";
			
			NS<=Ini;
		end  case;
	end process	comb_proc;
end archRTL;

-- Componente: Somador (8 bits)
-- Half Adder
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

-- Full Adder
library ieee;
use ieee.std_logic_1164.all;

entity full_adder is 
    port(
        A,B      : in std_logic;
        CARRY_IN : in std_logic;
        SUM      : out std_logic;
        CARRY    : out std_logic
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

-- Ripple Carry Adder
library ieee;
use ieee.std_logic_1164.all;

entity ripple_carry is
    port (
        A : in std_logic_vector(7 downto 0);
        B : in std_logic_vector(7 downto 0);
        S : out std_logic_vector(7 downto 0);
        CARRY_OUT : out std_logic  
    );
end ripple_carry;

architecture ripple_carry_arch of ripple_carry is 
	component half_adder is
		port (
			A,B : in std_logic;
			SUM : out std_logic;
			CARRY : out std_logic
		);
	end component half_adder; 

    component full_adder is 
    port(
        A,B      : in std_logic;
        CARRY_IN : in std_logic;
        SUM      : out std_logic;
        CARRY    : out std_logic
    );
    end component full_adder;

    signal C1, C2, C3, C4, C5, C6, C7 : std_logic;

begin 
    HA1: half_adder
        port map(A(0), B(0), S(0), C1);
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

-- Componente: Registrador (8 bits)
library ieee;
use ieee.std_logic_1164.all;

entity registrador is 
    port(
        in1       : in std_logic_vector(7 downto 0);
        load, clr : in std_logic;
        out1      : out std_logic_vector(7 downto 0)
    );
end registrador;

architecture reg_arch of registrador is 
begin 
    reg: process(in1,load,clr)
    begin 
        if clr = '1' then 
            out1 <= "00000000";
        elsif load = '1' then 
			out1 <= in1;
        end if;
    end process reg;
end reg_arch;

-- Componente: Comparador (8 bits)
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

-- Datapath 
library ieee;
use ieee.std_logic_1164.all;

entity datapath is 
    port(a,s            : in std_logic_vector(7 downto 0); -- Entradas de dados (a: valor da moeda, s: preço)
		tot_ld, tot_clr : in std_logic; 
		tot_lt_s        : out std_logic -- Total menor que s (preço)
		);    
end datapath;

architecture datapath_arch of datapath is

	component ripple_carry is
		port (A : in std_logic_vector(7 downto 0);
			  B : in std_logic_vector(7 downto 0);
			  S : out std_logic_vector(7 downto 0);
			  CARRY_OUT : out std_logic);
	end component;

	component registrador is 
		port(in1       : in std_logic_vector(7 downto 0);
			 load, clr : in std_logic;
			 out1      : out std_logic_vector(7 downto 0));
	end component;

	component comparador_8bits is
		Port ( A,B : in std_logic_vector(0 to 7);
			   S   : out std_logic);
	end component;

	signal out_registrador, out_somador, out_comparador : std_logic_vector(7 downto 0);
	signal in1_somador : std_logic_vector(7 downto 0);
	signal terra : std_logic;

begin

	tot: registrador
	port map(out_somador,tot_ld,tot_clr,in1_somador);

	adder: ripple_carry
	port map(in1_somador,a,out_somador,terra);

	comp: comparador_8bits
	port map(in1_somador, s, tot_lt_s);

end datapath_arch ; 
-- Fim Datapath

-- RTL (Controller FSM + Datapath)
library ieee;
use ieee.std_logic_1164.all;

entity rtl is
	port(
		s,a       : in std_logic_vector(7 downto 0);
		c,clk,clr : in std_logic;
		d         : out std_logic
	); 
end rtl;

architecture rtl_arch of rtl is

	component datapath is 
		port(a,s            : in std_logic_vector(7 downto 0); 
			tot_ld, tot_clr : in std_logic; 
			tot_lt_s        : out std_logic 
			);    
	end component;

	component controllerFSM is
		port (	tot_it_p,m       : in std_logic;
				clk, clr         : in std_logic;
				d,tot_ld,tot_clr : out std_logic);
	end component;

	signal tot_ld, tot_clr, tot_lt_s : std_logic;

begin
	dp: datapath
	port map(s,a,tot_ld,tot_clr,tot_lt_s);

	controladora: controllerFSM
	port map(tot_lt_s,c,clk,clr,d,tot_ld,tot_clr); 

end rtl_arch;
