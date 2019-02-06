library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
use work.all;
entity present_mux is
  port ( sel_mux : in std_logic;
  input1, input2 : in std_logic_vector( 63 downto 0);
  output : out std_logic_vector(63 downto 0));
end entity;
architecture rtl of present_mux is
begin
  process(sel_mux,input1,input2)
    begin
  case(sel_mux) is
when '0' =>
  output <= input1;
when '1' =>
  output <= input2;
when others =>
  null;
end case;
 end process;
end architecture;
