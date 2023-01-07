----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.10.2022 16:17:07
-- Design Name: 
-- Module Name: capteur_NR - Behavioral
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

entity capteur_R is
    port (CLK, BTN_C, BTN_G, BTN_H: in bit; 
           LED_3_0, LED_7_4 : out integer range 1 to 4);
end capteur_R;

architecture Behavioral of capteur_R is
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
            when 0 => LED_3_0 <= 1; LED_7_4 <= 4; 
              if(BTN_C = '1') then 
                    etat := 4;
                else  etat:=1;
                end if;
            when 1 => LED_3_0 <= 1; LED_7_4 <= 4; 
             if(BTN_C = '1') then 
                    etat := 4;
                else  etat:=2;
                end if;
            when 2 => LED_3_0 <= 1; LED_7_4 <= 4; 
            if(BTN_C = '1') then 
                    etat := 4;
                else  etat:=3;
                end if;
            when 3 => LED_3_0 <= 1; LED_7_4 <= 4; 
                if BTN_H = '1' OR BTN_C = '1' then etat:=4;
                end if;
            when 4 => LED_3_0 <= 2; LED_7_4 <= 4; 
            if(BTN_C = '0') then 
                    etat := 5;
                end if;
            when 5 => LED_3_0 <= 4; LED_7_4 <= 1; 
             if(BTN_C = '1') then 
                    etat := 9;
                else  etat:=6;
                end if;
            when 6 => LED_3_0 <= 4; LED_7_4 <= 1; 
            if(BTN_C = '1') then 
                        etat := 9;
                    else  etat:=7;
                    end if;
            when 7 => LED_3_0 <= 4; LED_7_4 <= 1; 
             if(BTN_C = '1') then 
                        etat := 9;
                    else  etat:=8;
                    end if;
            when 8 => LED_3_0 <= 4; LED_7_4 <= 1; 
                if BTN_G = '1' OR BTN_C = '1' then etat := 9;
                end if;
            when 9 => LED_3_0 <= 4; LED_7_4 <= 2;etat:=0;
            when others => etat:=4;
        end case;
    end if;
end process;
end Behavioral;

