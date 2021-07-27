/* 
  Crie uma função que receba como parâmetro um vetor de float, definido de tal
  forma que o último número seja zero. Esta função deve retornar a diferença entre
  a média dos números contidos neste vetor e o menor dos números, não contando com
  o zero final. Exemplo: Vetor: (1, 7, 4, 0); Média: 4; Menor: 1; 
  Retorno = média - menor = 3;  
*/

#include <iostream>

using namespace std;

float dif(float vet[])
{
  float soma = 0.0, menor = vet[0], media = 0.0;
  unsigned tam = sizeof(vet) / sizeof(float);
  for (unsigned i = 0; i < tam; i++)
  {
    soma += vet[i];
    media = soma / tam;
    if (vet[i] < menor)
    {
      menor = vet[i];
    }
  }
  return (media - menor);
}

int main()
{
  unsigned i = 0, N = 0;
  float num, *arr = NULL;

  cout << "Digite os numeros(0 para parar): " << endl;
  do
  {
    cin >> num;
    if (num != 0)
    {
      float *prov = new float[N + 1];
      for (i = 0; i < N; i++)
        prov[i] = arr[i];
      prov[N] = num;
      if (arr != NULL)
        delete[] arr;
      arr = prov;
      N++;
    }
  } while (num != 0);

  if (N == 0)
  {
    cout << "Voce n digitou nenhum numero valido" << endl;
    return 0;
  }

  cout << "A diferenca entre a media de numeros e o menor numero eh: " << dif(arr) << endl;

  if (arr != NULL)
    delete[] arr;

  return 0;
}