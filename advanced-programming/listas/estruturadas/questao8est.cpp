/*Desenvolver a função INVERTE que recebe um número (unsigned int) como
 parâmetro e retorna este número invertido. Ex: 431 retorna 134. */

#include <iostream>
#include <cmath>

using namespace std;

int lertamanho(int n)
{
  int tam = 0;
  while (n >= 1)
  {
    n /= 10;
    tam++;
  }
  return tam;
}

int inverte(int n, int tam)
{
  int temp1 = 0, temp2 = 0;
  while (n >= 1)
  {
    temp1 = n % 10;
    n /= 10;
    temp2 += (temp1 * tam);
    tam /= 10;
  }
  return temp2;
}

int main()
{
  unsigned num = 0, tam = 0, rev = 0;

  cout << "Digite um valor(>0) : " << endl;
  cin >> num;

  tam = lertamanho(num);

  //cout << pow(10, tam - 1) << endl;

  rev = inverte(num, pow(10, tam - 1));

  cout << "Valor digitado:  " << num << endl
       << "Valor invertido: " << rev << endl;

  return 0;
}