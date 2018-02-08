//
//  main.m
//  XXhh
//
//  Created by 张三弓 on 2018/2/2.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef char ElemType;

typedef struct BitNode{
    char data;
    struct BitNode *lchild,*rchild;
}BitNode,* BitTree;

//前序输入
void createBitTree(BitTree * T){
    char c;
    scanf("%c",&c);//输入一长串,挨个读出
    if (' '== c) {
        *T = NULL;
    }else{
        *T = (BitNode *)malloc(sizeof(BitNode));
        (*T)->data = c;
        createBitTree(&(*T)->lchild);
        createBitTree(&(*T)->rchild);
    }
}

void visit(char c,int level){
    printf("%c位于第%d层\n",c,level);
}

void preorderTraversal(BitTree T,int level){
    if (T) {
        visit(T->data,level);
        preorderTraversal(T->lchild, level+1);
        preorderTraversal(T->rchild, level+1);
    }
}

void inorderTraverse(BitTree T,int level){
    if (T) {
        inorderTraverse(T->lchild, level+1);
        visit(T->data,level);
        inorderTraverse(T->rchild, level+1);
    }
}

void postorderTraverse(BitTree T,int level){
    if (T) {
        postorderTraverse(T->lchild, level+1);
        postorderTraverse(T->rchild, level+1);
        visit(T->data,level);
    }
}

int main()
{
    //[AB D  CE   ]
    
    int level = 1;
    
    BitTree T = NULL;
    
    printf("请输入\n");
    
    createBitTree(&T);
    
    printf("准备打印\n");
    
    postorderTraverse(T, level);
    
    return 0;
}

/*
 前序输入最简单,其他两种不可行.
 
 生成二叉树有空间浪费,普通二叉树,都会有空间浪费
 
  前序输入[AB D  CE   ]的输入概长这样:
 
     A
   B   C
    D E
 
 //前:ABDCE
 //中:BDAEC
 //后:DBECA
 
 中序遍历可以拯救地球
 
 */
