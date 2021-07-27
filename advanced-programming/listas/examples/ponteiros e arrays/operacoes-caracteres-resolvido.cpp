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

  char* pt_char="Adelardo"; // pt para char aponta para endereco que contem const chars (OBS 1)
  const char* pt_cchar="Adelardo"; // Versao "correta" da linha anterior
  char ar_char[]="Adelardo";
  string st_char="Adelardo";

  /// Atribuicao

  pt_char="Medeiros"; // pt para char aponta para endereco que contem const chars (OBS 1)
  pt_cchar="Medeiros"; // Versao "correta" da linha anterior
  //ar_char="Medeiros"; // Tentativa de mudar um array (o endereco dele)
  st_char="Medeiros";

  /// Alteracao de um caractere (aspas simples)

  //pt_char[1] = 'E'; // ERRO GRAVE, e compilador nao avisa do erro que vc estah cometendo! (OBS 2)
  //pt_cchar[1] = 'E'; // Compilador avisa erro, pois a variavel foi declarada corretamente
  ar_char[1] = 'E';
  st_char[1] = 'E';

  /// Alteracao de um caractere (aspas duplas)

  //pt_char[1] = "E"; // Nao se pode atribuir uma seq de chars a um char
  //pt_cchar[1] = "E"; // Nao se pode atribuir uma seq de chars a um char; alem disso, o char eh const
  //ar_char[1] = "E"; // Nao se pode atribuir uma seq de chars a um char
  //st_char[1] = "E"; // Nao se pode atribuir uma seq de chars a um char

  /// Impressao

  cout << "Pt char = " << pt_char << endl;
  cout << "Pt cchar = " << pt_cchar << endl;
  cout << "Ar char = " << ar_char << endl;
  cout << "St char = " << st_char << endl;

  return 0;
}

/*
OBS 1: Esse "quase erro" nao eh impedido pelo compilador! Alguns compiladores podem
emitir uma advertencia, assinalando que essa linha, embora do ponto de vista
estrito nao viole a sintaxe C++, do ponto de vista logico muito provavelmente
estah incorreta.
Nao estah comentado porque nao se trata de um erro absoluto, mas nao eh uma boa
pratica de programacao, pois impede o compilador de detectar erros como o da linha 30.
*/

/*
OBS 2: Essa eh a razao pela qual nao se deve ter um char* tendo como valor um
endereco no qual existem chars que nao podem ser alterados, pois nao residem em
uma area de memoria prevista para ser alterada. Caso nao se comente essa linha,
o compilador farah a compilacao e o programa provavelmente vai travar aqui na hora
da execucao, gerando um erro inexplicavel
*/
