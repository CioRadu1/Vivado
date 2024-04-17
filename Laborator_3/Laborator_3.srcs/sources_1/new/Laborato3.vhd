library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity Laborato3 is
     Port (clk : in STD_LOGIC;
           btn : in STD_LOGIC_VECTOR (4 downto 0);
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (7 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end Laborato3;

architecture Behavioral of Laborato3 is

COMPONENT MPG IS
  PORT (
 		CLK : IN std_logic;
 		BTN1 : IN STD_LOGIC;
  		ENABLE: OUT STD_LOGIC);
END COMPONENT;

COMPONENT SEGMENTE is
    Port (
           clk : in STD_LOGIC;
           DIGITS : IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
           cat : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (7 downto 0));
end COMPONENT;

COMPONENT REG_FILE is
    Port ( RA1 : in STD_LOGIC_VECTOR (4 downto 0);
           RA2 : in STD_LOGIC_VECTOR (4 downto 0);
           RW_ENABLE: IN STD_LOGIC;
           CLK : in STD_LOGIC;
           WD : in STD_LOGIC_VECTOR (31 downto 0);
           WA : in STD_LOGIC_VECTOR (4 downto 0);
           RD1 : out STD_LOGIC_VECTOR (31 downto 0);
           RD2 : out STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

COMPONENT ROM is
    Port ( CLK : in STD_LOGIC;
           WE : in STD_LOGIC;
           ADDR : in STD_LOGIC_VECTOR (5 downto 0);
           DI : in STD_LOGIC_VECTOR (31 downto 0);
           DO : out STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

type romMEM is array (0 TO 31) of std_logic_vector(31 downto 0);
signal ROM1 : romMEM := (
X"00000001", X"00000010", X"00000011",X"12314567", others => X"90412413"
);
signal num5Biti : std_logic_vector(4 downto 0);
signal num6Biti : std_logic_vector(5 downto 0);
SIGNAL ENABLE_NUM : STD_LOGIC;
SIGNAL ENABLE_WRITE : STD_LOGIC;
SIGNAL SEMNAL : STD_LOGIC_VECTOR (31 DOWNTO 0):=(OTHERS => '0');
SIGNAL SEMNAL_SHIFTAT : STD_LOGIC_VECTOR (31 DOWNTO 0):=(OTHERS => '0');
SIGNAL READ1 : STD_LOGIC_VECTOR (31 DOWNTO 0):=(OTHERS => '0');
SIGNAL READ2 : STD_LOGIC_VECTOR (31 DOWNTO 0):=(OTHERS => '0');

begin
    --3.5.1
  --  C1: MPG PORT MAP (CLK, BTN(0), ENABLE_NUM);
   -- C2: SEGMENTE PORT MAP (CLK,SEMNAL,CAT,AN);
 --   NUMARATOR:PROCESS (CLK)
  --  BEGIN 
    --   IF RISING_EDGE(CLK) THEN
      --  IF ENABLE_NUM = '1' THEN 
        --    IF NUM5BITI = "11111" THEN
         --       NUM5BITI <= "00000";      
          --  END IF;
         -- NUM5BITI <= NUM5BITI + 1 ;
       -- END IF;
     --  END IF;     
   -- END PROCESS NUMARATOR;
   -- SEMNAL <= ROM(conv_integer(NUM5BITI));
   --3.5.2
    --C1: MPG PORT MAP (CLK, BTN(0), ENABLE_NUM);
   -- C1_1: MPG PORT MAP (CLK, BTN(1), ENABLE_WRITE);
   -- C3_1: REG_FILE PORT MAP (NUM5BITI,NUM5BITI,ENABLE_WRITE,CLK,SEMNAL,NUM5BITI,READ1,READ2);
   -- C2: SEGMENTE PORT MAP (CLK,SEMNAL,CAT,AN);  
   -- PROCESS(CLK,BTN(2))
  --  BEGIN
    --   IF RISING_EDGE(CLK) THEN
      --      IF ENABLE_NUM = '1' THEN
        --        num5biti <= num5biti + 1;
        --    END IF;
       -- END IF;
      --  IF BTN(2) = '1' THEN 
      --      NUM5BITI <= "00000";
      --  END IF;
  --  END PROCESS;
   -- SEMNAL <= READ1 + READ2;  
   
   --3.5.3
   C1: MPG PORT MAP (CLK, BTN(0), ENABLE_NUM);
    C1_1: MPG PORT MAP (CLK, BTN(1), ENABLE_WRITE);
    C3_1: ROM PORT MAP (CLK, ENABLE_WRITE, NUM6BITI,SEMNAL_SHIFTAT, SEMNAL);
    C2: SEGMENTE PORT MAP (CLK,SEMNAL_SHIFTAT,CAT,AN);  
    PROCESS(CLK,BTN(2))
    BEGIN
        IF RISING_EDGE(CLK) THEN
            IF ENABLE_NUM = '1' THEN
                num6biti <= num6biti + 1;
            END IF;
        END IF;
        IF BTN(2) = '1' THEN 
            NUM6BITI <= "000000";
        END IF;
    END PROCESS; 
    SEMNAL_SHIFTAT <= SEMNAL(29 DOWNTO 0) & "00"; 
end Behavioral;
