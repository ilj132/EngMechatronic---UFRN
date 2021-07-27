/*Fazer uma função que recebe um dia, um mês e um ano como parâmetros e retor-na o número de dias desde o início daquele ano.
 Para o dia 1º de janeiro de qual-quer ano, a função deve retornar 1. Para o dia 31 de dezembro, ela deve retornar 365 ou 366, 
dependendo de o ano ser ou não bissexto. Um ano é bissexto quando é múltiplo de 400 ou também quando é múltiplo de 4 e não 
múltiplo de 100. */

#include <iostream>

using namespace std;

int main()
{
    unsigned i = 0, day = 0, month = 0, year = 0, sum = 0;

    cout << "Digite o dia: " << endl;
    cin >> day;
    cout << "Digite o mes: " << endl;
    cin >> month;
    cout << "Digite o ano: " << endl;
    cin >> year;

    for (i = 1; i < month; i++)
    {
        switch (i)
        {
        case 2:
            sum += 28;
            break;
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            sum += 31;
            break;
        default:
            sum += 30;
            break;
        }
    }

    sum += day;

    if (month > 3 && (year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)))
        sum++;

    cout << "O numero de dias desde o inicio do ano eh: " << sum << endl;
    return 0;
}