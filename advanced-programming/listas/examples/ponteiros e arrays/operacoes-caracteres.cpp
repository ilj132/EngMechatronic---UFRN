#include <iostream>
#include <string>

/*
Neste programa, sao apresentadas algumas operacoes com sequencias de caractes.
Existem erros em linhas do programa. Tente encontra-los antes de compilar.
Alem disso, apos eliminar os erros, tente prever o que serah impresso antes de executar.
*/

using namespace std;

int main(void)
{
  /// Criacao e inicializacao

  char* pt_char="Adelardo";
  const char* pt_cchar="Adelardo";
  char ar_char[]="Adelardo";
  string st_char="Adelardo";

  /// Atribuicao

  pt_char="Medeiros";
  pt_cchar="Medeiros";
  ar_char="Medeiros";
  st_char="Medeiros";

  /// Alteracao de um caractere (aspas simples)

  pt_char[1] = 'E';
  pt_cchar[1] = 'E';
  ar_char[1] = 'E';
  st_char[1] = 'E';

  /// Alteracao de um caractere (aspas duplas)

  pt_char[1] = "E";
  pt_cchar[1] = "E";
  ar_char[1] = "E";
  st_char[1] = "E";

  /// Impressao

  cout << "Pt char = " << pt_char << endl;
  cout << "Pt cchar = " << pt_cchar << endl;
  cout << "Ar char = " << ar_char << endl;
  cout << "St char = " << st_char << endl;

  return 0;
}
