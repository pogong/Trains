//
//  main.m
//  XXhh
//
//  Created by 张三弓 on 2018/2/2.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 线性查找 一个个的找
 折半查找
 插值查找 按比例找
 黄金查找
 
 线性索引查找
 >稠密索引
 >分块索引
 >倒排索引
 
 二叉排序树(重点)
 构造 遍历 '搜索' 插入 '删除'
 */

typedef enum {ERROR,OK} Status;

typedef struct BitNode{
    int data;
    struct BitNode *lchild,*rchild;
}BitNode;

Status zc_searchNode(BitNode * root,int key,BitNode ** aim){
    if (!root) {
        return ERROR;
    }
    
    if (root->data == key) {
        *aim = root;
        return OK;
    }else if (root->data > key){
        return zc_searchNode(root->lchild,key,aim);
    }else{
        return zc_searchNode(root->rchild,key,aim);
    }
}

void zc_insertNode(int num,BitNode * root){
    if (root->data == -1) {
        root->data = num;
    }else{
        if (num < root->data) {
            if (root->lchild) {
                zc_insertNode(num, root->lchild);
            }else{
                BitNode * node = (BitNode *)malloc(sizeof(BitNode));
                node->lchild = NULL;
                node->rchild = NULL;
                node->data = num;
                root->lchild = node;
            }
        }else{
            if (root->rchild) {
                zc_insertNode(num, root->rchild);
            }else{
                BitNode * node = (BitNode *)malloc(sizeof(BitNode));
                node->lchild = NULL;
                node->rchild = NULL;
                node->data = num;
                root->rchild = node;
            }
        }
    }
}

void inorderTraverse(BitNode * root){
    if (root) {
        inorderTraverse(root->lchild);
        printf("%d\n",root->data);
        inorderTraverse(root->rchild);
    }
}

Status SearchBST(BitNode * cur, int key, BitNode * qian, BitNode ** last)
{
    if( !cur )    // 查找不成功
    {
        *last = qian;
        return FALSE;
    }
    else if( key == cur->data )   // 查找成功
    {
        *last = cur;
        return TRUE;
    }
    else if( key < cur->data )
    {
        return SearchBST( cur->lchild, key, cur, last );   // 在左子树继续查找
    }
    else
    {
        return SearchBST( cur->rchild, key, cur, last );   // 在右子树继续查找
    }
}

/*
 0.左子树与右子树 都没有.直接删除
 1.单单有左子树 向前替换
 2.单单有右子树 向前替换
 3.左子树+右子树都有 找目标节点与前驱节点换值,更改前驱点本身的部署(比较复杂)
 */
Status Delete(BitNode ** p)
{
    BitNode * q;
    BitNode * s;
    
    if( (*p)->rchild == NULL )
    {
        q = *p;
        *p = (*p)->lchild;
        free(q);
    }
    else if( (*p)->lchild == NULL )
    {
        q = *p;
        *p = (*p)->rchild;
        free(q);
    }
    else
    {//105
        q = *p;//105
        s = (*p)->lchild;//100
        
        while( s->rchild )
        {
            q = s;//100
            s = s->rchild;//104
        }
        
        (*p)->data = s->data;//换值
        
        if( q != *p )
        {
            q->rchild = s->lchild;
        }
        else
        {
            q->lchild = s->lchild;
        }
        
        free(s);
    }
    
    return TRUE;
}

Status DeleteBST(BitNode ** T, int key)
{
    if( !*T )
    {
        return FALSE;
    }
    else
    {
        if( key == (*T)->data )
        {
            return Delete(T);
        }
        else if( key < (*T)->data )
        {
            return DeleteBST(&(*T)->lchild, key);
        }
        else
        {
            return DeleteBST(&(*T)->rchild, key);
        }
    }
}

//写法错误
//Status zc_deleteNode(BitNode * root, int key){
//
//    Delete(&(aim67->lchild));
//
//    return OK;
//
//    BitNode * aim = NULL;
//    Status xx = zc_searchNode(root, 46, &aim);
//
//    if (xx == ERROR) {
//        return ERROR;
//    }
//
//    Delete(&aim);
//
//    return OK;
//
//}

//find address of address(指向目标节点地址的指针)
Status zc_findAA(BitNode ** getin, int key,BitNode *** aim){
    if (!(* getin)) {
        return ERROR;
    }
    
    if ((* getin)->data == key) {
        *aim = getin;
        return OK;
    }else if ((* getin)->data > key){
        return zc_findAA(&(*getin)->lchild,key,aim);
    }else{
        return zc_findAA(&(*getin)->rchild,key,aim);
    }
}

Status zc_deleteNode(BitNode * root, int key){
    
    BitNode ** aim = NULL;
    
    zc_findAA(&root, key,&aim);//得二级指针的值,用三级指针.我也害怕,xix
    
    Delete(aim);
    
    return OK;
}

int main(void)
{
    BitNode * root = (BitNode *)malloc(sizeof(BitNode));
    root->lchild = NULL;
    root->rchild = NULL;
    root->data = -1;//先写双层指针,再调用方法划分内存太烦,所以...
    
    int arr[9] = {70,67,46,105,104,99,115,111,109};
    
    for (int i = 0; i<9; i++) {
        zc_insertNode(arr[i], root);
    }

    zc_deleteNode(root, 46);

    inorderTraverse(root);
    printf("\n");
    
    return 0;
}

