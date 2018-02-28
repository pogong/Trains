//
//  main.m
//  XXhh
//
//  Created by 张三弓 on 2018/2/2.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>

//堆排序

//完全二叉树,满二叉树的定义 见于 印象笔记

//大顶堆 小顶堆

int count = 0;

void swap(int k[], int i, int j)
{
    int temp;
    
    temp = k[i];
    k[i] = k[j];
    k[j] = temp;
}

//void HeapAdjust(int k[], int s, int n)
//{
//    printf("HeapAdjust start\n");
//    int i, rootVaule;
//
//    rootVaule = k[s];
//
//    //由上向下调整,到下边了,需要的遍历的就就越多
//    for( i=2*s; i <= n; i*=2 )
//    {
//        //
//        printf("root>%d left>%d right>%d max>%d\n",s,2*s,2*s+1,n);
//        //
//
//        printf("zc see ==> %d\n",i);
//        count++;
//        if( i < n && k[i] < k[i+1] )
//        {
//            i++;
//        }
//
//        if( rootVaule >= k[i] )//根节点的值是三个里面最大的,可以退出循环
//        {
//            break;
//        }
//
//        k[s] = k[i];
//        s = i;      //换根节点
//    }
//
//    k[s] = rootVaule;
//    printf("HeapAdjust end\n");
//}

//zc 改造的
void HeapAdjust(int k[], int s, int n)
{
    printf("HeapAdjust start\n");

    while (2*s <= n) {
        
        if (2*s+1 > n) {//有根,有左,右节点缺失
            int root = k[s];
            int left = k[2*s];
            
            printf("root>%d left>%d\n",s,2*s);
            
            int swap_flag = 0;
            
            if (root < left) {
                swap(k, s, 2*s);
                s = 2*s;
                swap_flag = 1;
            }
            
            if (swap_flag == 0) {
                s = 2*s;
            }
        }else{//有根,有左,有右边
            int root = k[s];
            int left = k[2*s];
            int right = k[2*s+1];
            
            printf("root>%d left>%d right>%d\n",s,2*s,2*s+1);
            
            int swap_flag = 0;
            
            if (left > right) {
                if (root < left) {
                    swap(k, s, 2*s);
                    s = 2*s;
                    swap_flag = 1;
                }
            }else{
                if (root < right) {
                    swap(k, s, 2*s+1);
                    s = 2*s+1;
                    swap_flag = 1;
                }
            }
            
            if (swap_flag == 0) {
                s = 2*s;
            }
        }

        printf("new root>%d \n",s);//切换新的根节点
    }

    printf("HeapAdjust end\n");
}

void prK(int k[]){
    for(int i=1; i < 10; i++ )
    {
        printf("%d ", k[i]);
    }
    printf("\n");
}

void HeapSort(int k[], int n)
{
    int i;
    
    for( i=n/2; i > 0; i-- )//i=n/2而不是i=n,不是所有节点都有左右子节点的.'由下向上'构造大顶堆
    {
        printf("zc see %d\n",i);
        HeapAdjust(k, i, n);
    }
    
    //^初始化大顶堆构造完毕
    prK(k);
    printf("\n");
    
    for( i=n; i > 1; i-- )
    {
        swap(k, 1, i);
        HeapAdjust(k, 1, i-1);
        
        prK(k);
        
        //^把最大的值'放好',排除在堆之外,然后再由上到下构造大顶堆
    }
}

int main()
{
    int i, a[10] = {-1, 5, 2, 6, 0, 3, 9, 1, 7, 4};
    
    HeapSort(a, 9);
    
    printf("总共执行 %d 次比较!", count);
    printf("排序后的结果是：");
    for( i=1; i < 10; i++ )
    {
        printf("%d ", a[i]);
    }
    printf("\n");
    
    return 0;
}
