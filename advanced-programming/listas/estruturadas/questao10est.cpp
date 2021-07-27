/*Fazer um programa que receba do usuário uma quantidade N de números a ser digitada.
 Em seguida, o programa deve solicitar N números do usuário.No final, o programa exibe 
 o máximo, o mínimo e a média dos valores digitados e quantos va-lores estão acima da 
 média.*/

#include <iostream>
#include <climits>

#define maximo INT_MAX;
#define minimo INT_MIN;

using namespace std;

int main()
{
  unsigned N = 0, i = 0;
  int menor = maximo;
  int maior = minimo;

  cout << "Digite a quantidade N de numeros : " << endl;
  cin >> N;

  if (N <= 0)
  {
    cout << "Dimensao digitada incorreta, programa encerrado." << endl;
    return 0;
  }

  unsigned j = 0;
  float *arr = new float[N];
  float soma = 0.0, media = 0.0;

  //armazenando valores e calculando media, maior e menor numero;
  for (i = 0; i < N; i++)
  {
    cin >> arr[i];
    soma += arr[i];
    media = soma / N;
    if (arr[i] < menor)
      menor = arr[i];
    if (arr[i] > maior)
      maior = arr[i];
  }
  //testando os valores que estão acima da media;
  float *mediapp = new float[N];
  for (i = 0; i < N; i++)
  {
    if (arr[i] > media)
    {
      mediapp[j] = arr[i];
      j++;
    }
  }

  cout << "Valores digitados : ";
  for (i = 0; i < N; i++)
    cout << " " << arr[i];

  cout << endl
       << "Valores maiores que a media : ";
  for (i = 0; i < j; i++)
    cout << " " << mediapp[i];
  cout << endl
       << "Media:    " << media << endl
       << "Maior:   " << maior << endl
       << "Menor:    " << menor << endl;

  if (arr != NULL)
    delete[] arr;
  if (mediapp != NULL)
    delete[] mediapp;

  return 0;
}