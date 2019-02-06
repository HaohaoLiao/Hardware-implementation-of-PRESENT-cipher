library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
use work.all;

entity present_permutation is
  port(
       input : in std_logic_vector( 63 downto 0);
  output : out std_logic_vector(63 downto 0));
end entity;

architecture rtl of present_permutation is
begin
 label1: for i in 0 to 15 generate
   output(i) <= input (4* i);
   output(i+16) <= input(4*i+1);
   output(i+32) <= input(4*i+2);
   output(i+48) <= input(4*i+3);
 end generate;
  
 -- process (i)
 --   begin
     -- output <= i(63)&i(59)&i(55)&i(51)&i(47)&i(43)&i(39)&i(35)&i(31)&i(27)&i(23)&i(19)&i(15)&i(11)&i(7)&i(3)&i(62)&i(58)&(54)&i(50)&i(46)&i(42)&i(38)&i(34)&i(30)&i(26)&i(22)&i(18)&i(14)&i(10)&i(6)&i(2)&i(61)&i(57)&i(53)&i(49)&i(45)&i(41)&i(37)&i(33)&i(29)&i(25)&i(21)&i(17)&i(13)&i(9)&i(5)&i(1)&i(60)&i(56)&i(52)&i(48)&i(44)&i(40)&i(36)&(32)&i(28)&i(24)&i(20)&i(16)&i(12)&i(8)&i(4)&i(0);
  --  end process;
end architecture;
