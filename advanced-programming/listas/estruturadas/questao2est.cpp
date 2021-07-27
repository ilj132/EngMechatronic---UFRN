/*Fazer um programa que recebe um símbolo de operação do usuário (+, -, / ou *) e dois números reais. O programa deve retornar o 
resultado da operação recebida sobre estes dois números. Este funcionamento deve ser repetido até que o símbolo seja algo que não 
corresponda a nenhuma das quatro operações reconhecidas. */

#include <iostream>

using namespace std;

int main()
{
    bool status = 1;
    char op;
    float num1 = 0.0, num2 = 0.0;

    while (status)
    {
        cout << "Digite o valor do primeiro numero: " << endl;
        cin >> num1;
        cout << "Digite o valor do segundo numero: " << endl;
        cin >> num2;
        cout << "Digite a operacao que quer" << endl;
        cin >> op;
        switch (op)
        {
        case '+':
            cout << num1 + num2 << endl;
            break;
        case '-':
            cout << num1 - num2 << endl;
            break;
        case '/':
            cout << num1 / num2 << endl;
            break;
        case '*':
            cout << num1 * num2 << endl;
            break;
        default:
            cout << "Operacao invalida, programa encerrado" << endl;
            status = 0;
            break;
        }
    }
}