//
//  main.m
//  XXhh
//
//  Created by 张三弓 on 2018/2/2.
//  Copyright © 2018年 张三弓. All rights reserved.
//

/*
 zc 总结:
 根据特定算法加工传入的值得到相应的位置,将元素放入hash表的相应的位置
 根据特定算法+传入的值,在一个单位时间内找到元素的位置.
 
 ps:这里实现很简单,OC的hash表一定是键值都存的.键用于确定所放置的位置,值才是我真正需要的数据.
 */

#import <Foundation/Foundation.h>

#define HASHSIZE 12

#define HASHNULLVALUE -32768

typedef struct {
    int *elem;
    int count;
}HashTable;

int InitHashTable(HashTable * h){
    h->count = HASHSIZE;
    h->elem = (int *)malloc(HASHSIZE*sizeof(int));
    
    if (!h->elem) {
        return -1;
    }
    
    for (int i = 0; i<HASHSIZE; i++) {
        h->elem[i] = HASHNULLVALUE;
    }
    
    return 0;
}

int Hash(int value){
    return value % HASHSIZE;
}

int Insert(HashTable * h,int value){
    int hash = -1;
    
    hash = Hash(value);
    
    while (h->elem[hash] != HASHNULLVALUE) {
        value++;
        hash = Hash(value);
    }
    
    printf("插入位置 %d\n",hash);
    
    h->elem[hash] = value;
    
    return hash;
}

int Search(HashTable * h,int value){
    int hash = -1;

    int originHash = Hash(value);
    hash = originHash;
    
    while (h->elem[hash] != value) {
        value++;
        hash = Hash(value);
        if (h->elem[hash] == HASHNULLVALUE) {//空值,没找到
            printf("没找到1");
            return -1;
        }
        if (originHash == hash) {//找回原来的位置
            printf("没找到2");
            return -1;
        }
    }
    printf("在位置 %d\n",hash);
    return hash;
}

int main(){
    
    HashTable * h = (HashTable *)malloc(sizeof(HashTable));
    
    InitHashTable(h);
    
    Insert(h, 13);
    Insert(h, 13+12);
    
    Search(h,13);
    Search(h, 13+12);
    
    
    Search(h, 333);
    
    return 1;
}

