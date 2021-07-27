library ieee;
use ieee.std_logic_1164.all;

entity MUX21 is
    port(A, B, S: in STD_LOGIC;
       O: out STD_LOGIC);
end MUX21;

architecture CKT of MUX21 is

begin

    O <= (B and S) or (A and (not S));

end CKT;