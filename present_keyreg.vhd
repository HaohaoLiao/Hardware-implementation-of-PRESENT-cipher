library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
use work.all;
entity present_keyreg is
  port(clk, rst_b: in std_logic;
    sel_keyreg: in std_logic_vector(1 downto 0);
    input: in std_logic_vector(79 downto 0);
  key_valid : in std_logic;
  counter : in std_logic_vector(5 downto 0);
  --  input1024: in std_logic_vector(1023 downto 0);
    output: out std_logic_vector(63 downto 0));
end entity;

architecture rtl of present_keyreg is
  signal reg: std_logic_vector(79 downto 0);
  signal reg_out : std_logic_vector(3 downto 0);
  signal reg_xor : std_logic_vector(4 downto 0);
  component present_sbox 
    port ( input : in std_logic_vector( 3 downto 0);
  output : out std_logic_vector( 3 downto 0));
   end component;
   for all : present_sbox use entity work.present_sbox(rtl);
begin
  G0: present_sbox port map( reg(18 downto 15), reg_out(3 downto 0));
    reg_xor( 4 downto 0) <= reg( 38 downto 34) xor counter( 4 downto 0);
  p0:process(rst_b, clk,key_valid)
  -- reg_temp : std_logic_vector ( 63 downto 0);
  begin
    if (rst_b='0') then
      reg<=(others=>'0');
    elsif (key_valid ='1') then
      reg <= input;
    elsif (clk='1' and clk'event) then
      case sel_keyreg is
      when "00"=> reg<=reg;
      when "01"=> reg<=input;
      when "10"=> reg(79 downto 0) <= reg_out(3 downto 0)&reg(14 downto 0)&reg(79 downto 39)&reg_xor(4 downto 0)&reg(33 downto 19);
      when "11"=> reg<=(others=>'0');
      when others=>null;
      end case;
    else
      null;
    end if;
  end process;
  output<=reg(79 downto 16);
end rtl;
