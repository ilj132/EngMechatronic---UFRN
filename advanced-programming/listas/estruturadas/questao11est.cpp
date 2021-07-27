/*Faça um programa para receber do usuário a dimensão e os elementos de um vetor
e efetuar a sua ordenação utilizando o método da bolha. Neste método de ordena-
ção, percorre-se o vetor comparando cada elemento com o seguinte: se eles esti-
verem na ordem errada, os elementos são permutados. O vetor é percorrido tantas
vezes quantas necessárias até que não seja necessário mudar nenhum elemento.*/

#include <iostream>

#define TRUE 1;
#define FALSE 0;

using namespace std;

void ordbolha(double array[], unsigned n);

int main()
{
    unsigned n;

    cout << "Digite o tamanho do array(n>=0) : " << endl;
    cin >> n;

    if (n <= 0)
    {
        cout << "dimensao invalida, programa encerrado" << endl;
        return 0;
    }

    double *array = new double[n];
    cout << "Digite os elementos do array:        " << endl;
    for (unsigned i = 0; i < n; i++)
        cin >> array[i];
    cout << "Elementos digitados:     ";
    for (unsigned i = 0; i < n; i++)
        cout << " " << array[i];
    cout << endl;

    ordbolha(array, n);

    cout << "Elementos ordenados da array:        ";
    for (unsigned i = 0; i < n; i++)
        cout << " " << array[i];
    cout << endl;

    if (array != NULL)
        delete[] array;
}

void ordbolha(double array[], unsigned n)
{
    unsigned i = 0, j = 0;
    double temp = 0.0;
    bool troca = true;

    for (i = n - 1; (i >= 1) && (troca == true); i--)
    {
        troca = false;
        for (j = 0; j < i; j++)
        {
            if (array[j] > array[j + 1])
            {
                temp = array[j];
                array[j] = array[j + 1];
                array[j + 1] = temp;
                troca = true;
            }
        }
    }
}