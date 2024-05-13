----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2024 06:02:12 PM
-- Design Name: 
-- Module Name: ID_EX - Behavioral
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

entity ID_EX is
    Port ( CLK : in STD_LOGIC;
           EN : in STD_LOGIC;
           RD1_In : in STD_LOGIC_VECTOR (31 downto 0);
           RD2_In : in STD_LOGIC_VECTOR (31 downto 0);
           Ext_Imm_In : in STD_LOGIC_VECTOR (31 downto 0);
           Func_In : in STD_LOGIC_VECTOR (5 downto 0);
           Shift_In : in STD_LOGIC_VECTOR (4 downto 0);
           RegRD_In : in STD_LOGIC_VECTOR (4 downto 0);
           RegRT_In : in STD_LOGIC_VECTOR (4 downto 0);
           RD1_Out : out STD_LOGIC_VECTOR (31 downto 0);
           RD2_Out : out STD_LOGIC_VECTOR (31 downto 0);
           Ext_Imm_Out : out STD_LOGIC_VECTOR (31 downto 0);
           Func_Out : out STD_LOGIC_VECTOR (5 downto 0);
           Shift_Out : out STD_LOGIC_VECTOR (4 downto 0);
           RegRD_Out : out STD_LOGIC_VECTOR (4 downto 0);
           RegRT_Out : out STD_LOGIC_VECTOR (4 downto 0);
           MemToReg : in STD_LOGIC;
           RegWrite : in STD_LOGIC;
           MemWrite : in STD_LOGIC;
           Branch : in STD_LOGIC;
           ALUOp : in STD_LOGIC_VECTOR (2 downto 0);
           ALUSrc : in STD_LOGIC;
           RegDst : in STD_LOGIC;
           PC4_In : in STD_LOGIC_VECTOR (31 downto 0);
           PC4_Out : out STD_LOGIC_VECTOR (31 downto 0);
           WB : out STD_LOGIC_VECTOR (1 downto 0);
           M : out STD_LOGIC_VECTOR (1 downto 0);
           EX : out STD_LOGIC_VECTOR (4 downto 0));
end ID_EX;

architecture Behavioral of ID_EX is

begin

    Reg_Process: PROCESS (CLK, EN)
    BEGIN
        IF RISING_EDGE(CLK) THEN 
            IF EN = '1' THEN
                RD1_Out <= RD1_In;
                RD2_Out <= RD2_In;
                Ext_Imm_Out <= Ext_Imm_In;
                Func_Out <= Func_In;
                Shift_Out <= Shift_In;
                RegRD_Out <= RegRD_In;
                RegRT_Out <= RegRT_In;
                WB(0) <= MemToReg;
                WB(1) <= RegWrite;
                M(0) <= MemWrite;
                M(1) <= Branch;
                EX(4 DOWNTO 2) <= ALUOp;
                EX(1) <= ALUSrc;
                EX(0) <= RegDst;
                PC4_Out <= PC4_In;
            END IF;
        END IF;
    END PROCESS Reg_Process;

end Behavioral;
