----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2024 06:02:12 PM
-- Design Name: 
-- Module Name: IF_ID - Behavioral
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

entity IF_ID is
    Port ( CLK : in STD_LOGIC;
           EN : in STD_LOGIC;
           Instruction_In : in STD_LOGIC_VECTOR (31 downto 0);
           PC4_In : in STD_LOGIC_VECTOR (31 downto 0);
           Instruction_Out : out STD_LOGIC_VECTOR (31 downto 0);
           PC4_OuT : out STD_LOGIC_VECTOR (31 downto 0));
end IF_ID;

architecture Behavioral of IF_ID is

begin

    Reg_Process: PROCESS (CLK, EN)
    BEGIN
        IF RISING_EDGE(CLK) THEN 
            IF EN = '1' THEN
                Instruction_Out <= Instruction_In;
                PC4_Out <= PC4_In;
            END IF;
        END IF;
    END PROCESS Reg_Process;


end Behavioral;
