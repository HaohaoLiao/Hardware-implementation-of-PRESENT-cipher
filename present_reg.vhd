library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
use work.all;
entity present_reg is
  port(clk, rst_b: in std_logic;
    sel_reg: in std_logic_vector(1 downto 0);
    input: in std_logic_vector(63 downto 0);
  --  input1024: in std_logic_vector(1023 downto 0);
    output: out std_logic_vector(63 downto 0));
end entity;

architecture rtl of present_reg is
  signal reg: std_logic_vector(63 downto 0);
begin
  p0:process(rst_b, clk)
  begin
    if (rst_b='0') then
      reg<=(others=>'0');
    elsif (clk='1' and clk'event) then
      case sel_reg is
      when "00"=> reg<=reg;
      when "01"=> reg<=input;
     -- when "10"=> reg(1599 downto 1024)<=reg(1599 downto 1024);
     --             reg(1023 downto 0)<=reg(1023 downto 0) xor input1024;
      when "11"=> reg<=(others=>'0');
      when others=>null;
      end case;
    else
      null;
    end if;
  end process;
  output<=reg;
end rtl;
