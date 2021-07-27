/*Qual o resultado impresso após a execução do trecho de programa a seguir?
int i, j, *p;
i = 4;
j = 7;
p = &j;
*p = 9;
cout << i << “ “ << j << “ “ << *p;
*/

#include <iostream>

using namespace std;

int main()
{
    int i, j, *p;
    i = 4;
    j = 7;
    p = &j;
    *p = 9;
    cout << i << " " << j << " " << *p;
    //Saída: 4 9 9
}