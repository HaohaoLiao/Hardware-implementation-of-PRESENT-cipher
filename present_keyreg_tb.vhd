library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
use work.all;
entity present_keyreg_tb is
end entity;
architecture io of present_keyreg_tb is
  component present_keyreg
    port(clk, rst_b: in std_logic;
    sel_keyreg: in std_logic_vector(1 downto 0);
    input: in std_logic_vector(79 downto 0);
  key_valid : in std_logic;
  counter : in std_logic_vector(5 downto 0);
  --  input1024: in std_logic_vector(1023 downto 0);
    output: out std_logic_vector(63 downto 0));
  end component;
  for all : present_keyreg use entity work.present_keyreg(rtl);
  signal key_valid_tb,  rst_b_tb :  std_logic;
  signal clk_tb : std_logic := '0';
  signal sel_keyreg_tb : std_logic_vector(1 downto 0);
  signal input_tb :std_logic_vector(79 downto 0);
  signal counter_tb : std_logic_vector(5 downto 0);
  signal output_tb :std_logic_vector(63 downto 0);
  begin
    G0: present_keyreg port map( clk_tb, rst_b_tb, sel_keyreg_tb, input_tb,key_valid_tb, counter_tb, output_tb);
      clk_tb <= not clk_tb after 10 ns;
      rst_b_tb <= '0' , '1' after 30 ns;
      key_valid_tb <= '0', '1' after 50 ns, '0' after 70 ns;
      input_tb <= X"00000000000000000000";
      sel_keyreg_tb <= "01", "10" after 70 ns;
      counter_tb <=  "000001", "000010" after 90 ns, "000011" after 110 ns;
    end architecture;
