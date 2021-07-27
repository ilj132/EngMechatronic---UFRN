/*Fazer um programa no qual o usuário vai entrando sucessivamente com valores positivos ou nulos. Quando o usuário entrar com um valor negativo,
 o programa para de pedir valores e calcula a média dos valores já fornecidos (excluindo o último número negativo)*/

#include <iostream>

using namespace std;

int main()
{
    unsigned i = 0, N = 0;
    float num, *arr = NULL;

    cout << "Digite os valores: " << endl;

    do
    {
        cin >> num;
        if (num > 0)
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
    } while (num > 0);

    if (N == 0)
    {
        cout << "Voce n digitou nenhum numero positivo ou nulo" << endl;
        return 0;
    }

    float soma = 0.0, media = 0.0;
    for (i = 0; i < N; i++)
        soma += arr[i];
    media = soma / N;

    cout << "A media dos valores digitados eh: " << media << endl;

    if (arr != NULL)
        delete[] arr;

    return 0;
}