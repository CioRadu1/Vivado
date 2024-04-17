library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity 7SEG is
 Port ( DIGITS : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        CLK: IN STD_LOGIC;
        CAT : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
        AN: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        )
end 7SEG;

architecture Behavioral of 7SEG is

begin


end Behavioral;
