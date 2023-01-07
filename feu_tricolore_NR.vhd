----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.10.2022 11:29:18
-- Design Name: 
-- Module Name: feu_tricolore_NR - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity feu_tricolore_NR is
     port (CLK, BTN_C : in bit; 
           LED_3_0, LED_7_4 : out integer range 1 to 4);
end feu_tricolore_NR;

architecture Behavioral of feu_tricolore_NR is
   component clock_divider
        generic(divisor : integer);
        port(clock_in, reset : in bit;
             clock_out : out bit);
    end component clock_divider;
    signal real_clk : bit;

begin
    CD :  clock_divider generic map(divisor => 200000000) port map(clock_in => CLK, reset => '0', clock_out =>real_clk);
process(real_clk)
    variable etat : integer range 0 to 10;
begin
    if(real_clk'event and real_clk = '1') THEN 
        case etat is 
            when 0 => LED_3_0 <= 1; LED_7_4 <= 4; etat:=1;
            when 1 => LED_3_0 <= 1; LED_7_4 <= 4; etat:=2;
            when 2 => LED_3_0 <= 1; LED_7_4 <= 4; etat:=3;
            when 3 => LED_3_0 <= 1; LED_7_4 <= 4; etat:=4;
            when 4 => LED_3_0 <= 2; LED_7_4 <= 4; etat:=5;
            when 5 => LED_3_0 <= 4; LED_7_4 <= 1; etat:=6;
            when 6 => LED_3_0 <= 4; LED_7_4 <= 1; etat:=7;
            when 7 => LED_3_0 <= 4; LED_7_4 <= 1; etat:=8;
            when 8 => LED_3_0 <= 4; LED_7_4 <= 1; etat:=9;
            when 9 => LED_3_0 <= 4; LED_7_4 <= 2;etat:=0;
            when others => etat:=4;
        end case;
    end if;
end process;
end Behavioral;


