ENTITY COMP_4B IS
  PORT(
      A, B: IN bit_vector(3 downto 0);
      LT: OUT BIT;
      EQ: OUT BIT;
      GT: OUT BIT
  );
END COMP_4B;

ARCHITECTURE logic OF COMP_4B IS
  
  BEGIN
    GT <= '1' when (A > B)
    else '0';
    EQ <= '1' when (A = B)
    else '0';  
    LT <= '1' when (A < B)
    else '0';
    
END logic;