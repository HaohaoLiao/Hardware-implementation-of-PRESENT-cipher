library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
use work.all;
entity present_tb is
end entity;
architecture io of present_tb is
  component present_top
    port( clk, rst_b : in std_logic;
  key_valid, plain_valid : in std_logic;
  plaintext : in std_logic_vector( 63 downto 0);
  key : in std_logic_vector( 79 downto 0);
  ciphertext : out std_logic_vector( 63 downto 0);
  cipher_valid: out std_logic);
  end component;
  for all : present_top use entity work.present_top(struct);
  signal clk_tb : std_logic :='0';
signal rst_b_tb, key_valid_tb, plain_valid_tb, cipher_valid_tb : std_logic;
signal plaintext_tb, ciphertext_tb : std_logic_vector( 63 downto 0);
signal key_tb : std_logic_vector(79 downto 0);
begin
  G0: present_top port map(clk_tb, rst_b_tb, key_valid_tb,plain_valid_tb,plaintext_tb,key_tb,ciphertext_tb,cipher_valid_tb);
    clk_tb <= not clk_tb after 10 ns;
    rst_b_tb <= '0', '1' after 50 ns;
    
key_valid_tb <= '0', '1' after 70 ns, '0' after 90 ns, '1' after 770 ns, '0' after 790 ns, '1' after 1470 ns, '0' after 1490 ns, '1' AFTER 2170 ns, '0' after 2190  ns;
    
key_tb <= X"00000000000000000000",X"FFFFFFFFFFFFFFFFFFFF" after 770 ns, X"00000000000000000000" after 1470 ns, X"FFFFFFFFFFFFFFFFFFFF" after 2170 ns;
    
plaintext_tb <= X"0000000000000000", X"FFFFFFFFFFFFFFFF" AFTER 1510 ns; 
    
plain_valid_tb <= '0', '1' after 110 ns, '0' after 130 ns, '1' after 810 ns, '0' after 830 ns, '1' after 1510 ns, '0' after 1530 ns, '1' after 2210 ns, '0' after 2230 ns;
  
end architecture;
    
    
    