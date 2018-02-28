//
//  main.m
//  XXhh
//
//  Created by 张三弓 on 2018/2/2.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>

//归并排序

#define MAXSIZE 10

// 实现归并，并把最后的结果存放到list1里
void merging(int *list1, int list1_size, int *list2, int list2_size)
{
    int i, j, k, m;
    int temp[MAXSIZE];
    
    i = j = k = 0;
    
    while( i < list1_size && j < list2_size )
    {
        if( list1[i] < list2[j] )
        {
            temp[k++] = list1[i++];
        }
        else
        {
            temp[k++] = list2[j++];
        }
    }
    
    while( i < list1_size )
    {
        temp[k++] = list1[i++];
    }
    
    while( j < list2_size )
    {
        temp[k++] = list2[j++];
    }
    
    for( m=0; m < (list1_size + list2_size); m++ )
    {
        list1[m] = temp[m];
    }
}

void MergeSort(int k[], int n)
{
    if( n > 1)
    {
        int *list1 = k;
        int list1_size = n/2;
        int *list2 = k + n/2;
        int list2_size = n - list1_size;
        
        MergeSort(list1, list1_size);
        MergeSort(list2, list2_size);
        
        merging(list1, list1_size, list2, list2_size);
    }
}

void MergeSort2(int k[], int n)
{
    int i, next, left_min, left_max, right_min, right_max;
    int *temp = (int *)malloc(n * sizeof(int));
    
    for( i=1; i < n; i*=2 )//步长1->2->4
    {
        for( left_min=0; left_min < n-i; left_min = right_max )
        {
            right_min = left_max = left_min + i;
            right_max = left_max + i;
            
            if( right_max > n )
            {
                right_max = n;
            }
            
            next = 0;
            
            while( left_min < left_max && right_min < right_max )
            {
                printf("com %d ^ %d\n",k[left_min] , k[right_min]);
                
                if( k[left_min] < k[right_min] )//小的才进入temp数组
                {
                    temp[next++] = k[left_min++];
                }
                else
                {
                    temp[next++] = k[right_min++];
                }
            }
            
            while( left_min < left_max )//这里之所以只判断左不判断右,是因为大的在右边不来就ok!左边的值大没放入temp数组才应该'被吸收入'小规模的k数组内
            {
                k[--right_min] = k[--left_max];
            }
            
            while( next > 0 )
            {
                k[--right_min] = temp[--next];
            }
        }
        printf("\n");
    }
}

int main()
{
    int i, a[10] = {66, 99, 5, 2, 3, 9, 1, 7};
    
    MergeSort2(a, 8);
    
    printf("排序后的结果是：");
    for( i=0; i < 8; i++ )
    {
        printf("%d ", a[i]);
    }
    printf("\n\n");
    
    return 0;
}
