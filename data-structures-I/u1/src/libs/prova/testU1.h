// Author: ISAAC DE LYRA JUNIOR

#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <stack>
using namespace std;

/* Q1: Inverta uma lista duplamente ligada
 * com um algoritmo in-place (ou seja, sem
 * criar uma nova lista duplamente ligada)
 */

struct noDuplo {
    struct noDuplo* ant;
    int val;
    struct noDuplo* prox;
};

struct doublylinkedlist {
    struct noDuplo* cabeca;
    struct noDuplo* cauda;
    int qtdade;
};

struct doublylinkedlist* inicializarDLL() {
    struct doublylinkedlist* lista = (struct doublylinkedlist*)malloc(sizeof(struct doublylinkedlist));
    lista->cabeca = NULL;
    lista->cauda = NULL;
    lista->qtdade = 0;
    return lista;
}

struct noDuplo* alocarNovoNoDuplo(int valor) {
    struct noDuplo* novoNo = (struct noDuplo*)malloc(sizeof(struct noDuplo));
    novoNo->val = valor;
    novoNo->ant = NULL;
    novoNo->prox = NULL;
    return novoNo;
}

void inserirElementoNoFim(struct doublylinkedlist* lista, int valor) {
    //aloca espa�o na mem�ria e popula novoNo
    struct noDuplo* novoNo = alocarNovoNoDuplo(valor);

    if (lista->cabeca == NULL) {
        //quando a lista � vazia, basta apontar o cabeca e cauda para o novoNo
        lista->cabeca = novoNo;
    }
    else {
        //atualizamos o ponteiro novoNo->ant para o antigo �ltimo n�
        novoNo->ant = lista->cauda;
        //ponteiro prox do antigo �ltimo n� para o novoNo
        lista->cauda->prox = novoNo;
    }
    //uma certeza: inserindo no fim, a cauda apontar� para o novoNo
    lista->cauda = novoNo;
    lista->qtdade++;
}

int obterElementoEmPosicao(struct doublylinkedlist* lista, int posicao) {
    struct noDuplo* aux = lista->cabeca;
    for (int i = 0; i < posicao && aux->prox != NULL; i++) {
        aux = aux->prox;
    }
    return aux->val;
}

void inverterDoublyLinkedList(struct doublylinkedlist* lista) {
    struct noDuplo* atual = lista->cabeca; // o atual vai iniciar apontando pra cabeça
    struct noDuplo* aux = NULL; // variavel auxiliar

    while (atual != NULL) // enquanto atual não for nulo
    {
        aux = atual->prox; // auxiliar vai apontar pro proximo do atual
        atual->prox = atual->ant; // o proximo do atual vai ser trocado pelo anterior do atual
        atual->ant = aux; // o anterior do atual vai apontar pro proximo anterior
        atual = aux; // o novo atual vai ser o proximo do atual anterior
    }

    aux = lista->cabeca; // ao terminar de percorrer a lista o auxiliar vai armazenar a cabeça da lista
    lista->cabeca = lista->cauda; // a nova cabeça da lista vai apontar pra cauda
    lista->cauda = aux; // a cauda da lista vai apontar pra cabeça anterior
}

/******************************************/

/* Q2: escreva um algoritmo que detecte se uma
 * certa combinacao de parenteses estah balanceada.
 * Dica: usar pilha, pode ser a impl "stack" CPP STL.
 * Olhe os casos de teste para entender o que eh uma
 * combinacao balanceada.
 */

bool balanceamentoParenteses(const char* parenteses, int tam) {
    stack<char> contagem; // instancia stack do tipo char

    for(unsigned i = 0; i<tam ; i++){
        if (parenteses[i] == '(') contagem.push('a'); // toda vez que achar um parenteses abrindo, adiciona um elemento na stack
        else if (parenteses[i] == ')' && !contagem.empty()) contagem.pop(); // se nao for parenteses abrindo e a lista não estiver vazia, retira um elemento da stack;
        else return false; // se a lista estiver vazia e o sinal, é sinal que nenhum parenteses foi aberto antes, e precisa retornar falso
    }
    return contagem.empty(); // se depois do laço de repetição, a stack estiver vazia, retorna true, se não retorna false.
}

/******************************************/

/* Q3: Inverta uma lista ligada (LinkedList)
 * com um algoritmo in-place (ou seja, sem
 * criar uma nova LinkedList)
 */

struct no {
    int val;
    struct no* prox;
};

struct linkedlist {
    struct no* cabeca;
    int qtdade;
};

struct linkedlist* inicializarLL() {
    struct linkedlist* lista = (struct linkedlist*)malloc(sizeof(struct linkedlist));
    lista->cabeca = NULL;
    lista->qtdade = 0;
    return lista;
}

struct no* alocarNovoNo(int valor) {
    struct no* novoNo = (struct no*)malloc(sizeof(struct no));
    novoNo->val = valor;
    novoNo->prox = NULL;
    return novoNo;
}

void inserirElementoNoFim(struct linkedlist* lista, int valor) {
    struct no* novoNo = alocarNovoNo(valor);
    if (lista->cabeca == NULL) {
        lista->cabeca = novoNo;
    }
    else {
        struct no* aux = lista->cabeca;
        while (aux->prox != NULL) {
            aux = aux->prox;
        }
        aux->prox = novoNo;
    }
    lista->qtdade++;
}

void inverterLinkedListInPlace(struct linkedlist* lista) {
    // como no caso da linkedlist não possuimos um anterior no proprio nó como no caso da doublylinkedlist, é necessario criar um auxiliar a mais
    struct no* proximo = NULL; // auxiliar pra guardar o proximo
    struct no* atual=lista->cabeca; // auxiliar pra guardar o atual, que inicia apontando pra cabeça
    struct no* anterior = NULL; // auxiliar adicional pra guardar o anterior

    while(atual != NULL){ // enquanto atual não for nulo
        proximo = atual->prox; // o proximo guardará o próximo atual
        atual->prox = anterior; // o atual proximo vai ser substituido pelo anterior
        anterior = atual; // o anterior será o atual
        atual = proximo; // o atual será o proximo
    }

    lista->cabeca = anterior; // ao final do laço de repetição, a cabeça apontará pro último anterior
}

int obterElementoEmPosicao(struct linkedlist* lista, int posicao) {
    struct no* aux = lista->cabeca;
    for (int i = 0; i < posicao && aux->prox != NULL; i++) {
        aux = aux->prox;
    }
    return aux->val;
}