#include <iostream>
#include <iomanip>
#include <fstream>
#include <cstdlib>   /* srand, rand */
#include <string>
#include <time.h>
#include <cmath>
#include <list>
#include <algorithm>

#include "labirinto.h"

using namespace std;

/* ***************** */
/* CLASSE CELULA     */
/* ***************** */

string estadoCel2string(EstadoCel E)
{
  switch(E)
  {
  case EstadoCel::LIVRE:
    return "  ";
  case EstadoCel::OBSTACULO:
    return "##";
  case EstadoCel::ORIGEM:
    return "Or";
  case EstadoCel::DESTINO:
    return "De";
  case EstadoCel::CAMINHO:
    return "..";
  default:
    break;
  }
  return "??";
}

istream& operator>>(istream& I, Coord& C)
{
  I >> C.lin >> C.col;
  return I;
}

ostream& operator<<(ostream& O, const Coord& C)
{
  O << C.lin << ';' << C.col;
  return O;
}

/* ***************** */
/* CLASSE NOH        */
/* ***************** */

ostream& operator<<(ostream& O, const Noh& N)
{
  O << '[' << N.pos << '|' << N.ant << '|'
    << N.custoTotal() << ']';
  return O;
}

// Calcula o custo futuro de um Noh ateh o destino
void Noh::heuristica(const Coord& Dest)
{
  static double sqrt2 = sqrt(2.0); // Para calcular soh uma vez

  Coord delta = abs(Dest-pos);

  // Distancia diagonal
  h = sqrt2*min(delta.lin,delta.col) +
      abs(delta.lin-delta.col);
  /*
  // Distancia Euclidiana
  h = norm(Dest-pos);
  */
}

/* ***************** */
/* CLASSE LABIRINTO  */
/* ***************** */

/// Torna o mapa vazio
void Labirinto::clear()
{
  // Esvazia o mapa de qualquer conteudo anterior
  NL = NC = 0;
  mapa.clear();
  // Apaga a origem e destino do caminho
  orig = dest = Coord();
}

/// Limpa o caminho anterior
void Labirinto::limpaCaminho()
{
  if (!empty()) for (unsigned i=0; i<NL; i++) for (unsigned j=0; j<NC; j++)
  {
    if (at(i,j) == EstadoCel::CAMINHO)
    {
      set(i,j) = EstadoCel::LIVRE;
    }
  }
}

/// Leh um mapa do arquivo nome_arq
/// Caso nao consiga ler do arquivo, cria mapa vazio
/// Retorna true em caso de leitura bem sucedida
bool Labirinto::ler(const string& nome_arq)
{
  // Limpa o mapa
  clear();

  // Abre o arquivo
  ifstream arq(nome_arq.c_str());
  if (!arq.is_open())
  {
    return false;
  }

  string prov;
  int numL, numC;
  int valor;

  // Leh o cabecalho
  arq >> prov >> numL >> numC;
  if (prov != "LABIRINTO" ||
      numL<ALTURA_MIN_MAPA || numL>ALTURA_MAX_MAPA ||
      numC<LARGURA_MIN_MAPA || numC>LARGURA_MAX_MAPA)
  {
    arq.close();
    return false;
  }

  // Redimensiona o mapa
  NL = numL;
  NC = numC;
  mapa.resize(NL*NC);

  // Leh as celulas do arquivo
  for (unsigned i=0; i<NL; i++) for (unsigned j=0; j<NC; j++)
  {
    arq >> valor;
    set(i,j) = (valor==0 ?
                EstadoCel::OBSTACULO :
                EstadoCel::LIVRE);
  }
  arq.close();
  return true;
}

/// Salva um mapa no arquivo nome_arq
/// Retorna true em caso de escrita bem sucedida
bool Labirinto::salvar(const string& nome_arq) const
{
  // Testa o mapa
  if (empty()) return false;

  // Abre o arquivo
  ofstream arq(nome_arq.c_str());
  if (!arq.is_open())
  {
    return false;
  }

  // Salva o cabecalho
  arq << "LABIRINTO " << NL << ' ' << NC << endl;

  // Salva as celulas do mapa
  for (unsigned i=0; i<NL; i++)
  {
    for (unsigned j=0; j<NC; j++)
    {
      arq << (at(i,j) == EstadoCel::OBSTACULO ? 0 : 1 ) << ' ';
    }
    arq << endl;
  }

  arq.close();
  return true;
}

