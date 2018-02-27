//
//  main.m
//  XXhh
//
//  Created by 张三弓 on 2018/2/2.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>

//冒泡排序

//不正宗的冒泡排序
void BubbleSort1(int k[],int n){
    
    int count = 0;
    int temp = 0;
    
    for (int i = 0; i<n-1; i++) {//i<n-1或者i<n,最终效果是一样的;但i<n-1才是对的
        for (int j = i+1; j<n; j++) {
            count++;
            if (k[i] > k[j]) {
                temp = k[j];
                k[j] = k[i];
                k[i] = temp;
            }
        }
    }
    
    printf("次数 %d\n",count);
    
}

//小的向前抛,前面持续比较(我写的方式,先确认最终位置的元素在后边)
void BubbleSort2(int k[],int n){
    int count = 0;
    int temp = 0;
    
    for (int i = n-1-1; i>=0; i--) {
        for (int j = 0; j<=i; j++) {
            count++;
            if (k[j] > k[j+1]) {
                
                temp = k[j+1];
                k[j+1] = k[j];
                k[j] = temp;
                
            }
        }
    }
    
    printf("次数 %d\n",count);
}

void BubbleSort3(int k[],int n){
    int count = 0;
    int temp = 0;
    int lastSwing = 1;
    for (int i = n-1-1; i>=0&&lastSwing; i--) {
        lastSwing = 0 ;
        for (int j = 0; j<=i; j++) {
            count++;
            if (k[j] > k[j+1]) {
                
                temp = k[j+1];
                k[j+1] = k[j];
                k[j] = temp;
                lastSwing = 1;
            }
        }
    }
    
    printf("次数 %d\n",count);
}

void xjy_BubbleSort2(int k[], int n)
{
    int i, j, temp, count1=0, count2=0;
    
    for( i=0; i < n-1; i++ )
    {
        for( j=n-1; j > i; j-- )
        {
            count1++;
            if( k[j-1] > k[j] )
            {
                count2++;
                temp = k[j-1];
                k[j-1] = k[j];
                k[j] = temp;
            }
        }
    }
    
    printf("总共进行了%d次比较，进行了%d次移动！", count1, count2);
}

//有问题,向论坛报错
void xjy_BubbleSort3(int k[], int n)
{
    int i, j, temp, count1=0, count2=0, flag;
    
    flag = 1;
    for( i=0; i < n-1 && flag; i++ )
    {
        flag = 0;
        for( j=n-1; j > i; j-- )
        {
            count1++;
            if( k[j-1] > k[j] )
            {
                count2++;
                temp = k[j-1];
                k[j-1] = k[j];
                k[j] = temp;
                flag = 1;
            }
        }
    }
    
    printf("总共进行了%d次比较，进行了%d次移动！", count1, count2);
}

int main(){
    
    int arr[10] = {1,2,0,3,4,95,6,7,9,8};
//    int arr[10] = {1,0,2,3,4,5,6,7,8,9};
    
    BubbleSort3(arr,10);
    
    for (int i = 0; i<10; i++) {
        printf("%d ",arr[i]);
    }
    
    printf("\n");
    
    return 1;
}

