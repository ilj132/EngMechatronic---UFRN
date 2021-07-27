#include <iostream>
#include <vector>

using namespace std;

int main()
{
  vector<int> meuVetor; // cria um vetor de inteiros vazio
  vector<int>::iterator j; // iterador para vetor de inteiros

  meuVetor.push_back(7); // inclui no fim do vetor um elemento
  meuVetor.push_back(11);
  meuVetor.push_back(2006);

  // vai imprimir tres elementos {7, 11, 2006}
  cout << "Imprimindo o vetor...: ";
  for ( j = meuVetor.begin(); j != meuVetor.end(); j++ )
    cout << *j << ' ';
  cout << endl;

  // insere 55 como segundo elemento, deslocando os demais
  meuVetor.insert( meuVetor.begin()+1, 55);

  // agora, vai imprimir quatro elementos {7, 55, 11, 2006}
  cout << "Inseri no meio do vetor..: ";
  for ( j = meuVetor.begin(); j != meuVetor.end(); j++ )
    cout << *j << ' ';
  cout << endl;

  // retira 11 da lista (terceira posicao)
  meuVetor.erase( meuVetor.begin() + 2);

  // agora, tem que imprimir tres de novo {7, 55, 2006}
  cout << "Retirei no meio do vetor..: ";
  for ( j = meuVetor.begin(); j != meuVetor.end(); j++ )
    cout << *j << ' ';
  cout << endl;

  // limpa todo o vetor
  meuVetor.clear();

  return 0;
  }
