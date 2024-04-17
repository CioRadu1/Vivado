library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity REG_FILE is
    Port ( RA1 : in STD_LOGIC_VECTOR (4 downto 0);
           RA2 : in STD_LOGIC_VECTOR (4 downto 0);
           RW_ENABLE: IN STD_LOGIC;
           EN: in STD_LOGIC;
           CLK : in STD_LOGIC;
           WD : in STD_LOGIC_VECTOR (31 downto 0);
           WA : in STD_LOGIC_VECTOR (4 downto 0);
           RD1 : out STD_LOGIC_VECTOR (31 downto 0);
           RD2 : out STD_LOGIC_VECTOR (31 downto 0));
end REG_FILE;

architecture Behavioral of REG_FILE is
type reg_file is array (0 TO 31) of std_logic_vector(31 downto 0);
signal RegFile : reg_file;
begin
   PROCESS(CLK, RW_ENABLE, RA1, RA2, WA)
   BEGIN
   IF RISING_EDGE(CLK) THEN
      IF RW_ENABLE = '1' AND EN = '1' THEN 
        REGFILE(CONV_INTEGER(WA)) <= WD;
      END IF;
   END IF;
   IF RW_ENABLE = '0' THEN
        RD1 <= REGFILE(CONV_INTEGER(RA1)); 
        RD2 <= REGFILE(CONV_INTEGER(RA2)); 
   END IF;
   END PROCESS; 
end Behavioral;
