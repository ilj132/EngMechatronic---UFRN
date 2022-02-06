ENTITY somador_2_bits IS
    PORT(
        A: IN bit_vector(1 downto 0);
        B: IN bit_vector(1 downto 0);
        S: OUT bit_vector(2 downto 0)
    );
end somador_2_bits;
  
ARCHITECTURE logic OF somador_2_bits IS
  
signal  A1, A0, B1, B0, nA1, nA0, nB1, nB0: bit;
  
BEGIN
    A1 <= A(1);
    A0 <= A(0);
    B1 <= B(1);
    B0 <= B(0); 
    nA1 <= not(A(1));
    nA0 <= not(A(0));
    nB1 <= not(B(1));
    nB0 <= not(B(0));
    
    S(2) <= (A0 and B1 and B0) or (A1 and B1) or (A1 and A0 and B0);
    
    S(1) <= (nA1 and nA0 and B1) or (nA1 and A0 and nB1 and B0) or
          (nA1 and B1 and nB0) or (A1 and nA0 and nB1) or
          (A1 and nB1 and nB0) or (A1 and A0 and B1 and B0);
          
    S(0) <= (nA0 and B0) or (A0 and nB0);
    
END logic;