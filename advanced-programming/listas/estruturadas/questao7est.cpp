/*Fazer uma função que receba 3 números como parâmetros, A, B e C, e os ordene
 de tal forma que, ao final da função, A contenha o menor número e C o maior. 
 Em seguida, fazer um programa que receba 3 números do usuário, chame a função
  e mostre os números ordenados. */

#include <iostream>

using namespace std;

void ord(double &A, double &B, double &C)
{
  int temp;

  if (A > B)
  {
    temp = B;
    B = A;
    A = temp;
  }
  if (B > C)
  {
    temp = C;
    C = B;
    B = temp;
  }
  if (A > B)
  {
    temp = B;
    B = A;
    A = temp;
  }
}

int main()
{
  double A, B, C;
  cout << "Digite o valor A: " << endl;
  cin >> A;
  cout << "Digite o valor B: " << endl;
  cin >> B;
  cout << "Digite o valor A: " << endl;
  cin >> C;

  ord(A, B, C);
  cout << "A = " << A << " B= " << B << " C= " << C << endl;
  return 0;
}