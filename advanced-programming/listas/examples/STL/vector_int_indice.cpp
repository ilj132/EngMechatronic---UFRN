#include <iostream>
#include <vector>

using namespace std;

int main()
{
  vector<int> meuVetor; // cria um vetor de inteiros vazio
  int i;                // indice para percorrer vetor

  if (meuVetor.empty()) // testa se o vetor está vazio
    cout << "Vetor vazio!" << endl;
  else
    cout << "Vetor com elementos!" << endl;

  meuVetor.push_back(7); // inclui elemento no fim do vetor
  meuVetor.push_back(11);
  meuVetor.push_back(2006);

  // vai imprimir tres elementos {7, 11, 2006}
  cout << "Imprimindo o vetor...: ";
  for (i = 0; i < meuVetor.size(); i++)
    cout << meuVetor[i] << ' ';
  cout << endl;

  meuVetor.pop_back(); // retira o ultimo elemento

  // agora, soh vai imprimir dois {7, 11}
  cout << "Meu vetor, de novo...: ";
  for (int i = 0; i < meuVetor.size(); i++)
    cout << meuVetor[i] << ' ';
  cout << endl;

  return 0;
}
