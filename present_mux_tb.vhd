library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
use work.all;
entity present_mux_tb is
end entity;
architecture io of present_mux_tb is
  component present_mux
    port ( sel_mux : in std_logic;
  input1, input2 : in std_logic_vector( 63 downto 0);
  output : out std_logic_vector(63 downto 0));
end component;
for all : present_mux use entity work.present_mux(rtl);
signal sel_mux_tb : std_logic;
signal input1_tb, input2_tb, output_tb : std_logic_vector(63 downto 0);
begin
  G0:present_mux port map(sel_mux_tb,  input1_tb, input2_tb, output_tb);
    sel_mux_tb <= '0' , '1' after 10 ns, '0' after 20 ns, '1' after 30 ns, '0' after 40 ns;
    input1_tb <= X"0000000000000000";
    input2_tb <= X"FFFFFFFFFFFFFFFF";
  end architecture;
