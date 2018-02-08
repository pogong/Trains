//
//  main.m
//  XXhh
//
//  Created by 张三弓 on 2018/2/2.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef char ElemType;
typedef int Status;

typedef struct DualNode{
    ElemType data;
    struct DualNode * prior;
    struct DualNode * next;
}DualNode,*DualNodeList;

Status initList(DualNodeList *L){
    DualNode *q,*p;
    
    *L = (DualNodeList)malloc(sizeof(DualNode));
    
    if (!(*L)) {
        return 0;
    }
    
    (*L)->next = (*L)->prior = NULL;
    
    p=(*L);
    
    for (int i = 0; i<26; i++) {
        q = (DualNode *)malloc(sizeof(DualNode));
        if (!q) {
            return 0;
        }
        q->data = 'A'+ i;
        q->prior = p;
        q->next = p->next;
        p->next = q;
        
        p = q;
        
    }
    
    p->next = (*L)->next;//双向循环列表不要头
    (*L)->next->prior = p;
    
    return 1;
}

void caesar(DualNodeList *L,int i){
    if (i>0) {
        do {
            (*L) =  (*L)->next;
        } while (--i);
    }
    
    if (i<0) {
        do {
            (*L) =  (*L)->next;
        } while (++i);
    }
}

int main(int argc, char * argv[]) {
    
    DualNodeList L;
    initList(&L);
    
    int d;
    
    scanf("%d",&d);
    
    caesar(&L,d);
    
    for (int i = 0; i<26; i++) {
        L = L->next;
        printf("%c",L->data);
    }
    
    return 0;
}
