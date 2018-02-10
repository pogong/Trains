//
//  main.m
//  XXhh
//
//  Created by 张三弓 on 2018/2/2.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "huffman.h"

typedef struct _Symbolprobability {
    char symbol;
    int probability;
}Symbolprobability;

typedef struct _HffmanTreeNode {
    char symbol;
    struct _HffmanTreeNode * left;
    struct _HffmanTreeNode * right;
}HffmanTreeNode;

typedef struct _QueueNode {
    int probability;
    HffmanTreeNode * treeNode;
    struct _QueueNode * next;
}QueueNode;

typedef struct _Queue {
    unsigned int size;
    QueueNode *head;
}Queue;

typedef struct _HffmanTree {
    HffmanTreeNode *root;
}HffmanTree;

typedef struct _HffmanTableNode {
    char symbol;
    char *code;
    struct _HffmanTableNode *next;
}HffmanTableNode;

typedef struct _HffmanTable {
    HffmanTableNode * first;
    HffmanTableNode * last;
}HffmanTable;

/*
坑1:结构体赋值==>何时用.,何时用->
Symbolprobability xx = {'c',10};
xx.probability++;

Symbolprobability * some = (Symbolprobability *)malloc(sizeof(Symbolprobability)*256);
for (int i = 0; i<256; i++) {
    Symbolprobability * sub = &some[i];
    sub->symbol = 'a';
    sub->probability = i;
}
 
坑2:链表没有头节点(无真实数据的那个)很麻烦,加了头节点超级方便
 
坑3:链表只做后续插入,不做中间传入,用first+last会比较方便(不同与坑2)
*/

QueueNode * zc_createQueueNode(int probability,HffmanTreeNode * treeNode){
    QueueNode * new = (QueueNode *)malloc(sizeof(QueueNode));
    new->next = NULL;
    new->probability = probability;
    new->treeNode = treeNode;
    return new;
}

QueueNode * zc_add_queue_node(QueueNode * new,Queue * queue){
    
    queue->size++;
    
    if (queue->head->next == NULL) {//queue没有first
        
        queue->head->next = new;
        return new;
        
    }else{

        QueueNode * cur = queue->head;
        
        while (1) {
            if (cur->next->probability < new->probability) {
                
                cur = cur->next;
                if (cur->next) {
                    //继续向后看
                }else{
                    cur->next = new;
                    return new;
                }
                
            }else{
                new->next = cur->next;
                cur->next = new;
                return new;
            }
        }
        
    }
}

Queue * zc_create_queue(Symbolprobability * some){
    
    Queue * queue = (Queue *)malloc(sizeof(Queue));
    queue->head = zc_createQueueNode(0,NULL);
    queue->size = 0;
    
    for (int i = 0; i<256; i++) {
        Symbolprobability * sub = &some[i];
        if (sub->probability > 0) {
            
            HffmanTreeNode * treeNode = (HffmanTreeNode *)malloc(sizeof(HffmanTreeNode));
            treeNode->symbol = sub->symbol;
            treeNode->left = NULL;
            treeNode->right = NULL;
            
            QueueNode * queueNode = zc_createQueueNode(sub->probability, treeNode);
            zc_add_queue_node(queueNode,queue);
        }
    }
    
    QueueNode * one = queue->head->next;
    while (one) {
        printf("zc see %d-%c\n",one->probability,one->treeNode->symbol);
        one = one->next;
    }
    
    return queue;
}

Symbolprobability * zc_create_probability(char * string){
    Symbolprobability * some = (Symbolprobability *)malloc(sizeof(Symbolprobability)*256);
    
    for (int i = 0; i<256; i++) {
        Symbolprobability * sub = &some[i];
        sub->symbol = ' ';
        sub->probability = 0;
    }
    
    for (int i = 0; string[i] != '\0'; i++) {
        Symbolprobability * sub = &some[(int)(string[i])];
        sub->probability = sub->probability+1;
        sub->symbol = (char)(string[i]);
    }
    
    for (int i = 0; i<256; i++) {
        Symbolprobability * sub = &some[i];
        if (sub->probability > 0) {
           printf("%c-%d\n",sub->symbol,sub->probability);
        }
    }
    
    return some;
}

