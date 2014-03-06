--* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
--* * * * * * * * * * * * * * * * VHDL Source Code  * * * * * * * * * * * * * *
--* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
--* Title           :  Test_Counter
--* Filename & Ext  :  test_counter.vhdl
--* Author          :  David Bishop  <dbishop@vhdl.org> X-XXXXX
--* Created         :  1999/03/12
--* Last modified   :  $Date: 1999-03-12 16:20:26-05 $
--* WORK Library    :  ASICNAME
--* Description     :  Variable width counter and a register
--* Known Bugs      :
--*                 :  
--* RCS Summary     :  $Id: test_counter.vhdl,v 1.1 1999-03-12 16:20:26-05 bishop Exp $
--*                 :
--* Mod History     :  $Log: test_counter.vhdl,v $
--* Mod History     :  Revision 1.1  1999-03-12 16:20:26-05  bishop
--* Mod History     :  Initial revision
--* Mod History     :  Changed comment header
--*                 :
--* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity test_counter is
  generic ( width : integer := 17 );
  port ( clk	: in std_ulogic;
         reset	: in std_ulogic;
         enable : in std_ulogic;
         count	: out std_logic_vector ( width - 1 downto 0) );
end test_counter;

-------------------------------------------------------------------------------
--  RTL description.  Adds 1 on every clock pulse when enable is asserted.
-------------------------------------------------------------------------------

architecture rtl of test_counter is
  constant terminal_count : integer := 2**width - 1;
  subtype counter_range is integer range 0 to terminal_count;
  signal count_int : counter_range;
begin  --  rtl 

  count <= std_logic_vector (to_unsigned ( count_int, width ));

  counter : process ( clk, reset )
  begin
    if reset = '0' then
      count_int <= 0;
    elsif rising_edge ( clk ) then
      if enable = '1' then
        if count_int = terminal_count then
          count_int <= 0;
        else
          count_int <= count_int + 1;
        end if;
      end if;
    end if;
  end process counter;

end rtl;





