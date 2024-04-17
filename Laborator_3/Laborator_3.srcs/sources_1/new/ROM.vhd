library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity ROM is
    Port ( 
           ADDR : in STD_LOGIC_VECTOR (4 downto 0);
           DO : out STD_LOGIC_VECTOR (31 downto 0));
end ROM;

architecture Behavioral of ROM is
type ROM_TYPE is array (0 to 31) of std_logic_vector(31 downto 0);
signal ROM : ROM_TYPE := (X"12300000",X"00000321",X"00000001",X"00000001",
others => X"00000000");

begin
     do <= ROM(conv_integer(addr));
end Behavioral;
