// Author: Isaac de Lyra Junior

#include <stdlib.h>
#include <stdio.h>

struct no {
    int val;
    struct no* prox;
};

struct linkedlist {
    struct no* cabeca;
    int qtdade;
};

struct linkedlist* inicializar() {
    struct linkedlist* lista = (struct linkedlist*)malloc(sizeof(struct linkedlist)); 
    lista -> cabeca = NULL;
    lista -> qtdade = 0; 
    return lista;
}

struct no* alocarNovoNo(int valor) {
    struct no* newNode = (struct no*)malloc(sizeof(struct no));
    newNode -> prox = NULL;
    newNode -> val = valor;
    return newNode;
}

void inserirElementoNoFim(struct linkedlist* lista, int valor) {
    struct no* newElement = alocarNovoNo(valor);

    if(lista->cabeca == NULL) lista->cabeca = newElement;
    else
    {   
        struct no* aux = lista->cabeca;
        while(aux->prox != NULL) aux = aux->prox;
        aux->prox = newElement;
    }
    lista->qtdade++;
}

void inserirElementoNoInicio(struct linkedlist* lista, int valor) {
    struct no* newElement = alocarNovoNo(valor);

    if(lista->cabeca == NULL) lista->cabeca = newElement;
    else
    {
        struct no* aux = lista->cabeca;
        lista->cabeca = newElement;
        newElement->prox = aux;
    }
    
    lista->qtdade++;
}

void inserirElementoEmPosicao(struct linkedlist* lista, int valor, int posicao) {
    if(posicao >= 0 && posicao <= lista->qtdade)
    {
        struct no* newElement = alocarNovoNo(valor);
        struct no* aux = lista->cabeca;

        if(posicao == 0)
        {
            //inserirElementoNoInicio(lista,valor);
            lista->cabeca = newElement;
            newElement->prox = aux;
        }
        else
        {
            for(unsigned i = 0; i < posicao - 1; i++) aux = aux->prox;

            struct no* aux2 = aux->prox;
            aux->prox = newElement;
            newElement->prox = aux2;
        }  
        
        lista->qtdade++;
    }
}

int obterElementoEmPosicao(struct linkedlist* lista, int posicao) {
    if(posicao >= 0 && posicao < lista->qtdade)
    {
        struct no* aux = lista->cabeca;

        for(unsigned i = 0; aux->prox != NULL; i++)
        {
            if(i == posicao) break;
            aux = aux -> prox;
        }
        return aux->val;
    }
}

void removerElementoEmPosicao(struct linkedlist* lista, int posicao) {
    if (posicao >= 0 && posicao <= lista->qtdade) {
        struct no* aux = lista->cabeca;
        if (posicao == 0) {
            lista->cabeca = aux->prox;
            free(aux);
        }
        else {
            for (int i = 0; i < posicao - 1; i++) aux = aux->prox;
            struct no* aux2 = aux->prox;
            aux->prox = aux2->prox;
            free(aux2);
        }
        lista->qtdade--;
    }
}

void imprimirLista(struct linkedlist* lista) {
    //usamos o aux para percorrer a lista
    if (lista->cabeca != NULL) {
        struct no* aux = lista->cabeca;
        //navega partindo da cabe�a at� chegar NULL
        printf("[");
        do {
            printf("%d", aux->val);
            aux = aux->prox;
            if (aux != NULL) {
                printf(", ");
            }
        } while (aux != NULL);
        printf("]");
    }
    else {
        printf("A lista est� vazia!");
    }
}