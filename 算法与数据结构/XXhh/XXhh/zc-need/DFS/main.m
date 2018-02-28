//
//  main.m
//  XXhh
//
//  Created by 张三弓 on 2018/2/2.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 DFS:深度优先遍历==>树的前序遍历
 
 */

// 时间复杂度为O(n+n^2+e)

#define MAXVEX 8            // 最大顶点数
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
    int i, j, k, w;
    
    G->numVertexes = MAXVEX;
    G->numEdges = 9;
    
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
    
    int arr[9][3] ={
        {0,1,1},
        {0,3,1},
        {0,4,1},
        {1,4,1},
        {1,2,1},
        {2,5,1},
        {3,6,1},
        {4,6,1},
        {6,7,1}
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

Boolean visited[MAXVEX];  //zc remain:看小甲鱼的教程改进的

void zc_dfs(int index,MGraph *G){
    
    printf("%c\n",G->vexs[index]);
    visited[index] = true;
    
    for(int i = 0; i < MAXVEX; i++)
    {
        if (G->arc[index][i] > 0) {
            
            if (visited[i] == false) {
                zc_dfs(i,G);
            }
            
        }
    }
}

int main(void)
{
    MGraph *map = (MGraph *)malloc(sizeof(MGraph));
    
    CreateMGraph(map);
    
    zc_dfs(0,map);
    
    return 0;
}

