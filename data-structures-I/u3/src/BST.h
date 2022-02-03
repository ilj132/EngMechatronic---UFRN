// Author: Isaac de Lyra Junior

#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>

struct noBst {
    int val;
    struct noBst* esq;
    struct noBst* dir;
};

/**
 * Funcao que aloca um novo noBst, e
 * ajusta os ponteiros esq e dir para NULL. 
 **/
struct noBst* alocarNovoNo(int val) {
    //IMPLEMENTAR
    struct noBst* newNode = (struct noBst*)malloc(sizeof(struct noBst));
    newNode->val = val;
    newNode->esq = NULL;
    newNode->dir = NULL;
    return newNode;
}

/**
 * Funcao que recebe a raiz de uma BST, e 
 * insere um novo valor na BST. Tamanho deve
 * ser incrementado.
 * Ambos tamanho e raiz são passados por referência.
 **/
void inserir(struct noBst** raiz, int val, int* tamanho) {
    //IMPLEMENTAR
    if((*raiz)==NULL){
        (*raiz) = alocarNovoNo(val);
        (*tamanho)++;
    }
    else if (val > (*raiz)->val) {
        inserir(&((*raiz)->dir), val, tamanho);
    }
    else{ 
        inserir(&((*raiz)->esq), val, tamanho);
    }
}

/**
 * Funcao que recebe a raiz de uma BST, e
 * verifica se a mesma contém um dado valor.
 **/
bool buscar(struct noBst* raiz, int val) {
    //IMPLEMENTAR
    if (raiz == NULL) {
        return false;
    }
    else {
        if(val == raiz->val){
            return true;
        }
        else if (val > raiz->val) {
            buscar(raiz->dir, val);
        }
        else{
            buscar(raiz->esq, val);
        }
    }
}

/**
 * Funcao que retorna o maior valor de uma BST.
 **/
int max(struct noBst* raiz) {
    //IMPLEMENTAR
    if (raiz == NULL) {
        return 0;
    }
    struct noBst* aux = raiz;
    while(aux->dir != NULL) {
        aux = aux ->dir;
    }
    return aux->val;
}

/**
 * Funcao que retorna o menor valor de uma BST.
 **/
int min(struct noBst* raiz) {
    //IMPLEMENTAR
    if (raiz == NULL) {
        return 0;
    }
    struct noBst* aux = raiz;
    while (aux->esq != NULL){
        aux = aux->esq;
    }
    return aux->val;
}

/**
 * Funcao que retorna a altura de uma BST.
 * A altura de uma BST é dada pela quantidade
 * de arestas entre a raiz e a folha mais distante.
 **/
int altura(struct noBst* raiz) {
    //IMPLEMENTAR
    if (raiz == NULL || (raiz->esq == NULL && raiz->dir == NULL)) {
        return 0;
    }
    else{
        int left_height = altura(raiz->esq);
        int right_height = altura(raiz->dir);

        if(left_height >= right_height) {
            return left_height + 1;
        } else {
            return right_height + 1;
        }
    }
}

/**
 * Funcao que navega em-ordem na BST e 
 * imprime seus elementos.
 **/
void emOrdem(struct noBst* raiz) {
    //IMPLEMENTAR
    if (raiz == NULL){
        // printf("\n A árvore não possui elementos");
        return;
    }
    emOrdem(raiz->esq);
    printf("%d ", raiz->val);
    emOrdem(raiz->dir);
}

/**
 * Funcao que navega pre-ordem na BST e
 * imprime seus elementos.
 **/
void preOrdem(struct noBst* raiz) {
    //IMPLEMENTAR
    if(raiz == NULL){
        // printf("\n A árvore não possui elementos");
        return;
    }
    printf("%d ", raiz->val);
    emOrdem(raiz->esq);
    emOrdem(raiz->dir);
}

/**
 * Funcao que navega pos-ordem na BST e
 * imprime seus elementos.
 **/
void posOrdem(struct noBst* raiz) {
    //IMPLEMENTAR
    if(raiz == NULL){
        // printf("\n A árvore não possui elementos");
        return;
    }
    emOrdem(raiz->esq);
    emOrdem(raiz->dir);
    printf("%d ", raiz->val);
}

/**
 * Funcao que recebe a raiz de uma BST, e
 * remove o no que contem o valor passado como
 * argumento. Tamanho deve ser decrementado.
 * Tamanho é passado por referência.
 **/
struct noBst* remover(struct noBst* raiz, int val, int* tamanho) {
    //IMPLEMENTAR
    if (raiz == NULL) {
        return raiz;
    }
    if (val > raiz->val) {
        raiz->dir = remover(raiz->dir, val, tamanho);
    }
    else if (val < raiz->val) {
        raiz->esq = remover(raiz->esq, val, tamanho);
    }
    else {
        if (raiz->dir == NULL) {
            struct noBst* aux = raiz->esq;
            free(raiz);
            return aux;
        }
        else if (raiz->esq == NULL) {
            struct noBst* aux = raiz->dir;
            free(raiz);
            return aux;
        }
        int aux = min(raiz->dir);
        raiz->val = aux;
        raiz->dir = remover(raiz->dir, aux, tamanho);
    }
    return raiz;
}