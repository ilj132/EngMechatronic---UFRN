#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <limits.h>

struct arrayqueue {
    int frente;
    int tras;
    int* elementos;
    int tamanho;    //tam do array
    int qtdade;     //qtdade de elementos no array    
};

struct arrayqueue* inicializar(int tamArray) {
    struct arrayqueue* queue = (struct arrayqueue*)malloc(sizeof(struct arrayqueue));
    queue->frente = -1;
    queue->tras = queue->frente;
    queue->elementos = (int*)calloc(queue->tamanho, sizeof(int));
    queue->tamanho = tamArray;
    queue->qtdade = 0;
    return queue;
}

//se a fila estiver nula, instancie a fila com tamanho 10
//por causa da possibilidade de instanciacao usamos struct arrayqueue**
//se a fila encher, simplesmente n�o enfileire
void enfileirar(struct arrayqueue** fila, int val) {
    if((*fila)==NULL){
        (*fila) = inicializar(10);
        enfileirar(fila, val);
    }
    else{

    }
}

//retorne a constante INT_MIN se a fila for nula ou vazia
int desenfileirar(struct arrayqueue* fila) {
    //TODO
}

//retorne a constante INT_MIN se a fila for nula ou vazia
int frente(struct arrayqueue* fila) {
    //TODO
}