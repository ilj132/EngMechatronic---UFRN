// Author: Isaac de Lyra Junior

#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <limits.h>

struct no{
    int val;
    struct no *prox;
};

struct linkedstack {
    struct no* topo;
    int qtdade;
};

struct linkedstack* inicializar() {
    struct linkedstack* stack = (struct linkedstack*)malloc(sizeof(struct linkedstack)); // aloca memoria do tamanho em bytes da estrutura linkedstack
    stack->qtdade = 0; // inicializa quantidade com 0
    stack->topo = NULL; // inicializa topo nulo
    return stack;
}

struct no* alocarNovoNo(int valor){
    struct no* newNode = (struct no*)malloc(sizeof(struct no)); // aloca memoria do tamanho em bytes da estrutura no
    newNode->val = valor; // inicializa valor com o valor passado por parâmetro
    newNode->prox = NULL; // próximo inicia como nulo
    return newNode;
}

//retornar true se a pilha for nula ou vazia
bool vazia(struct linkedstack* pilha) {
    if (pilha!=NULL && pilha->topo != NULL) return false; // se pilha não vazia e não nula retorna falso
    return true; // se nao retorna true
}

//se a pilha estiver nula, instancie a pilha
//por causa da possibilidade de instanciacao usamos struct linkedstack**
void empilhar(struct linkedstack** pilha, int valor){
    if((*pilha)==NULL){ //se pilha nula
        (*pilha) = inicializar(); //instancia a pilha
        empilhar(pilha, valor); //atribui um novo valor
    }
    else{ //pilha nao nula
        struct no* newElement = alocarNovoNo(valor); // aloca novo elemento do tipo no na memória
        if((*pilha)->topo==NULL) // se pilha vazia
            (*pilha)->topo = newElement; // o topo da pilha será o novo elemento alocado
        else{ // pilha nao vazia
            struct no* aux = (*pilha)->topo; // aloca novo NO auxiliar apontando para o atual topo da pilha
            (*pilha)->topo = newElement; // o topo da pilha vai apontar agora pro novo elemento alocado;
            newElement->prox = aux; // o proximo endereço apontado será do topo anterior
        }
        (*pilha)->qtdade++; // acrescenta um na quantidade da pilha
    }
}

//decrementar qtdade se a pilha não estiver nula ou vazia
void desempilhar(struct linkedstack* pilha) {
    if(!vazia(pilha)){ // se pilha não nula e não vazia
        struct no* aux = pilha->topo; // guarda endereço do topo da pilha atual
        pilha->topo = pilha->topo->prox; // o topo da pilha agora será o próximo
        free(aux); // desaloca memoria do topo da pilha antigo
        pilha->qtdade--; // diminui quantidade da pilha
    }
}

//retorne a constante INT_MIN se a pilha for nula ou vazia
int desempilharRetornando(struct linkedstack* pilha) {
    if(!vazia(pilha)){
        struct no* aux2 = pilha->topo; // guarda endereço do topo da pilha atual
        int aux = aux2->val; // guarda o valor do topo atual
        pilha->topo = pilha->topo->prox; // o novo topo será o próximo da pilha
        free(aux2); // libera o espaço alocado pelo topo antigo
        pilha->qtdade--; // diminui a quantidade da pilha
        return aux; // retorna o valor do topo anterior da pilha
    }
    else return INT_MIN; // se nao retorna INT_MIN
}

//retorne a constante INT_MIN se a pilha for nula ou vazia
int topo(struct linkedstack* pilha){
    if(!vazia(pilha)) // se pilha não nula e também não vazia
       return pilha->topo->val; // retorna o valor
    return INT_MIN; // se nao, retorna INT_MIN;
}

void exibirPilha(struct linkedstack* pilha) {
    //usamos o aux para percorrer a lista
    if (!vazia(pilha)) {
        struct no* aux = pilha->topo;
        //navega partindo do topo até chegar NULL
        printf("_\n");
        do {
            printf("%d\n", aux->val);
            aux = aux->prox;
        } while (aux != NULL);
        printf("_");
    }
    else {
        printf("A pilha está vazia!");
    }
}