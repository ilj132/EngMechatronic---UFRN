#include <iostream>
#include <cmath>

using namespace std;

///
/// CLASSE PONTO
///

/// Ponto cartesiano
/// Duas coordenadas: x e y
class Ponto
{
private:
  double x,y;
public:
  /// Construtores
  inline Ponto(): x(0.0), y(0.0) {}
  inline Ponto(double X, double Y): x(X), y(Y) {}
  /// Entrada e saida
  ostream &imprimir(ostream &O) const;
  istream &ler(istream &I);
  /// Distancia euclidiana
  double distancia(const Ponto &B) const;
};

/// Impressao de um Ponto em uma stream
ostream &Ponto::imprimir(ostream &O) const
{
  O << '[' << x << ';' << y << ']';
  return O;
}

/// Leitura de um Ponto de uma stream
istream &Ponto::ler(istream &I)
{
  I >> x >> y;
  return I;
}

/// Os operadores de entrada e saida foram definidos utilizando metodos da class
/// Com isso, o usuario tem duas formas de imprimir um Ponto P:
/// P.imprimir(cout) ou cout << P
/// Para ler um Ponto:
/// P.ler(cin) ou cin >> P
/// Como as funcoes operator<< e operator>> foram definidas utilizando metodos publicos
/// da classe Ponto, elas nao precisam acessar membros privados e, por essa razao,
/// nao precisaram ser declaradas como funcoes "friend" da classe
inline ostream &operator<<(ostream &O, const Ponto &P) {return P.imprimir(O);}
inline istream &operator>>(istream &I, Ponto &P) {return P.ler(I);}

/// Funcao auxiliar para elevar ao quadrado
inline double pow2(double x) {return x*x;}

/// Distancia euclidiana entre dois pontos
double Ponto::distancia(const Ponto &B) const
{
  return sqrt(pow2(x-B.x)+pow2(y-B.y));
}



///
/// CLASSE CIRCULO
///

/// Circulo: Pònto acrescido de um raio
/// Circulo -> Ponto: heranca (publica)
/// Circulo -> double (r): composicao
class Circulo: public Ponto
{
private:
  double r;
public:
  /// Construtores
  inline Circulo(): Ponto(), r(0.0) {}
  inline Circulo(double X, double Y, double R): Ponto(X,Y), r(R) {}
  /// Entrada e saida
  /// Notar que essas funcoes membros tem o mesmo nome na classe Ponto
  /// Entao todo objeto C da classe Circulo tem dois metodos "imprimir":
  /// C.imprimir(cout) ou C.Circulo::imprimir(cout) -> da classe Circulo
  /// C.Ponto::imprimir(cout) -> da classe Ponto
  ostream &imprimir(ostream &O) const;
  istream &ler(istream &I);
};

ostream &Circulo::imprimir(ostream &O) const
{
  Ponto::imprimir(O); // Chama o imprimir do Ponto

  O << r;
  return O;
}

istream &Circulo::ler(istream &I)
{
  Ponto::ler(I); // Chama o ler do Ponto

  I >> r;
  return I;
}

/// Os operadores de entrada e saida foram definidos utilizando metodos da class
inline ostream &operator<<(ostream &O, const Circulo &C) {return C.imprimir(O);}
inline istream &operator>>(istream &I, Circulo &C) {return C.ler(I);}

int main(void)
{
  Circulo C1(1.0, 0.7, 12.0), C2;

  cout << "1o circulo: " << C1 << endl;
  cout << "Digite o 2o circulo: ";
  cin >> C2;

  // Utilizacao de um metodo de Ponto passando como parametro um Circulo, e nao um Ponto
  cout << "Distancia entre os centros dos circulos: " << C1.distancia(C2) << endl;

  return 0;
}
