//
//  main.m
//  XXhh
//
//  Created by 张三弓 on 2018/2/2.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>

//二分查找 θ(logn)

int binarySearch1(int a[] , int low , int high , int findNum)
{
    int mid = ( low + high ) / 2;
    if (low > high)
        return -1;
    else
    {
        if (a[mid] > findNum)
            return binarySearch1(a, low, mid - 1, findNum);
        else if (a[mid] < findNum)
            return binarySearch1(a, mid + 1, high, findNum);
        else
            return mid;
    }
}

int main()
{
//    int a[10] = {15, 20, 14, 0, 3, 19, 1, 17, 6, 18};
    int a[10] = {5, 13,19,21,37,56,64,75,80,88,92};
    int xx = binarySearch1(a,0,9,21);
    printf("\n");
    
    return 0;
}
