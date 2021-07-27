//Qual o erro no trecho de programa a seguir?
/* esse trecho de programa está errado */
/*int x, *p;
x = 10;
*p = x;
cout << *p;
*/

#include <iostream>

using namespace std;

int main()
{
    int x, *p;
    x = 10;

    //para onde o ponteiro 'p' está apontando?
    //ta desreferenciando o que, afinal?
    /*
    trecho correto de código:
    p=&x;
    cout<<*p; 

    Saída: 10
    */
    *p = x;
    cout << *p;
}