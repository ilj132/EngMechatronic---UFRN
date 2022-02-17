#include <stdlib.h>
#include <stdio.h>
#include <stdbool.h>
#include <queue>
using namespace std;

void atualizar(struct noBst* no);
struct noBst* balancear(struct noBst* no);
struct noBst* rebalancearEsqEsq(struct noBst* no);
struct noBst* rebalancearEsqDir(struct noBst* no);
struct noBst* rebalancearDirDir(struct noBst* no);
struct noBst* rebalancearDirEsq(struct noBst* no);
int altura(struct noBst* raiz);

/**
 * Embora durante a aula eu disse que precisaríamos
 * das variáveis alturaEsq e alturaDir, na verdade não
 * é necessário. Depois de implementar que percebi algo
 * óbvio: para pegar a altura de uma sub-árvore basta
 * obter o valor da variável altura na sub-árvore. (:
 **/
struct noBst {
    int val;
    int altura;    
    int balanco;
    struct noBst* esq;
    struct noBst* dir;
};

/**
 * Funcao que aloca um novo noBst, e
 * ajusta os ponteiros esq e dir para NULL,
 * e variáveis altura e balanco para 0.
 **/
struct noBst* alocarNovoNo(int val) {
    //IMPLEMENTAR
    struct noBst* newNode = (struct noBst *)malloc(sizeof(struct noBst));
    if (newNode != NULL) {
        newNode->val = val;
        newNode->altura = 0;
        newNode->balanco = 0;
        newNode->esq = NULL;
        newNode->dir = NULL;
    }
    return newNode;
};

/**
 * Funcao que rotaciona uma arvore para a
 * direita e retorna a nova raiz.
 **/
struct noBst* rotacaoDireita(struct noBst* arvore) {
    //IMPLEMENTAR
    if (arvore == NULL || arvore->esq == NULL || arvore->dir == NULL) {
         return arvore;
     }
    
    struct noBst* aux = arvore->esq;
    arvore->esq = aux->dir;
    aux->dir = arvore;
    atualizar(arvore);
    atualizar(aux);
    return arvore;
};

/**
 * Funcao que rotaciona uma arvore para a
 * esquerda e retorna a nova raiz.
 **/
struct noBst* rotacaoEsquerda(struct noBst* arvore) {
    //IMPLEMENTAR
    if(arvore == NULL || arvore->dir == NULL || arvore->esq == NULL) {
        return arvore;
    }

    struct noBst* aux = arvore->dir;
    arvore->dir = aux->esq;
    aux->esq = arvore;
    atualizar(arvore);
    atualizar(aux);
    return arvore;
};

/**
 * Funcao que recebe a raiz de uma BST, e
 * insere um novo valor na BST. Tamanho deve
 * ser incrementado.
 * Ambos tamanho e raiz são passados por referência.
 * Lembrar de atualizar altura e fator de balanco dos nós 
 * antecessores do nó inserido, bem como balanceá-los caso
 * seja necessário.
 * Dica: reutilizar a função de inserir de BST, e lembrar
 * de como usar inteligentemente a recursão para conseguir
 * atualizar e balancear os nós antecessores.
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
    atualizar(*raiz);
    (*raiz) = balancear(*raiz);
}

/**
 * Funcao que recebe a raiz de uma BST e atualiza sua altura 
 * e fator de balanço.
 * Lembre que a altura das sub-árvores direita e esquerda 
 * não vão mudar, por isso a implementação não é tão complicada.
 **/
void atualizar(struct noBst* no) {
    //IMPLEMENTAR
    if (no != NULL) {
        no->altura = altura(no);
        no->balanco = altura(no->dir) - altura(no->esq);
    }
}

/**
 * Funcao que recebe a raiz de uma BST e identifica em qual caso
 * ela se encaixa para executar os procedimentos de balanceamento
 * corretos:
 *      - Caso 1: esquerda-esquerda e esquerda-cheio
 *      - Caso 2: esquerda-direita
 *      - Caso 3: direita-direita e direita-cheio
 *      - Caso 4: direita-esquerda
 * Dica: usar fator de balanço do nó e de uma de suas sub-árvores
 * para descobrir qual é o caso.
 **/
struct noBst* balancear(struct noBst* no) {
    //IMPLEMENTAR
    if (no != NULL) {
        if (no->balanco == 2) {
            if (no->dir->balanco <= 0) {
                return rebalancearDirEsq(no);
            }
            else {
                return rebalancearDirDir(no);
            }
        }
        else if (no->balanco == -2) {
            if (no->esq->balanco <= 0) {
                return rebalancearEsqEsq(no);
            } 
            else {
                return rebalancearEsqDir(no);
            }
        }
    }
    return NULL;
};

