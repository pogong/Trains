//
//  main.m
//  XXhh
//
//  Created by 张三弓 on 2018/2/2.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MAX 101

void GetNext(char* p,int next[])
{
    int pLen = strlen(p);
    
    next[0] = -1;
    
    int k = -1;
    int j = 0;
    while (j < pLen - 1)
    {
        //p[k]表示前缀，p[j]表示后缀
        
        if (k == -1 || p[j] == p[k])
        {
            ++k;
            ++j;
            printf("%d>%d>>set\n",j,k);
            next[j] = k;
        }
        else
        {
            k = next[k];
            printf("%d>%d\n",j,k);
        }
    }
    
    for (int i = 0; i<pLen ; i++) {
        printf("%d",next[i]);
    }
    printf("\n");
}

void otherUse(){
    int next[MAX]={0};
    
    char a[MAX] = "ABACABABE";
    
    GetNext(a,next);
    
    printf("\n");
}

//------------------------^网上找到的头一位用-1的,写法-------------------------------

void get_next(int *next,char *a) /*求NEXT[]的值*/
{
    int i=1,j=0 ;
    next[1] = 0 ;
    
    while (i <= a[0]) /*核心部分*/
    {
        if( a[i] == a[j] || j == 0 )
        {
            j ++ ;
            i ++ ;
            next[i] = j;
        }
        else{
            j = next[j];
            printf("%d vs %d \n",i,j);
        }
    }
}

//优化的
void get_next2(int *next,char *a) /*求NEXT[]的值*/
{
    int i=1,j=0 ;
    next[1] = 0 ;
    
    while ( i <= a[0]) /*核心部分*/
    {
        if( a[i] == a[j] || j == 0 )
        {
            j ++ ;
            i ++ ;
            if(a[i] == a[j]){
                next[i] = next[j];
            }else{
                next[i] = j;
            }
        }
        else{
            j = next[j];
        }
    }
}

int kmp_subStringMatch(char *arr1,char *arr2,int *next,int pos){
    int i = pos;
    int j = 0;
    while (i <= arr1[0] && j <= arr2[0]) {
        if ( 0 == j || arr1[i] == arr2[j]) {
            i++;
            j++;
        }else{
            j = next[j];
        }
    }
    
    if (j > arr2[0]) {
        return i - arr1[0];
    }else{
        return 0;
    }
}

#define MAX 101

int main()
{
    int next[MAX]={0};
    
    char a[MAX] = " ababaaaba";
    
    a[0] = 9;
    
    get_next(next,a);
    for (int i = 1; i<10; i++) {
        printf("%d",next[i]);
    }
    printf("\n");
    get_next2(next,a);
    for (int i = 1; i<10; i++) {
        printf("%d",next[i]);
    }
    
    printf("\n");
    
    char a2[MAX] = " 124yababaaaba";
    
    if (kmp_subStringMatch(a2,a,next,1)) {
        printf("匹配\n");
    }else{
        printf("不匹配\n");
    }
    
}

