//
//  main.m
//  XXhh
//
//  Created by 张三弓 on 2018/2/2.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>

//直接插入排序

//{1,2,0,3,4,95,6,7,9,8}  //{0,3,4,5,2,95,6,7,9,8}

//zc 自己写的 写法有点复杂
void zc_InsertSort(int k[],int n){
    int temp,count = 0;
    
    for (int i = 0; i <= n-1-1; i++) {
        count++;
        if (k[i]>k[i+1]) {
            
            temp = k[i+1];
            k[i+1] = k[i];
            
            int aim = 0;
            for (int x = i-1; x >= 0; x--) {
                count++;
                if (k[x] > temp) {
                    k[x+1] = k[x];
                }else{
                    aim = x+1;
                    break;
                }
            }
            k[aim] = temp;
            
        }
    }
    
    printf("比较次数 %d\n",count);
}

//zc 精简后的写法
void zc_InsertSort2(int k[],int n){
    int temp = 0;
    
    for (int i = 0; i <= n-1-1; i++) {
        if (k[i]>k[i+1]) {
            
            temp = k[i+1];
            k[i+1] = k[i];
            
            int aim = i;
            for (int x = i-1; k[x] > temp; x--) {
                k[x+1] = k[x];
                aim = x;
            }
            
            k[aim] = temp;
        }
    }
    
}

int main(){
    
    int arr[10] = {1,2,0,3,4,95,6,7,9,8};
//    int arr[10] = {0,3,4,5,2,95,6,7,9,8};
//    int arr[10] = {1,0,2,3,4,5,6,7,8,9};
    
    zc_InsertSort(arr,10);
    
    for (int i = 0; i<10; i++) {
        printf("%d ",arr[i]);
    }
    
    printf("\n");
    
    return 1;
}

