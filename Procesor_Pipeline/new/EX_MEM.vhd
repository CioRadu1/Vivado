----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2024 06:02:12 PM
-- Design Name: 
-- Module Name: EX_MEM - Behavioral
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

entity EX_MEM is
    Port ( CLK : in STD_LOGIC;
           EN : in STD_LOGIC;
           WB_In : in STD_LOGIC_VECTOR (1 downto 0);
           M_In : in STD_LOGIC_VECTOR (1 downto 0);
           PC4_In : in STD_LOGIC_VECTOR (31 downto 0);
           ZeroFlag_In : in STD_LOGIC;
           ALURes_In : in STD_LOGIC_VECTOR (31 downto 0);
           RD2_In : in STD_LOGIC_VECTOR (31 downto 0);
           RegWriteData_In : in STD_LOGIC_VECTOR (4 downto 0);
           WB_Out : out STD_LOGIC_VECTOR (1 downto 0);
           M_Out : out STD_LOGIC_VECTOR (1 downto 0);
           ZeroFlag_Out : out STD_LOGIC;
           PC4_Out : out STD_LOGIC_VECTOR (31 downto 0);
           ALURes_Out : out STD_LOGIC_VECTOR (31 downto 0);
           RD2_Out : out STD_LOGIC_VECTOR (31 downto 0);
           RegWriteData_Out : out STD_LOGIC_VECTOR (4 downto 0));
end EX_MEM;

architecture Behavioral of EX_MEM is

begin

    Reg_Process: PROCESS (CLK, EN)
    BEGIN
        IF RISING_EDGE(CLK) THEN 
            IF EN = '1' THEN
                WB_Out <= WB_In;
                M_Out <= M_In;
                ZeroFlag_Out <= ZeroFlag_In;
                ALURes_Out <= ALURes_In;
                RD2_Out <= RD2_In;
                RegWriteData_Out <= RegWriteData_In;
                PC4_Out <= PC4_In;
            END IF;
        END IF;
    END PROCESS Reg_Process;
    
end Behavioral;
