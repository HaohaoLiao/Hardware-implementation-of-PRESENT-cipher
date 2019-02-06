LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_arith.ALL;

entity present_sbox is
 port ( input : in std_logic_vector( 3 downto 0);
  output : out std_logic_vector( 3 downto 0));
end entity;

architecture rtl of present_sbox is
begin
  process(input)
  begin
    case input is
      when "0000" =>
      output <= "1100";
    when "0001" =>
      output <= "0101";
    when "0010" =>
      output <= "0110";
    when "0011" =>
      output <= "1011";
    when "0100" =>
      output <= "1001";
    when "0101" =>
      output <= "0000";
    when "0110" =>
      output <= "1010";
    when "0111" =>
      output <= "1101";
    when "1000" =>
      output <= "0011";
    when "1001" =>
      output <= "1110";
    when "1010" =>
      output <= "1111";
    when "1011" =>
      output <= "1000";
    when "1100" =>
      output <= "0100";
    when "1101" =>
      output <= "0111";
    when "1110" =>
      output <= "0001";
    when "1111" =>
      output <= "0010";
    when others =>
      output <= input;
  end case;
end process;
end architecture;

