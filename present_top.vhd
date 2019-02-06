library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
use work.all;
entity present_top is
  port( clk, rst_b : in std_logic;
  key_valid, plain_valid : in std_logic;
  plaintext : in std_logic_vector( 63 downto 0);
  key : in std_logic_vector( 79 downto 0);
  ciphertext : out std_logic_vector( 63 downto 0);
  cipher_valid: out std_logic);
end entity;

architecture struct of present_top is
  component present_addkey
    port ( input1, key : in std_logic_vector(63 downto 0);
           output : out std_logic_vector(63 downto 0));
  end component;
  component present_counter
    port ( cnt_en, cnt_load, clk, rst_b : in std_logic;
  done : out std_logic;
  counter : out std_logic_vector( 5 downto 0));
  end component;
  component present_FSM
    port( clk, rst_b: in std_logic;
  key_valid,plain_valid,done : in std_logic;
  sel_keyreg, sel_reg : out std_logic_vector(1 downto 0);
  sel_mux, cnt_en, cnt_load,ready : out std_logic);
  end component;
  component present_keyreg
    port(clk, rst_b: in std_logic;
    sel_keyreg: in std_logic_vector(1 downto 0);
    input: in std_logic_vector(79 downto 0);
  key_valid : in std_logic;
  counter : in std_logic_vector(5 downto 0);
  --  input1024: in std_logic_vector(1023 downto 0);
    output: out std_logic_vector(63 downto 0));
  end component;
  component present_mux 
     port ( sel_mux : in std_logic;
  input1, input2 : in std_logic_vector( 63 downto 0);
  output : out std_logic_vector(63 downto 0));
  end component;
  component present_permutation
     port(
       input : in std_logic_vector( 63 downto 0);
  output : out std_logic_vector(63 downto 0));
  end component;
  component present_reg 
 port(clk, rst_b: in std_logic;
    sel_reg: in std_logic_vector(1 downto 0);
    input: in std_logic_vector(63 downto 0);
  --  input1024: in std_logic_vector(1023 downto 0);
    output: out std_logic_vector(63 downto 0));
  end component;
 component present_sbox
    port ( input : in std_logic_vector( 3 downto 0);
  output : out std_logic_vector( 3 downto 0));
 end component;
 for all : present_addkey use entity work.present_addkey(rtl);
 for all : present_counter use entity work.present_counter(rtl);
 for all : present_FSM use entity work.present_FSM(rtl);
 for all : present_keyreg use entity work.present_keyreg(rtl);
 for all : present_mux use entity work.present_mux(rtl);
 for all : present_permutation use entity work.present_permutation(rtl);
 for all : present_reg use entity work.present_reg(rtl);
 for all : present_sbox use entity work.present_sbox(rtl);
 signal reg_out,mux_out,addkey_out,sbox_out,permutation_out,round_key : std_logic_vector ( 63 downto 0);
 signal sel_reg,sel_keyreg : std_logic_vector( 1 downto 0);
 signal sel_mux,cnt_en, cnt_load, done,ready : std_logic;
 signal counter : std_logic_vector ( 5 downto 0);
 begin
 G0: present_mux port map (sel_mux=>sel_mux, input1=>reg_out, input2=>plaintext, output=>mux_out);
 G1: present_addkey port map ( mux_out, round_key, addkey_out);
 G2: present_sbox port map (addkey_out (3 downto 0), sbox_out(3 downto 0));
G3: present_sbox port map  (addkey_out (7 downto 4), sbox_out(7 downto 4));
G4: present_sbox port map (addkey_out (11 downto 8), sbox_out(11 downto 8));
G5: present_sbox port map (addkey_out (15 downto 12), sbox_out(15 downto 12));
G6: present_sbox port map (addkey_out (19 downto 16), sbox_out(19 downto 16));
G7: present_sbox port map (addkey_out (23 downto 20), sbox_out(23 downto 20));
G8: present_sbox port map (addkey_out (27 downto 24), sbox_out(27 downto 24));
G9: present_sbox port map (addkey_out (31 downto 28), sbox_out(31 downto 28));
G10: present_sbox port map (addkey_out (35 downto 32), sbox_out(35 downto 32));
G11: present_sbox port map (addkey_out (39 downto 36), sbox_out(39 downto 36));
G12: present_sbox port map (addkey_out (43 downto 40), sbox_out(43 downto 40));
G13: present_sbox port map (addkey_out (47 downto 44), sbox_out(47 downto 44));
G14: present_sbox port map (addkey_out (51 downto 48), sbox_out(51 downto 48));
G15: present_sbox port map (addkey_out (55 downto 52), sbox_out(55 downto 52));
G16: present_sbox port map (addkey_out (59 downto 56), sbox_out(59 downto 56));
G17: present_sbox port map (addkey_out (63 downto 60), sbox_out(63 downto 60));
 G18: present_permutation port map (sbox_out, permutation_out);
 G19: present_reg port map(clk, rst_b, sel_reg, permutation_out, reg_out);
 G20: present_counter port map( cnt_en, cnt_load, clk, rst_b, done, counter);
 G21: present_keyreg port map ( clk, rst_b, sel_keyreg, key , key_valid, counter, round_key);
 G22: present_FSM port map ( clk, rst_b, key_valid, plain_valid, done,sel_keyreg,sel_reg,sel_mux, cnt_en, cnt_load,ready);

 process (ready)
 begin
   if(ready ='1') then
     ciphertext <= reg_out xor round_key;
     cipher_valid<='1';
   else 
     cipher_valid <= '0';
   end if;
 end process;
end architecture;
