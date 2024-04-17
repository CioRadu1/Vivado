library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SEGMENTE is
    Port (
           clk : in STD_LOGIC;
           DIGITS : IN STD_LOGIC_VECTOR(31 DOWNTO 0); 
           cat : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (7 downto 0));
end SEGMENTE;

architecture Behavioral of SEGMENTE is

SIGNAL SIG_COUNT : STD_LOGIC_VECTOR (16 DOWNTO 0):=(OTHERS => '0');
SIGNAL SELECTION_MUX : STD_LOGIC_VECTOR(2 DOWNTO 0); 
SIGNAL DECODE_DIGIT : STD_LOGIC_VECTOR(3 DOWNTO 0);

begin

    PROCESS (CLK)
    BEGIN
    IF RISING_EDGE(CLK) THEN 
        IF SIG_COUNT = "11111111111111111" THEN
            SIG_COUNT <= "00000000000000000";
        END IF;
        SIG_COUNT <= SIG_COUNT + 1;
    END IF;
    END PROCESS;
    
    SELECTION_MUX <= SIG_COUNT(16 DOWNTO 14);
    
    
    PROCESS(SELECTION_MUX, DIGITS)
    BEGIN
    CASE SELECTION_MUX IS
        WHEN "000" => DECODE_DIGIT <= DIGITS(3 DOWNTO 0);
        WHEN "001" => DECODE_DIGIT <= DIGITS(7 DOWNTO 4);
        WHEN "010" => DECODE_DIGIT <= DIGITS(11 DOWNTO 8);
        WHEN "011" => DECODE_DIGIT <= DIGITS(15 DOWNTO 12);
        WHEN "100" => DECODE_DIGIT <= DIGITS(19 DOWNTO 16);
        WHEN "101" => DECODE_DIGIT <= DIGITS(23 DOWNTO 20);
        WHEN "110" => DECODE_DIGIT <= DIGITS(27 DOWNTO 24);
        WHEN "111" => DECODE_DIGIT <= DIGITS(31 DOWNTO 28);
        WHEN OTHERS => DECODE_DIGIT <= (others => 'X');
    END CASE;
    END PROCESS;
   PROCESS(SELECTION_MUX)
    BEGIN
    CASE SELECTION_MUX IS
        WHEN "000" => AN <= "11111110";
        WHEN "001" => AN <= "11111101";
        WHEN "010" => AN <= "11111011";
        WHEN "011" => AN <= "11110111";
        WHEN "100" => AN <= "11101111";
        WHEN "101" => AN <= "11011111";
        WHEN "110" => AN <= "10111111";
        WHEN "111" => AN <="01111111";
        WHEN OTHERS => AN <=(OTHERS => 'X');
    END CASE;
    END PROCESS;

   with DECODE_DIGIT SELect
   CAT<= "1000000" when "0000",   -- 0
         "1111001" when "0001",   -- 1
         "0100100" when "0010",   -- 2
         "0110000" when "0011",   -- 3
         "0011001" when "0100",   -- 4
         "0010010" when "0101",   -- 5
         "0000010" when "0110",   -- 6
         "1111000" when "0111",   -- 7
         "0000000" when "1000",   -- 8
         "0010000" when "1001",   -- 9
         "0001000" when "1010",   -- A
         "0000011" when "1011",   -- b
         "1000110" when "1100",   -- C
         "0100001" when "1101",   -- d
         "0000110" when "1110",   -- E
         "0001110" when "1111",   -- F
         (others => 'X') when others;
    

end Behavioral;
