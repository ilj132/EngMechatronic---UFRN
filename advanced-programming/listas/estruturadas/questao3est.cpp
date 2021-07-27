/*Fazer um programa que sorteie um número de 0 a 100 e que permita que o usuário (sem conhecer o número sorteado) tente acertar. 
Caso não acerte, o programa de-ve imprimir uma mensagem informando se o número sorteado é maior ou menor que a tentativa feita.
 Ao acertar o número, o programa deve imprimir a quantidade de tentativas feitas.*/

#include <iostream>
#include <ctime>

using namespace std;

int main()
{
    unsigned num = 0, N = 0, attempt = 0;

    srand(time(NULL));

    num = rand() % 101;

    do
    {
        cout << "Digite uma tentativa: " << endl;
        cin >> attempt;

        if (num < attempt)
            cout << "Tentativa maior do que o numero sorteado, tente novamente." << endl;
        if (num > attempt)
            cout << "Tentativa menor do que o numero sorteado, tente novamente." << endl;

    } while (num != attempt);

    cout << "Voce acertou, o numero eh: " << num << endl;

    return 0;
}