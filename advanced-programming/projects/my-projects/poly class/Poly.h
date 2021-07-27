#ifndef POLY
#define POLY
#include <iostream>

using namespace std;

class Poly
{
private:
    unsigned grau;
    double *x;
    void create(unsigned Num);
    void copy(const Poly &V);

public:
    /// Construtor default
    inline Poly() : grau(0), x(NULL) {}
    /// Construtor por copia
    inline Poly(const Poly &P) { copy(P); }
    /// Construtor especifico
    explicit Poly(unsigned Num);

    ///Libera a memoria
    void clean();
    /// Destrutor
    inline ~Poly() { clean(); }
    /// Operador de atribuicao
    void operator=(const Poly &P);


    ///Entrada e saída de dados
    friend ostream &operator<<(ostream &X, const Poly &P);
    friend istream &operator>>(istream &X, Poly &P);

    /// Metodos de Consulta
    inline unsigned getGrau() const {return grau;}
    double getCoef(unsigned Num) const;
    double getValor(double Num) const;

    inline double operator[](unsigned Num) const { return getCoef(Num); }
    inline double operator()(double Num) const { return getValor(Num); }

    ///Outros metodos
    void setCoef(unsigned i, double Num);
    Poly setGrau(unsigned Num);
    bool testeNulo() const;

    // Soma de Polinomio
    Poly operator+(const Poly &P) const;
    // Subtracao de Polinomio (- binario)
    Poly operator-(const Poly &P) const;
    // Negativo de um Polinomio (- unario)
    Poly operator-() const;
    //Multiplicacao de polinomios
    Poly operator*(const Poly &P) const;
};

#endif
