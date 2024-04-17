LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY MPG IS
  PORT (
 		CLK : IN std_logic;
 		BTN1 : IN STD_LOGIC;
  		ENABLE: OUT STD_LOGIC);
END MPG;


ARCHITECTURE MPG_Arch OF MPG IS

COMPONENT Poarta_Si_N is
Port ( A: in STD_LOGIC_VECTOR (15 DOWNTO 0);
       Y: OUT STD_LOGIC);
END COMPONENT;

SIGNAL COUNT : STD_LOGIC_VECTOR (15 DOWNTO 0) := (OTHERS=>'0');
SIGNAL ENABLE_D : STD_LOGIC;
SIGNAL Q1,Q2,Q3 : STD_LOGIC;

BEGIN

	c1: Poarta_Si_N port map (COUNT, ENABLE_D);
	
	PROCESS(CLK)
	BEGIN
	  	IF RISING_EDGE(CLK) THEN
	  		IF COUNT = "1111111111111111" THEN
	  			COUNT <= "0000000000000000";
	  		END IF;
	  	 COUNT <= COUNT + 1;
	  	END IF;
	END PROCESS;
	
	PROCESS(CLK)
	BEGIN
	  IF RISING_EDGE(CLK) THEN	 
		IF ENABLE_D = '1' THEN
			Q1 <= BTN1; 
		END IF;
		Q2 <= Q1;
		Q3 <= Q2;
	  END IF;
		ENABLE <= (Q2 AND (NOT Q3));
	END PROCESS;
END MPG_Arch;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity Poarta_Si_N is
Port ( A: in STD_LOGIC_VECTOR (15 DOWNTO 0);
       Y: OUT STD_LOGIC);
end Poarta_Si_N;

architecture ArchPoarta_Si_N of Poarta_Si_N is
shared variable L: std_logic;
begin   
    Process(A)
     begin 
      L := '1';
       FOR I IN 0 TO 15 LOOP
        if A(i)='0' then
        L:='0';
        end if;
     end LOOP;
     Y<=L;
     end Process;
end ArchPoarta_Si_N;