/// Gera um novo mapa aleatorio
/// numL e numC sao as dimensoes do labirinto
/// perc_obst eh o percentual de casas ocupadas no mapa. Se <=0, assume um valor aleatorio
/// entre PERC_MIN_OBST e PERC_MAX_OBST
/// Se os parametros forem incorretos, gera um mapa vazio
/// Retorna true em caso de geracao bem sucedida (parametros corretos)
bool Labirinto::gerar(unsigned numL, unsigned numC, double perc_obst)
{
  // Limpa o mapa
  clear();

  // Inicializa a semente de geracao de numeros aleatorios
  srand(time(NULL));

  // Calcula o percentual de obstaculos no mapa
  if (perc_obst <= 0.0)
  {
    perc_obst = PERC_MIN_OBST +
                (PERC_MAX_OBST-PERC_MIN_OBST)*(rand()/double(RAND_MAX));
  }

  // Testa os parametros
  if (numL<ALTURA_MIN_MAPA || numL>ALTURA_MAX_MAPA ||
      numC<LARGURA_MIN_MAPA || numC>LARGURA_MAX_MAPA ||
      perc_obst<PERC_MIN_OBST || perc_obst>PERC_MAX_OBST)
  {
    return false;
  }

  // Assume as dimensoes passadas como parametro
  NL = numL;
  NC = numC;

  // Redimensiona o mapa
  mapa.resize(NL*NC);

  // Preenche o mapa
  bool obstaculo;
  for (unsigned i=0; i<NL; i++) for (unsigned j=0; j<NC; j++)
  {
    obstaculo = (rand()/double(RAND_MAX) <= perc_obst);
    set(i,j) = (obstaculo ?
                EstadoCel::OBSTACULO :
                EstadoCel::LIVRE);
  }
  return true;
}

/// Testa se uma celula eh valida dentro de um mapa
bool Labirinto::coordValida(const Coord& C) const
{
  if (!C.valida()) return false;
  if (C.lin >= int(NL)) return false;
  if (C.col >= int(NC)) return false;
  return true;
}

/// Testa se uma celula estah livre (nao eh obstaculo) em um mapa
bool Labirinto::celulaLivre(const Coord& C) const
{
  if (!coordValida(C)) return false;
  if (at(C) == EstadoCel::OBSTACULO) return false;
  return true;
}

/// Testa se um movimento Orig->Dest eh valido
bool Labirinto::movimentoValido(const Coord& Orig, const Coord& Dest) const
{
  // Soh pode mover de e para celulas livres
  if (!celulaLivre(Orig)) return false;
  if (!celulaLivre(Dest)) return false;

  // Soh pode mover para celulas vizinhas
  Coord delta=abs(Dest-Orig);
  if (delta.lin>1 || delta.col>1) return false;

  // Nao pode mover em diagonal se colidir com alguma quina
  // Se o movimento nao for diagonal, esses testes sempre dao certo,
  // pois jah testou que Orig e Dest estao livres e ou a linha ou a
  // coluna de Orig e Dest sao iguais
  if (!celulaLivre(Coord(Orig.lin,Dest.col))) return false;
  if (!celulaLivre(Coord(Dest.lin,Orig.col))) return false;

  // Movimento valido
  return true;
}

/// Fixa a origem do caminho a ser encontrado
bool Labirinto::setOrigem(const Coord& C)
{
  if (!celulaLivre(C)) return false;
  // Se for a mesma origen nao faz nada
  if (C==orig) return true;

  limpaCaminho();

  // Apaga a origem anterior no mapa, caso esteja definida
  if (coordValida(orig)) set(orig) = EstadoCel::LIVRE;

  // Fixa a nova origem
  orig = C;
  // Marca a nova origem no mapa
  set(orig) = EstadoCel::ORIGEM;

  return true;
}

/// Fixa o destino do caminho a ser encontrado
bool Labirinto::setDestino(const Coord& C)
{
  if (!celulaLivre(C)) return false;
  // Se for o mesmo destino nao faz nada
  if (C==dest) return true;

  limpaCaminho();

  // Apaga o destino anterior no mapa, caso esteja definido
  if (coordValida(dest)) set(dest) = EstadoCel::LIVRE;

  // Fixa o novo destino
  dest = C;
  // Marca o novo destino no mapa
  set(dest) = EstadoCel::DESTINO;

  return true;
}

