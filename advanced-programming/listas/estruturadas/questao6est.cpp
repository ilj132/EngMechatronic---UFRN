/*Faça um programa que, dado um valor em reais (sem centavos), mostre a menor 
combinação existente de notas (R$ 100, 50, 20, 10, 5 e 2) para esse valor. */

#include <iostream>

using namespace std;

int contanotas(unsigned &v, unsigned q)
{
  unsigned n = 0;
  n = v / q;
  v %= q;
  return n;
}

int main()
{
  unsigned value;

  cout << "Digite o valor: " << endl;
  cin >> value;
  if (value <= 0)
  {
    cerr << "Valor incorreto" << endl;
    return 0;
  }

  unsigned not2 = 0, not5 = 0, not10 = 0, not20 = 0, not50 = 0, not100 = 0;

  not100 = contanotas(value, 100);
  not50 = contanotas(value, 50);
  not20 = contanotas(value, 20);
  not10 = contanotas(value, 10);
  not5 = contanotas(value, 5);
  not2 = contanotas(value, 2);

  cout << "Cedulas de R$ 100: " << not100 << endl;
  cout << "Cedulas de R$ 50: " << not50 << endl;
  cout << "Cedulas de R$ 20: " << not20 << endl;
  cout << "Cedulas de R$ 10: " << not10 << endl;
  cout << "Cedulas de R$ 5: " << not5 << endl;
  cout << "Cedulas de R$ 2: " << not2 << endl;
  cout << "TOTAL: " << 100 * not100 + 50 * not50 + 20 * not20 + 10 * not10 + 5 * not5 + 2 * not2 << endl;

  if (value != 0)
  {
    cerr << "Houve um problema com esse algoritmo!\n";
    cerr << "Veja que fica faltando R$ " << value << " para completar o valor total!!\n";
    cerr << "Voce pode tentar encontrar e corrigir o erro?\n";
  }
  return 0;
}