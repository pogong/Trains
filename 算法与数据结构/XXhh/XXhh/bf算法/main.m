//
//  main.m
//  XXhh
//
//  Created by 张三弓 on 2018/2/2.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>

int bf_subStringMatch(char *arr1,char *arr2){
    int start = 0;
    int j = 0;
    
    int in_loop_count = 0;
    
    while (arr1[start + j] != '\0') {
        
        in_loop_count ++;
        
        if (arr1[start + j] == arr2[j]) {
            printf("zc--%c\n",arr2[j]);
            j++;
            if (arr2[j] == '\0') {
                printf("in_loop_count--%d\n",in_loop_count);
                return 1;
            }
        }else{
            start++;
            j=0;
        }
    }
    
    printf("in_loop_count--%d\n",in_loop_count);
    return 0;
}

void bf_code(){
    char *arr1="ILoveFishC.com";
    char *arr2="FishC.com";
    
    if (bf_subStringMatch(arr1,arr2)) {
        printf("匹配\n");
    }else{
        printf("不匹配\n");
    }
}

int main()
{
    
}

