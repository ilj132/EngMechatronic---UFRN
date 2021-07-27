/*Desenvolva classes que possam representar pontos e retângulos no espaço 2D, de
acordo com as seguintes especificações:
 Defina o tipo Ponto para representar um ponto em coordenadas cartesianas.
 Crie uma função imprimir, capaz de imprimir um Ponto na tela.
 Sobrecarregue o operador << usando a função imprimir.
 Forneça uma implementação para uma função distancia que calcula a distância
Euclidiana entre dois dados do tipo Ponto.
 Defina um tipo Retangulo para representar retângulos que são paralelos aos ei-
xos no sistema de coordenadas cartesianas. Represente um retângulo pelos seus
pontos superior direito (ponto de coordenadas máximas) e inferior esquerdo (co-
ordenadas mínimas), usando o tipo Ponto.
 Escreva a função area que calcula a área de um Retangulo.
 Escreva uma função pontoInterno que retorna o resultado do teste (true ou fal-
se) sobre se um Ponto está ou não dentro de um Retangulo.
 Sobrecarregue o operador < usando a função pontoInterno.*/

#include <iostream>
#include <cmath>

using namespace std;

//Tipos de Classe

class Ponto
{
private:
    double x, y;

public:
    void ler();
    void imprimir();
    double distancia(Ponto a, Ponto b);
    friend class Retangulo;
};

class Retangulo
{
private:
    Ponto sup;
    Ponto inf;

public:
    double area(Retangulo A);
    bool pontoInterno(Retangulo A, Ponto a);
};

//Os metodos

void Ponto::ler()
{
    cout << "Qual coordenada x do Ponto? " << endl;
    cin >> x;
    cout << "Qual coordenada y do ponto? " << endl;
    cin >> y;
}

void Ponto::imprimir()
{
    cout << "[" << x << "," << y << "]" << endl;
}

double Ponto::distancia(Ponto a, Ponto b)
{
    //double dist=0.0;
    //dist=sqrt(pow((a.x-b.x),2)+pow((a.y-b.y),2));
    return sqrt(pow((a.x - b.x), 2) + pow((a.y - b.y), 2));
}

double Retangulo::area(Retangulo A)
{
}

bool pontoInterno(Retangulo A, Ponto a)
{
}

//main do codigo

int main()
{
    Ponto a, b;
    a.ler();
    b.ler();

    a.imprimir();
    b.imprimir();
}