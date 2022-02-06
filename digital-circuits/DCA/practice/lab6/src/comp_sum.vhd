library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity somador2bits is
    generic (
        width: integer := 2
);
  
    port (
        cin: in std_logic;
        A: in std_logic_vector(width - 1 downto 0);
        B: in std_logic_vector(width - 1 downto 0);
        S: out std_logic_vector(width - 1 downto 0);
        cout: out std_logic
    );
  
end somador2bits;
  
architecture behavior of somador2bits is
  
signal sum: std_logic_vector(width downto 0);
  
begin
  
        sum <= ('0' & A) + ('0' & B) + cin;
        S <= sum(width-1 downto 0);
        cout <= sum(width);
  
end behavior ;