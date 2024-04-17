----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2024 09:12:26 AM
-- Design Name: 
-- Module Name: Mux8_1_4biti - Behavioral
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

entity Mux8_1_4biti is
    Port ( DIGITS : IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
           SEL : in STD_LOGIC_VECTOR (2 downto 0);
           DIGIT :  OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
end Mux8_1_4biti;

architecture Behavioral of Mux8_1_4biti is
SIGNAL DIGIT_TEMP : STD_LOGIC_VECTOR(3 DOWNTO 0);
begin
    PROCESS(SEL, DIGITS)
    BEGIN
    CASE SEL IS
        WHEN "000" => DIGIT_TEMP <= DIGITS(3 DOWNTO 0);
        WHEN "001" => DIGIT_TEMP <= DIGITS(7 DOWNTO 4);
        WHEN "010" => DIGIT_TEMP <= DIGITS(11 DOWNTO 8);
        WHEN "011" => DIGIT_TEMP <= DIGITS(15 DOWNTO 12);
        WHEN "100" => DIGIT_TEMP <= DIGITS(19 DOWNTO 16);
        WHEN "101" => DIGIT_TEMP <= DIGITS(23 DOWNTO 20);
        WHEN "110" => DIGIT_TEMP <= DIGITS(27 DOWNTO 24);
        WHEN OTHERS => DIGIT_TEMP <= DIGITS(31 DOWNTO 28);
    END CASE;
    END PROCESS;
    DIGIT <= DIGIT_TEMP;
end Behavioral;
