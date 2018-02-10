//
//  main.m
//  XXhh
//
//  Created by 张三弓 on 2018/2/2.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>

// 时间复杂度为O(n+n^2+e)

#define MAXVEX 100            // 最大顶点数
#define INFINITY 65535        // 用65535来代表无穷大

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
    
    printf("请输入顶点数和边数：\n");
    scanf("%d %d", &G->numVertexes, &G->numEdges);
    
    getchar();
    
    for( i=0; i < G->numVertexes; i++ )
    {
        printf("请输入顶点值\n");
        scanf("%c", &G->vexs[i]);
        getchar();
    }
    
    for( i=0; i < G->numVertexes; i++ )
    {
        for( j=0; j < G->numVertexes; j++ )
        {
            G->arc[i][j] = INFINITY;            // 邻接矩阵初始化
        }
    }
    
    for( k=0; k < G->numEdges; k++ )
    {
        printf("请输入边(Vi,Vj)上的下标i,下标j和对应的权w:\n");        // 这只是例子，提高用户体验需要进行改善
        scanf("%d %d %d", &i, &j, &w);
        G->arc[i][j] = w;
        G->arc[j][i] = G->arc[i][j];            // 是无向网图，对称矩阵
    }
    
    for( int i=0; i < G->numVertexes; i++ )
    {
        for( int j=0; j < G->numVertexes; j++ )
        {
            printf("%d ",G->arc[i][j]);
        }
        printf("\n");
    }
    
    printf("\n");
    
}

int main(void)
{
    MGraph *map = (MGraph *)malloc(sizeof(MGraph));
    CreateMGraph(map);
    
    return 0;
}
