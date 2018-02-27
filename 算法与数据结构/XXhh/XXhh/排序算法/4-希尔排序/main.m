//
//  main.m
//  XXhh
//
//  Created by 张三弓 on 2018/2/2.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>

void zc_ShellSort2(int k[],int n){
    int temp,count = 0;
    int gap = n;
    
    do {
        
        gap = gap/3+1;
        
        for (int i = 0; i <= n-1-gap; i+=gap) {
            count++;
            if (k[i]>k[i+gap]) {
                
                temp = k[i+gap];
                k[i+gap] = k[i];
                
                int aim = 0;
                for (int x = i-gap; x >= 0; x-=gap) {
                    count++;
                    if (k[x] > temp) {
                        k[x+gap] = k[x];
                    }else{
                        aim = x+gap;
                        break;
                    }
                }
                k[aim] = temp;
                
            }
        }

        
    } while (gap > 1);
    printf("比较次数 %d\n",count);
}

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

//希尔排序

//希尔排序可以根据冒泡排序改动产生,也可以根据直接插入排序改动产生(这里是用直接插入排序改造的:改大间距,多求两次就可以了);

void zc_ShellSort(int k[],int n){
    int temp = 0;
    
    int gap = n;
    
    do {
        
        gap = gap/3+1;
        
        for (int i = 0; i <= n-1-gap; i+=gap) {
            if (k[i]>k[i+gap]) {
                
                temp = k[i+gap];
                k[i+gap] = k[i];
                
                int aim = i;
                for (int x = i-gap; k[x] > temp; x-=gap) {
                    k[x+gap] = k[x];
                    aim = x;
                }
                
                k[aim] = temp;
            }
        }
        
    } while (gap > 1);
}

int main(){
    
//    int arr[10] = {1,2,0,3,4,95,6,7,91,8};
    
    int arr[10] = {0,3,4,5,2,95,6,7,9,8};
//    int arr[10] = {1,0,2,3,4,5,6,7,8,9};
    
    zc_InsertSort(arr,10);
    
    for (int i = 0; i<10; i++) {
        printf("%d ",arr[i]);
    }
    
    printf("\n");
    
    return 1;
}

