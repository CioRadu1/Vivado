----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/02/2023 08:54:30 AM
-- Design Name: 
-- Module Name: Poarta_Si_N - Behavioral
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
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity Poarta_Si_N is
generic (N: INTEGER :=3);
Port ( A: in STD_LOGIC_VECTOR (N-1 DOWNTO 0);
       Y: OUT STD_LOGIC);
end Poarta_Si_N;

architecture ArchPoarta_Si_N of Poarta_Si_N is
shared variable L: std_logic;
begin   
    Process(A)
     begin 
      L := '1';
       FOR I IN 0 TO N-1 LOOP
        if A(i)='0' then
        L:='0';
        end if;
     end LOOP;
     Y<=L;
     end Process;
end ArchPoarta_Si_N;

