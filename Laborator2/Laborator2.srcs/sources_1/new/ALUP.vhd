library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ALUP is
    Port ( BTN : in STD_LOGIC_VECTOR (4 downto 0);
           CLK : in STD_LOGIC;
           SW : in STD_LOGIC_VECTOR (15 downto 0);
           CAT : out STD_LOGIC_VECTOR (6 downto 0);
           AN : out STD_LOGIC_VECTOR (7 downto 0));
end ALUP;

architecture Behavioral of ALUP is

begin


end Behavioral;
