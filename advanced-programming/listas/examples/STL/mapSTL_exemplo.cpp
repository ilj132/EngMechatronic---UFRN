#include <map>
#include <string>
#include <iostream>

using namespace std;

int main()
{
  map<string, int> digitos;
  map<string, int>::iterator iter; // o nosso iterator

  digitos["zero"] = 0;
  digitos["um"] = 1;
  digitos["dois"] = 2;
  digitos["tres"] = 3;
  digitos["quatro"] = 4;
  digitos["cinco"] = 5;
  digitos["seis"] = 6;
  digitos["sete"] = 7;
  digitos["oito"] = 8;
  digitos["nove"] = 9;

  for (iter = digitos.begin(); iter != digitos.end(); iter++) {
    cout << iter->first << " = " << iter->second << endl;
  }
  // Deve imprimir (em ordem alfabética das chaves):
  // cinco = 5
  // dois = 2
  // nove = 9
  // ...
  // três = 3
  // um = 1
  // zero = 0

  return 0;
}
