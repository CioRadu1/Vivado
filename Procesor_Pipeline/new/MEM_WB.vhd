----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2024 06:02:12 PM
-- Design Name: 
-- Module Name: MEM_WB - Behavioral
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

entity MEM_WB is
    Port ( CLK : in STD_LOGIC;
           EN : in STD_LOGIC;
           ReadData_In : in STD_LOGIC_VECTOR (31 downto 0);
           WB_In : in STD_LOGIC_VECTOR (1 downto 0);
           ALURes_In : in STD_LOGIC_VECTOR (31 downto 0);
           RegWriteData_In : in STD_LOGIC_VECTOR (4 downto 0);
           ReadData_Out : out STD_LOGIC_VECTOR (31 downto 0);
           WB_Out : out STD_LOGIC_VECTOR (1 downto 0);
           ALURes_Out : out STD_LOGIC_VECTOR (31 downto 0);
           RegWriteData_Out : out STD_LOGIC_VECTOR (4 downto 0));
end MEM_WB;

architecture Behavioral of MEM_WB is

begin

    Reg_Process: PROCESS (CLK, EN)
    BEGIN
        IF RISING_EDGE(CLK) THEN 
            IF EN = '1' THEN
                ReadData_Out <= ReadData_In;
                WB_Out <= WB_In;
                ALURes_Out <= ALURes_In;
                RegWriteData_Out <= RegWriteData_In;
            END IF;
        END IF;
    END PROCESS Reg_Process;

end Behavioral;
