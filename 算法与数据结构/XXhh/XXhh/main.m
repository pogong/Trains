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
    struct HffmanTreeNode * left;
    struct HffmanTreeNode * right;
}HffmanTreeNode;

typedef struct _QueueNode {
    int probability;
    HffmanTreeNode * treeNode;
    struct _QueueNode * next;
}QueueNode;

typedef struct _Queue {
    unsigned int size;
    QueueNode *first;
}Queue;

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
 
坑2:链表没有头节点(无真实数据的那个)很麻烦
*/

QueueNode * zc_createQueueNode(int probability,char symbol){
    QueueNode * new = (QueueNode *)malloc(sizeof(QueueNode));
    new->next = NULL;
    new->probability = probability;
    new->treeNode = (HffmanTreeNode *)malloc(sizeof(HffmanTreeNode));
    new->treeNode->symbol = symbol;
    new->treeNode->left = NULL;
    new->treeNode->right = NULL;
    return new;
}

void zc_add_queue_node(int probability,char symbol,Queue * queue){
    
    queue->size++;
    
    if (queue->first == NULL) {//queue没有first
        
        QueueNode * new = zc_createQueueNode(probability,symbol);
        queue->first = new;
        
    }else{

        QueueNode * need_free = zc_createQueueNode(0,'c');
        QueueNode * cur = need_free;
        cur->next = queue->first;//我把地址给你,你换指向关我什么事
        
        while (1) {
            if (cur->next->probability < probability) {
                
                cur = cur->next;
                if (cur->next) {
                    //继续向后
                }else{
                    QueueNode * new = zc_createQueueNode(probability,symbol);
                    cur->next = new;
                    
                    break;
                }
                
            }else{
                QueueNode * new = zc_createQueueNode(probability,symbol);
                
                if (queue->first == cur->next) {
                    new->next = queue->first;
                    queue->first = new;
                }else{
                    new->next = cur->next;
                    cur->next = new;
                }
                
                break;
            }
        }
        
        free(need_free);
    }
}

Queue * zc_create_queue(Symbolprobability * some){
    
    Queue * queue = (Queue *)malloc(sizeof(Queue));
    queue->first = NULL;
    queue->size = 0;
    
    for (int i = 0; i<256; i++) {
        Symbolprobability * sub = &some[i];
        if (sub->probability > 0) {
            zc_add_queue_node(sub->probability,sub->symbol,queue);
        }
    }
    
    QueueNode * one = queue->first;
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

int main(void)
{
    Symbolprobability * list = zc_create_probability("aaaaa boop boop ccc!");
    Queue * queue = zc_create_queue(list);
    
    
    
    
    return 1;
    
    //We build the tree depending on the string
    htTree *codeTree = buildTree("aaaaa boop boop ccc!");
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
