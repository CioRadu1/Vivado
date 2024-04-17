----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2024 09:23:37 AM
-- Design Name: 
-- Module Name: COUNTER_17_BITI - Behavioral
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
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity COUNTER_17_BITI is
    Port ( CLK : in STD_LOGIC;
           COUNT : out STD_LOGIC_VECTOR (16 downto 0));
end COUNTER_17_BITI;

architecture Behavioral of COUNTER_17_BITI is
SIGNAL COUNT_TEMP :STD_LOGIC_VECTOR(16 DOWNTO 0) := (OTHERS => '0');
begin

    PROCESS (CLK)
    BEGIN
    IF RISING_EDGE(CLK) THEN 
        IF COUNT_TEMP = "11111111111111111" THEN
            COUNT_TEMP <= "00000000000000000";
        END IF;
        COUNT_TEMP <= COUNT_TEMP + 1;
    END IF;
    END PROCESS;


end Behavioral;
