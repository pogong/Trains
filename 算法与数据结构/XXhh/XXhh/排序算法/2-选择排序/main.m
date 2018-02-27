//
//  main.m
//  XXhh
//
//  Created by 张三弓 on 2018/2/2.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>

//选择排序比较次数是一定的(与未优化过的冒泡排序一样),但交换参数的次数会少一些,所以效率高一些
void zc_SelectSort(int k[],int n){
    int min,temp,count = 0;
    for (int i = 0; i <= n-1-1; i++) {
        min = i;
        for (int j = i+1; j <= n-1; j++) {
            count++;
            if (k[j] < k[min]) {
                min = j;
            }
        }
        if (min != i) {
            temp = k[min];
            k[min] = k[i];
            k[i] = temp;
        }
    }
    printf("比较次数 %d\n",count);
}

int main(){
    
    int arr[10] = {1,2,0,3,4,95,6,7,9,8};
//    int arr[10] = {1,0,2,3,4,5,6,7,8,9};
    
    zc_SelectSort(arr,10);
    
    for (int i = 0; i<10; i++) {
        printf("%d ",arr[i]);
    }
    
    printf("\n");
    
    return 1;
}

