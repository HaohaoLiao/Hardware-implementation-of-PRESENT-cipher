library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
use work.all;
entity present_addkey is
  port ( input1, key : in std_logic_vector(63 downto 0);
    output : out std_logic_vector(63 downto 0));
end entity;
architecture rtl of present_addkey is 
begin
  output <= input1 xor key;
end architecture;