HffmanTree * zc_create_tree(Queue * queue){

    HffmanTreeNode * lastTreeNode = NULL;
    
    while (queue->size > 1) {
        QueueNode * fisrt = queue->head->next;
        QueueNode * second = fisrt->next;
        
        queue->head->next = queue->head->next->next->next;
        queue->size -= 2;
        
        HffmanTreeNode * newTreeNode = (HffmanTreeNode *)malloc(sizeof(HffmanTreeNode));
        newTreeNode->symbol = '^';
        newTreeNode->left = fisrt->treeNode;
        newTreeNode->right = second->treeNode;
        
        QueueNode * queueNode = zc_createQueueNode(fisrt->probability+second->probability,newTreeNode);
        zc_add_queue_node(queueNode,queue);
        
        lastTreeNode = newTreeNode;
    }
    
    HffmanTree * tree = (HffmanTree *)malloc(sizeof(HffmanTree));
    tree->root = lastTreeNode;
    
    return tree;
}

void visit(char c,int level){
    printf("%c位于第%d层\n",c,level);
}

void zc_preorderTraversal(HffmanTreeNode * treeNode,int level){
    if (treeNode) {
        visit(treeNode->symbol,level);
        zc_preorderTraversal(treeNode->left, level+1);
        zc_preorderTraversal(treeNode->right, level+1);
    }
}

void zc_setTableNode(HffmanTreeNode * treeNode,char * code,int k,HffmanTable ** ptable){
    HffmanTable * table = (* ptable);
    
    if (treeNode == NULL) {
        return;
    }
    
    if (treeNode->left == NULL && treeNode->right == NULL) {
        code[k] = '\0';
        HffmanTableNode * tableNode = (HffmanTableNode *)malloc(sizeof(HffmanTableNode));
        tableNode->code = (char *)malloc(sizeof(char)*(strlen(code)+1));
        strcpy(tableNode->code,code);
        tableNode->symbol = treeNode->symbol;
        
        if (table->first == NULL) {
            table->first = tableNode;
            table->last = tableNode;
        }else{
            table->last->next = tableNode;
            table->last = tableNode;
        }
        
        printf("get %c\n",tableNode->symbol);
        
    }
    
    if(treeNode->left!=NULL)
    {
        code[k]='0';
        zc_setTableNode(treeNode->left,code,k+1,ptable);
    }
    
    if(treeNode->right!=NULL)
    {
        code[k]='1';
        zc_setTableNode(treeNode->right,code,k+1,ptable);
    }
}

HffmanTable * zc_createTable(HffmanTree * tree)
{
    HffmanTable *table = (HffmanTable *)malloc(sizeof(HffmanTable));
    table->first = NULL;
    table->last = NULL;
    
    char code[256];
    int k = 0;
    
    //链表
    zc_setTableNode(tree->root, code, k,&table);
    
    return table;
}

void zc_encode(HffmanTable *table, char *stringToEncode)
{
    HffmanTableNode *traversal;
    
    for(int i=0; stringToEncode[i]!='\0'; i++)
    {
        traversal = table->first;
        while(traversal->symbol != stringToEncode[i])
            traversal = traversal->next;
        printf("%s",traversal->code);
    }
    
    printf("\n");
}

void zc_decode(HffmanTree * tree,char * string){
    HffmanTreeNode * cur = tree->root;
    for (int i = 0; string[i] != '\0'; i++) {
        if (cur->left == NULL && cur->right == NULL) {
            printf("%c",cur->symbol);
            cur = tree->root;
        }
        
        if(string[i] == '0')
            cur = cur->left;
        
        if(string[i] == '1')
            cur = cur->right;
    }
    
    if (cur->left == NULL && cur->right == NULL) {
        printf("%c",cur->symbol);
    }
    
    printf("\n");
}

int main(void)
{
    Symbolprobability * list = zc_create_probability("aaaaa+boop+boop+ccc!");

    Queue * queue = zc_create_queue(list);

    HffmanTree * tree = zc_create_tree(queue);

//    zc_preorderTraversal(tree->root,1);
    
    HffmanTable * table = zc_createTable(tree);
    
    zc_encode(table,"aaacc!");

    zc_decode(tree,"0011111000111");

    return 1;
    
    //We build the tree depending on the string
    htTree *codeTree = buildTree("aaaaa+boop+boop+ccc!");
    
    //We build the table depending on the Huffman tree
    hlTable *codeTable = buildTable(codeTree);
    
    //We encode using the Huffman table
    encode(codeTable,"aaacc!");
    //We decode using the Huffman tree
    //We can decode string that only use symbols from the initial string
    decode(codeTree,"0011111000111");
    //Output : 0011 1110 1011 0001 0010 1010 1100 1111 1000 1001
    return 0;
}
