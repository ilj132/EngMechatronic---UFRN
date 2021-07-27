#include <iostream>
#include <vector>

using namespace std;

class Pessoa
{
private:
  string nome;
  int idade;
public:
  inline Pessoa(string no, int id): nome(no), idade(id) {}
  inline string getNome() const {return nome;}
  inline int getIdade() const {return idade;}
};

int main()
{
  vector<Pessoa> VP;
  vector<Pessoa>::iterator ptr;

  VP.push_back(Pessoa("Joao", 25));
  VP.push_back(Pessoa("Maria", 32));
  VP.push_back(Pessoa("Carla", 4));
  VP.push_back(Pessoa("Abel", 30));

  // percorrendo a lista com iteradores
  for(ptr=VP.begin(); ptr!=VP.end(); ptr++)
  {
    cout << "Nome: " << ptr->getNome();
    cout << " - Idade: " << ptr->getIdade() << endl;
  }
}
