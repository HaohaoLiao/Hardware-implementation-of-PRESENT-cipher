library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_signed.all;
use work.all;
entity present_FSM is
  port( clk, rst_b: in std_logic;
  key_valid,plain_valid,done : in std_logic;
  sel_keyreg, sel_reg : out std_logic_vector(1 downto 0);
  sel_mux, cnt_en, cnt_load,ready : out std_logic);
end entity;
architecture rtl of present_FSM is
  TYPE state_typ IS (IDLE,wait_plain, ENCRYPTION,ADD_LAST_KEY);
  signal cstate, nstate : state_typ;
begin
  process(clk, rst_b)
  begin
    if(rst_b ='0') then
      cstate <= IDLE;
    elsif(clk='1' and clk'event) then
      cstate <= nstate;
    else
      null;
    end if;
  end process;
  process(key_valid,plain_valid, cstate,done)
  begin
    case cstate is
      when IDLE =>
        if (key_valid ='1') then
          nstate <= wait_plain;
          sel_keyreg <="01"; 
        else 
          sel_keyreg <= "00";
        end if;
        cnt_en <='0';
        cnt_load <='1';
        sel_reg <= "11";
        sel_mux <='1';
        ready <='0';
      when wait_plain =>
        if( plain_valid ='1') then
          nstate <= ENCRYPTION;
          sel_mux <= '1';
          sel_keyreg <="10";
          cnt_en <= '1';
          cnt_load <= '0';
          sel_reg <= "01";
        else
          sel_keyreg <= "00";
         -- cnt_en<= '0';
         -- cnt_load <='1';
        end if;
       -- sel_keyreg <="10";
        --sel_reg <= "01";
      when ENCRYPTION=>
        if( done ='1') then
        nstate <= ADD_LAST_KEY;
      else
        null;
      end if;
        sel_mux <= '0';
        cnt_en <= '1';
        cnt_load <='0';
        sel_keyreg <= "10";
        sel_reg <= "01";
      when ADD_LAST_KEY=>
        nstate <= IDLE;
        sel_keyreg <="00";
        sel_reg <= "00";
        cnt_en <='0';
        cnt_load <= '1';
        ready <= '1';
    end case;
  end process;
end architecture;
