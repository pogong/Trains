//
//  main.m
//  XXhh
//
//  Created by 张三弓 on 2018/2/2.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>

//链表翻转

struct Node
{
    int val;
    struct Node *pNext;
}Node;

void addNode(struct Node * head,int val){
    struct Node * last = head;
    while (last->pNext) {
        last = last->pNext;
    }
    struct Node * add  = (struct Node *)malloc(sizeof(struct Node));
    add->pNext = NULL;//VI
    add->val = val;
    
    last->pNext = add;
}

void reverse(struct Node * head){
    struct Node * forward = head->pNext;
    struct Node * backward = head->pNext->pNext;
    forward->pNext = NULL;
    
    while (forward && backward) {
        struct Node * new = backward->pNext;
        backward->pNext = forward;
        
        forward = backward;
        backward = new;
    }
    head->pNext = forward;
}

void dispaly(struct Node * head){
    struct Node * last = head->pNext;
    while (last) {
        printf("%d ",last->val);
        last = last->pNext;
    }
    printf("\n");
}

int main()
{
    struct Node * head  = (struct Node *)malloc(sizeof(struct Node));
    head->pNext = NULL;
    head->val = -1;
    
    addNode(head,1);
    addNode(head,2);
    addNode(head,3);
    addNode(head,4);
    addNode(head,5);
    addNode(head,6);
    addNode(head,7);
    
    dispaly(head);
    
    reverse(head);
    
    dispaly(head);
    
    printf("\n");
    
    return 0;
}