/// Imprime o mapa no console
void Labirinto::imprimir() const
{
  if (empty())
  {
    cout << "+------------+" << endl;
    cout << "| MAPA VAZIO |" << endl;
    cout << "+------------+" << endl;
    return;
  }

  unsigned i,j;

  // Impressao do cabecalho
  cout << "    ";
  for (j=0; j<NC; j++)
  {
    cout << setfill('0') << setw(2) << j << setfill(' ') << setw(0) << ' ' ;
  }
  cout << endl;

  cout << "   +";
  for (j=0; j<NC; j++) cout << "--+" ;
  cout << endl;

  // Imprime as linhas
  for (i=0; i<NL; i++)
  {
    cout << setfill('0') << setw(2) << i << setfill(' ') << setw(0) << " |" ;
    for (j=0; j<NC; j++)
    {
      cout << estadoCel2string(at(i,j)) << '|' ;
    }
    cout << endl;

    cout << "   +";
    for (j=0; j<NC; j++) cout << "--+" ;
    cout << endl;
  }
}

/// Calcula o caminho entre a origem e o destino do labirinto usando o algoritmo A*
///
/// O parametro NC retorna o numero de nos no caminho encontrado (profundidade da busca)
/// O parametro NC retorna <0 caso nao exista caminho.
///
/// O parametro NA retorna o numero de nos em aberto ao termino do algoritmo A*
/// O parametro NF retorna o numero de nos em fechado ao termino do algoritmo A*
/// Mesmo quando nao existe caminho, esses parametros devem ser retornados
double Labirinto::calculaCaminho(int& NC, int& NA, int& NF)
{
  if (empty() || !origDestDefinidos())
  {
    // Impossivel executar o algoritmo
    NC = NA = NF = -1;
    return -1.0;
  }

  // Apaga um eventual caminho anterior
  limpaCaminho();

  // Testa se origem igual a destino
  if (orig==dest)
  {
    // Caminho tem profundidade nula
    NC = 0;
    // Algoritmo de busca nao gerou nenhum noh
    NA = NF = 0;
    // Caminho tem comprimento nulo
    return 0.0;
  }

  ////////////////////////////
  //////// FALTA FAZER ///////
  ////////////////////////////
  list <Noh> Aberto;
  list <Noh>::iterator oldA;
  list <Noh> Fechado;
  list <Noh>::iterator oldF;


  Noh atual;
  Coord dest2;

  atual.pos = orig;
  atual.ant = Coord(NULL,NULL);
  atual.g = 0.0;
  atual.heuristica(dest);

  Aberto.push_front(atual);

  do{
    atual = *Aberto.begin();
    Aberto.erase(Aberto.begin());
    Fechado.push_front(atual);

    if(!(atual.pos == dest)){
        Coord dir;
        for(int i=atual.pos.lin -1; i!=atual.pos.lin+1; i++){
            for(int j=atual.pos.col-1; j!=atual.pos.col+1; j++){

                dir.lin=i;
                dir.col=j;

                if(dir.lin!=0 && dir.col!=0){

                    dest2= atual.pos + dir;

                    if(movimentoValido(atual.pos,dest)){
                        Noh suc;
                        suc.pos = dest2;
                        suc.ant = atual.pos;
                        suc.g = atual.g + atual.custo(dir);
                        suc.heuristica(dest2);

                        oldF = find( Fechado.begin(), Fechado.end(), suc.pos);
                        if(oldF!=Fechado.end()){

                            if(suc<*oldF){
                                Fechado.erase(oldF);
                                oldF= find(Fechado.begin(),Fechado.end(), suc.pos);
                            }

                        }

                         oldA = find( Aberto.begin(), Aberto.end(), suc.pos);
                         if(oldA!=Aberto.end()){

                             if(suc<*oldA){
                                Aberto.erase(oldA);
                                oldA = Aberto.end();
                            }

                        }


                        if(oldA==Aberto.end() && oldF==Fechado.end()){
                            Aberto.push_front(suc);
                            Aberto.sort();
                        }
                    }
                }
            }
        }
    }
  }while(!(atual.pos == dest) && !(Aberto.empty()));

    NA=Aberto.size();
    NF=Fechado.size();
  // Erro no calculo do caminho
  if(!(atual.pos==dest)){
    NC = NA = NF = -1;
    return -1.0;
  }
  else{
    list<Noh>::iterator k;
    NC=1;
    while(atual.ant!=orig){
        set(atual.ant)=EstadoCel::CAMINHO;
        k=find(Fechado.begin(),Fechado.end(),atual.ant);
        atual= *k;
        NC++;
    }
    return atual.g;
  }


  /*NC = NA = NF = -1;
  return -1.0;*/
}

double Noh::custo(const Coord &dir){
    if(pos.lin==dir.lin && pos.col == dir.col ){
        return 1;
    }

    return sqrt(2);

}