/**
 * Funcao que recebe a raiz de uma BST e usa as rotações
 * apropriadas para balancear uma árvore desbalanceada no caso 1.
 * Lembre-se que durante o balanceamento a raiz muda
 * e essa função deve retornar a nova raiz.
 **/
struct noBst* rebalancearEsqEsq(struct noBst* no) {
    //IMPLEMENTAR
    if (no != NULL) {
        return rotacaoDireita(no);
    }
};

/**
 * Funcao que recebe a raiz de uma BST e usa as rotações
 * apropriadas para balancear uma árvore desbalanceada no caso 2.
 * Lembre-se que durante o balanceamento a raiz muda
 * e essa função deve retornar a nova raiz.
 **/
struct noBst* rebalancearEsqDir(struct noBst* no) {
    //IMPLEMENTAR
    if (no != NULL) {
        no->esq = rotacaoEsquerda(no->esq);
        return rebalancearEsqEsq(no);    
    }
};

/**
 * Funcao que recebe a raiz de uma BST e usa as rotações
 * apropriadas para balancear uma árvore desbalanceada no caso 3.
 * Lembre-se que durante o balanceamento a raiz muda
 * e essa função deve retornar a nova raiz.
 **/
struct noBst* rebalancearDirDir(struct noBst* no) {
    //IMPLEMENTAR
    if (no != NULL) {
        return rotacaoEsquerda(no);
    }
};

/**
 * Funcao que recebe a raiz de uma BST e usa as rotações
 * apropriadas para balancear uma árvore desbalanceada no caso 4.
 * Lembre-se que durante o balanceamento a raiz muda
 * e essa função deve retornar a nova raiz.
 **/
struct noBst* rebalancearDirEsq(struct noBst* no) {
    //IMPLEMENTAR]
    if (no != NULL) {
        no->dir = rotacaoDireita(no->dir);
        return rebalancearDirDir(no);
    }
};

/**
 * Funcao que retorna o maior valor de uma árvore.
 * Mesma implementação da BST.
 **/
int max(struct noBst* raiz) {
    //IMPLEMENTAR
    if (raiz == NULL) {
        return 0;
    }
    struct noBst* aux = raiz;
    while (aux->dir != NULL) {
        aux = aux->dir;
    }
    return aux->val;
}

/**
 * Funcao que retorna o menor valor de uma árvore.
 * Mesma implementação da BST.
 **/
int min(struct noBst* raiz) {
    //IMPLEMENTAR
    if (raiz == NULL) {
        return 0;
    }
    struct noBst* aux = raiz;
    while (aux->esq != NULL) {
        aux = aux->esq;
    }
    return aux->val;
}

/**
 * Funcao que retorna a altura de uma árvore.
 * A altura de uma árvore é dada pela quantidade
 * de arestas entre a raiz e a folha mais distante.
 * Mesma implementação da BST.
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
        return -1;
    }
}

/**
 * Funcao que recebe a raiz de uma árvore, e
 * remove o nó que contem o valor passado como
 * argumento. Tamanho deve ser decrementado.
 * Tamanho é passado por referência.
 * Lembrar de atualizar altura e fator de balanco dos nós
 * antecessores do nó removido, bem como balanceá-los caso
 * seja necessário.
 * Dica: reutilizar a função de remover de BST, e lembrar
 * de como usar inteligentemente a recursão para conseguir
 * atualizar e balancear os nós antecessores. 
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
    balancear(raiz);
    return raiz;
};

void imprimir(queue<struct noBst*> nosImpressao);

/**
* Função que imprime a árvore.
* Pode ser útil para depuração.
**/
void imprimir(struct noBst* raiz) {
    queue<struct noBst*> nosImpressao;
    nosImpressao.push(raiz);
    imprimir(nosImpressao);
}

void imprimir(queue<struct noBst*> nosImpressao) {

    queue<struct noBst*> nosImpressaoProxNivel;

    while (!nosImpressao.empty()) {
        struct noBst* noImpressao = nosImpressao.front();
        //add filhos na fila
        if(noImpressao != NULL){
            if (noImpressao->esq != NULL) 
                nosImpressaoProxNivel.push(noImpressao->esq);
            else
                nosImpressaoProxNivel.push(NULL);
            if (noImpressao->dir != NULL) 
                nosImpressaoProxNivel.push(noImpressao->dir);
            else
                nosImpressaoProxNivel.push(NULL);
        }
        nosImpressao.pop();

        if (noImpressao != NULL) {
            cout << to_string(noImpressao->val) << " | ";
        }
        else {
            cout << "N | ";
        }
    }
    cout << endl << endl;
    if(!nosImpressaoProxNivel.empty())
        imprimir(nosImpressaoProxNivel);
}