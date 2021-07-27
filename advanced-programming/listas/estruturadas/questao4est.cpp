/*Qual o resultado da execução do seguinte programa, supondo que o usuário digite os valores 3 e 4? De uma maneira geral, o que faz este programa? 

Ao substituir o tipo da função main para 'int', o programa permite multiplicar os dois numeros digitados.

*/
#include <iostream>
using namespace std;
int main()
{
    int x, y, p, a;
    cout << "Informe dois números :" << endl;
    cin >> x;
    cin >> y;
    p = 0;
    a = y;
    while (a > 0)
    {
        p += x;
        a--;
    }
    cout << "\nResultado : " << p << endl;
}