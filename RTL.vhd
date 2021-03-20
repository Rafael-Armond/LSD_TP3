library IEEE;
use IEEE.std_logic_1164.all;
-- entity

entity maquinaRTL is
	port (	tot_it_p,m  : in std_logic;
			clk, clr: in std_logic;
			vec: in std_logic_vector (1 downto 0);
			d,tot_ld,tot_clr: out std_logic);
end maquinaRTL;
-- architecture

architecture archRTL of maquinaRTL is
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
				elsif (m='1')and(tot_it_p='0') then
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
				elsif ()and() then
					NS<=Ini;
				elsif ()and() then
					NS<=Ini;
				else NS <=;
			end if;
			when others =>
			report "Estado indesejado";
			
			NS<= Ini;
		end  case;
	end process	comb_proc;
end archRTL;
