library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
use work.all;
entity present_counter is 
  port ( cnt_en, cnt_load, clk, rst_b : in std_logic;
  done : out std_logic;
  counter : out std_logic_vector( 5 downto 0));
end entity;
architecture rtl of present_counter is
signal cnt : std_logic_vector ( 5 downto 0);
begin
  
  process(clk, rst_b)
  begin
    if(rst_b ='0') then
      cnt <= "000001";
    elsif( cnt_load ='1')and(clk='1' and clk'event) then
      cnt <= "000001";
    elsif( cnt_en ='1' ) and (clk='1' and clk'event) then
      cnt <= cnt +"000001";
    else
      null;
    end if;
  end process;
  counter <= cnt;
  done <= cnt(4) and cnt(3) and cnt(2) and cnt(1) and cnt(0);
end architecture;
