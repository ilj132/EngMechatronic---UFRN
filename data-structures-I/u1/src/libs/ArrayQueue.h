// Author: Isaac de Lyra Junior

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

bool vazia(struct arrayqueue* queue) {
    if (queue!=NULL && queue->qtdade!=0/*(queue->tras && queue->frente)!=-1 pq isso n funciona?*/) return false; // se fila não vazia e não nula retorna falso
    return true; // se nao retorna true
}

//se a fila estiver nula, instancie a fila com tamanho 10
//por causa da possibilidade de instanciacao usamos struct arrayqueue**
//se a fila encher, simplesmente n�o enfileire
void enfileirar(struct arrayqueue** fila, int val) {
    if((*fila)==NULL){ // fila nula
        (*fila) = inicializar(10); // instancia a fila com tamanho 10
        enfileirar(fila, val); // coloca o valor passado na primeira posição
    }
    else{ // fila nao nula
        if(((*fila)->tras+1) % (*fila)->tamanho != (*fila)->frente){ // se a fila não estiver cheia, ou seja quando a posição da traseira dividido pelo tamanho nao coincidir com a posição da frente
            (*fila)->tras = ((*fila)->tras+1) % (*fila)->tamanho; // a traseira vai receber a última posição da fila
            if(!(*fila)->qtdade) (*fila)->frente = (*fila)->tras; // se quantidade igual a 0, a frente vai ser igual a tras         
            (*fila)->elementos[(*fila)->tras] = val; // o novo elemento vai ser adicionado na traseira da fila
            (*fila)->qtdade++; // acrescenta a quantidade da fila
        }
    }
}

//retorne a constante INT_MIN se a fila for nula ou vazia
int frente(struct arrayqueue* fila) {
    if(!vazia(fila)) return fila->elementos[fila->frente]; // se pilha nao vazia ou nula, retorna o elemento da frente 
    return INT_MIN; // se pilha 
}

//retorne a constante INT_MIN se a fila for nula ou vazia
int desenfileirar(struct arrayqueue* fila) {
    if(!vazia(fila)){ // se fila não for vazia ou nula
        int aux = frente(fila); // auxiliar para guardar o elemento da frente atual
        fila->frente = (fila->frente + 1) % fila->tamanho; // a nova frente será o próximo elemento
        fila->qtdade--; // diminui a quantidade da fila
        return aux; // retorna o valor do elemento da frente anterior
    }
    return INT_MIN; // se pilha for vazia ou nula, retorna INT_MIN
}

