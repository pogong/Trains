//
//  main.m
//  XXhh
//
//  Created by 张三弓 on 2018/2/2.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MAXVEX 6            // 最大顶点数
#define INFINITY 0        // 用65535来代表无穷大

typedef struct
{
    char vexs[MAXVEX];                // 顶点表
    int arc[MAXVEX][MAXVEX];        // 邻接矩阵
    int numVertexes, numEdges;        // 图中当前的顶点数和边数
} MGraph;

// 建立无向网图的邻接矩阵
void CreateMGraph(MGraph *G)
{
    int i, j, w;
    
    G->numVertexes = MAXVEX;
    G->numEdges = 10;
    
    for( i=0; i < G->numVertexes; i++ )
    {
        G->vexs[i] = (char)('0'+i);
    }
    
    for(int i=0; i < G->numVertexes; i++ )
    {
        for( j=0; j < G->numVertexes; j++ )
        {
            G->arc[i][j] = INFINITY;            // 邻接矩阵初始化
        }
    }
    
    int arr[10][3] ={
        {0,2,1},
        {3,5,2},
        {1,4,3},
        {2,5,4},
        {0,3,5},
        {1,2,5},
        {2,4,5},
        {0,1,6},
        {4,5,6},
        {2,3,7}
    };
    
    for(int k=0; k < G->numEdges; k++ )
    {
        i = arr[k][0];
        j = arr[k][1];
        w = arr[k][2];
        
        G->arc[i][j] = w;
        G->arc[j][i] = G->arc[i][j];            // 是无向网图，对称矩阵
    }
    
    for(int i=0; i < G->numVertexes; i++ )
    {
        for( int j=0; j < G->numVertexes; j++ )
        {
            printf("%d ",G->arc[i][j]);
        }
        printf("\n");
    }
    
    printf("\n");
    
}

//zc remain:精髓==>循环向前找,就意味着找两个大终端点

int parent[MAXVEX];

int find(int point){
    while (parent[point] > 0) {
        point = parent[point];
    }
    return point;
}

void zc_kruskal_find_path(MGraph *map){
    
    int arr[10][3] ={
        {0,2,1},
        {3,5,2},
        {1,4,3},
        {2,5,4},
        {0,3,5},
        {1,2,5},
        {2,4,5},
        {0,1,6},
        {4,5,6},
        {2,3,7}
    };
    
    int n,m;
    
    int count = 0;
    
    for (int i = 0 ; i < map->numEdges; i++) {
        n = find(arr[i][0]);
        m = find(arr[i][1]);
        
        if (n != m) {
            parent[n] = m;
            
            printf("连接%d>%d\n",arr[i][0],arr[i][1]);
            
            count++;
        }
        if (count >= MAXVEX - 1) {
            break;
        }
        
    }
    
}

int main(void)
{
    MGraph *map = (MGraph *)malloc(sizeof(MGraph));
    
    CreateMGraph(map);
    
    zc_kruskal_find_path(map);
    
    return 0;
}

