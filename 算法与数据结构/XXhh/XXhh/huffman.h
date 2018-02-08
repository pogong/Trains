//
//  huffman.h
//  XXhh
//
//  Created by 张三弓 on 2018/2/7.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#ifndef huffman_h
#define huffman_h

#include <stdio.h>
#include "huffman.h"

//The Huffman tree node definition
typedef struct _htNode {
    char symbol;
    struct _htNode *left, *right;
}htNode;

/*
 We "encapsulate" the entire tree in a structure
 because in the future we might add fields like "size"
 if we need to. This way we don't have to modify the entire
 source code.
 */
typedef struct _htTree {
    htNode *root;
}htTree;

//The Huffman table nodes (linked list implementation)
typedef struct _hlNode {
    char symbol;
    char *code;
    struct _hlNode *next;
}hlNode;

//Incapsularea listei
typedef struct _hlTable {
    hlNode *first;
    hlNode *last;
}hlTable;

htTree * buildTree(char *inputString);
hlTable * buildTable(htTree *huffmanTree);
void encode(hlTable *table, char *stringToEncode);
void decode(htTree *tree, char *stringToDecode);

#endif /* huffman_h */
