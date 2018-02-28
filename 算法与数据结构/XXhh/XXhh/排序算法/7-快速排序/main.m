//
//  main.m
//  XXhh
//
//  Created by 张三弓 on 2018/2/2.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>

//快速排序

void swap(int k[], int low, int high)
{
    printf("swap %d^%d\n",low, high);
    int temp;
    
    temp = k[low];
    k[low] = k[high];
    k[high] = temp;
}

int Partition(int k[], int low, int high)
{
    int point;
    
    point = k[low];
    
    while( low < high )
    {
        while( low < high && k[high] >= point )
        {
            high--;
        }
        swap(k, low, high);//基准点向大头移动
        
        while( low < high && k[low] <= point )
        {
            low++;
        }
        swap(k, low, high);//基准点向小头移动
    }
    
    return low;
}

void QSort(int k[], int low, int high)
{
    int point;
    
    if( low < high )
    {
        printf("1>%d做基准点\n",k[low]);
        point = Partition(k, low, high);
        printf("2>%d做基准点\n",k[point]);
        
        for(int i=0; i < 10; i++)
        {
            printf("%d ",k[i]);
        }
        printf("\n");
        
        QSort(k, low, point-1);
        
        QSort(k, point+1, high);
    }
}

void QuickSort(int k[], int n)
{
    QSort(k, 0, n-1);
}

int main()
{
    int i, a[10] = {15, 20, 14, 0, 3, 19, 1, 17, 6, 18};
    
    QuickSort(a, 10);
    
    printf("排序后的结果是：");
    for( i=0; i < 10; i++ )
    {
        printf("%d ", a[i]);
    }
    printf("\n");
    
    return 0;
}
