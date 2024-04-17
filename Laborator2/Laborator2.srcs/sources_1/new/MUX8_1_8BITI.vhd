----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2024 09:19:11 AM
-- Design Name: 
-- Module Name: MUX8_1_8BITI - Behavioral
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

entity MUX8_1_8BITI is
  Port (   SEL8 : in STD_LOGIC_VECTOR (2 downto 0);
           DIGIT8 :  OUT STD_LOGIC_VECTOR(7 DOWNTO 0) );
end MUX8_1_8BITI;

architecture Behavioral of MUX8_1_8BITI is
SIGNAL DIGIT_TEMP8 : STD_LOGIC_VECTOR(7 DOWNTO 0);
begin
    PROCESS(SEL8)
    BEGIN
    CASE SEL8 IS
        WHEN "000" => DIGIT_TEMP8 <= "11111110";
        WHEN "001" => DIGIT_TEMP8 <= "11111101";
        WHEN "010" => DIGIT_TEMP8 <= "11111011";
        WHEN "011" => DIGIT_TEMP8 <= "11110111";
        WHEN "100" => DIGIT_TEMP8 <= "11101111";
        WHEN "101" => DIGIT_TEMP8 <= "11011111";
        WHEN "110" => DIGIT_TEMP8<=  "10111111";
        WHEN OTHERS => DIGIT_TEMP8 <="01111111";
    END CASE;
    END PROCESS;
    DIGIT8 <= DIGIT_TEMP8;

end Behavioral;
