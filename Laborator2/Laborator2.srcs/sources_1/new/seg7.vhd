library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Seg7 is
 Port ( DIGITS : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        CLK: IN STD_LOGIC;
        CAT : OUT STD_LOGIC_VECTOR (6 DOWNTO 0);
        AN: OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
end Seg7;   

architecture Behavioral of Seg7 is

 COMPONENT MUX8_1_8BITI is
  Port (   SEL8 : in STD_LOGIC_VECTOR (2 downto 0);
           DIGIT8 :  OUT STD_LOGIC_VECTOR(7 DOWNTO 0) );
end COMPONENT MUX8_1_8BITI;

COMPONENT Mux8_1_4biti is
    Port ( DIGITS : IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
           SEL : in STD_LOGIC_VECTOR (2 downto 0);
           DIGIT :  OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
end COMPONENT Mux8_1_4biti;

COMPONENT COUNTER_17_BITI is
    Port ( CLK : in STD_LOGIC;
           COUNT : out STD_LOGIC_VECTOR (16 downto 0));
end COMPONENT COUNTER_17_BITI;

SINGNAL SEL_SIG : STD_LOGIC_VECTOR (16 DOWNTO 0) := (OTHERS => 0);
begin


end Behavioral;
