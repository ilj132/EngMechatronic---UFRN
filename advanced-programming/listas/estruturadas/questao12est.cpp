/*Faça um programa que, dados dois vetores bidimensionais (matrizes A e B) com
dimensões de 5x5 elementos, imprima a soma destas duas matrizes, a soma das
diagonais de cada matriz e a multiplicação das duas matrizes.*/

#include <iostream>

using namespace std;

struct Matriz
{
    unsigned NL, NC;
    double **x;
};

//Alocacao e liberacao de memoria
Matriz novaMatriz(unsigned NumLin, unsigned NumCol);
void liberaMatriz(Matriz &A);

//Entrada e saida de dados (via teclado e tela)
void leMatriz(Matriz &M);
void imprimeMatriz(const Matriz &M);

//Operacoes com matrizes
Matriz somaMatrizes(const Matriz &M1, const Matriz &M2);
Matriz somadigMatrizes(const Matriz &M1, const Matriz &M2);
Matriz produtoMatrizes(const Matriz &M1, const Matriz &M2);

int main()
{
    Matriz A, B, C;

    unsigned NLa, NCa, NLb, NCb;
    do
    {
        cout << "Linhas de A: ";
        cin >> NLa;
    } while (NLa <= 0);
    do
    {
        cout << "Colunas de A: ";
        cin >> NCa;
    } while (NCa <= 0);
    NLb = NCa;
    do
    {
        cout << "Colunas de B: ";
        cin >> NCb;
    } while (NCb <= 0);

    A = novaMatriz(NLa, NCa);
    B = novaMatriz(NLb, NCb);

    cout << "Matriz A: \n";
    leMatriz(A);
    cout << "Matriz B:\n";
    leMatriz(B);

    cout << endl;

    C = somaMatrizes(A, B);
    cout << "Soma de A+B:\n";
    imprimeMatriz(C);

    cout << endl
         << endl;

    C = somadigMatrizes(A, B);
    cout << "Soma da diagonal de A+B:\n";
    imprimeMatriz(C);

    cout << endl
         << endl;

    C = produtoMatrizes(A, B);
    cout << "Produto AxB:\n";
    imprimeMatriz(C);

    liberaMatriz(A);
    liberaMatriz(B);
    liberaMatriz(C);

    return 0;
}

Matriz novaMatriz(unsigned NumLin, unsigned NumCol)
{
    Matriz prov;

    if (NumLin == 0 || NumCol == 0)
    {
        cerr << "Matriz de dimensao nula!\n";
        prov.NL = prov.NC = 0;
        prov.x = NULL;
        return prov;
    }
    prov.NL = NumLin;
    prov.NC = NumCol;
    prov.x = new double *[NumLin];
    for (unsigned i = 0; i < NumLin; i++)
    {
        prov.x[i] = new double[NumCol];
        for (unsigned j = 0; j < NumCol; j++)
            prov.x[i][j] = 0.0;
    }
    return prov;
}

void liberaMatriz(Matriz &M)
{
    if (M.x != NULL)
    {
        for (unsigned i = 0; i < M.NL; i++)
            delete[] M.x[i];
        delete[] M.x;
    }

    M.NL = M.NC = 0;
    M.x = NULL;
}

void leMatriz(Matriz &M)
{
    if (M.NL == 0 || M.NC == 0 || M.x == NULL)
    {
        cerr << "Matriz nao tem espaco para dados. Nao pode ser lida.\n";
        return;
    }
    for (unsigned i = 0; i < M.NL; i++)
    {
        for (unsigned j = 0; j < M.NC; j++)
        {
            cout << '[' << i << ',' << j << "]: ";
            cin >> M.x[i][j];
        }
    }
}

void imprimeMatriz(const Matriz &M)
{
    if (M.NL == 0 || M.NC == 0 || M.x == NULL)
    {
        cerr << "Matriz nao tem espaco para dados. Nao pode ser impressa. \n";
        return;
    }
    for (unsigned i = 0; i < M.NL; i++)
    {
        for (unsigned j = 0; j < M.NC; j++)
            cout << M.x[i][j] << ' ';
        cout << endl;
    }
}

Matriz somaMatrizes(const Matriz &M1, const Matriz &M2)
{
    Matriz prov;
    if (M1.NL == 0 || M1.NC == 0 || M2.NL != M1.NC || M2.NC == 0)
    {
        cerr << "Matrizes de dimensoes invalidas. Nao podem ser somadas. \n";
        prov.NL = prov.NC = 0;
        prov.x = NULL;
        return prov;
    }
    prov = novaMatriz(M1.NL, M2.NC);
    for (unsigned i = 0; i < prov.NL; i++)
    {
        for (unsigned j = 0; j < prov.NC; j++)
        {
            prov.x[i][j] = M1.x[i][j] + M2.x[i][j];
        }
    }
    return prov;
}

Matriz somadigMatrizes(const Matriz &M1, const Matriz &M2)
{
    Matriz prov;
    if (M1.NL == 0 || M1.NC == 0 || M2.NL != M1.NC || M2.NC == 0)
    {
        cerr << "Matrizes de dimensoes invalidas. Nao podem ter as diagonais somadas. \n";
        prov.NL = prov.NC = 0;
        prov.x = NULL;
        return prov;
    }

    prov = novaMatriz(M1.NL, M2.NC);
    for (unsigned i = 0; i < prov.NL; i++)
    {
        for (unsigned j = 0; j < prov.NC; j++)
        {
            if (i == j)
                prov.x[i][j] = M1.x[i][j] + M2.x[i][j];
        }
    }
    return prov;
}

Matriz produtoMatrizes(const Matriz &M1, const Matriz &M2)
{
    Matriz prov;
    if (M1.NL == 0 || M1.NC == 0 || M2.NL != M1.NC || M2.NC == 0)
    {
        cerr << "Matrizes de dimensoes invalidas. Nao podem ser multiplicadas. \n";
        prov.NL = prov.NC = 0;
        prov.x = NULL;
        return prov;
    }
    prov = novaMatriz(M1.NL, M2.NC);
    for (unsigned i = 0; i < prov.NL; i++)
    {
        for (unsigned j = 0; j < prov.NC; j++)
        {
            prov.x[i][j] = 0.0;
            for (unsigned k = 0; k < M1.NC; k++)
            {
                prov.x[i][j] += M1.x[i][k] * M2.x[k][j];
            }
        }
    }
    return prov;
}