//
//  main.m
//  XXhh
//
//  Created by 张三弓 on 2018/2/2.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MAXVEX 9            // 最大顶点数
#define INFINITY 99        // 用65535来代表无穷大

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
    G->numEdges = 16;
    
    for( i=0; i < G->numVertexes; i++ )
    {
        G->vexs[i] = (char)('0'+i);
    }
    
    for(int i=0; i < G->numVertexes; i++ )
    {
        for( j=0; j < G->numVertexes; j++ )
        {
            if (i == j) {
                G->arc[i][j] = 0;
            }else{
                G->arc[i][j] = INFINITY;            // 邻接矩阵初始化
            }
        }
    }
    
    int arr[16][3] ={
        {0,1,1},
        {0,2,5},
        {1,2,3},
        {1,3,7},
        {1,4,5},
        {2,4,1},
        {2,5,7},
        {3,4,2},
        {3,6,3},
        {4,5,3},
        {4,6,6},
        {4,7,9},
        {5,7,5},
        {6,7,2},
        {6,8,7},
        {7,8,4}
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
            printf("%2d ",G->arc[i][j]);
        }
        printf("\n");
    }
    
    printf("\n");
    
}

/*
 zc remain:精髓==>

 */

void zc_floyd_find_path(MGraph *map){
    
    int D[MAXVEX][MAXVEX];
    int P[MAXVEX][MAXVEX];
    
    for(int x=0; x < map->numVertexes; x++)
    {
        for(int y=0; y< map->numVertexes; y++)
        {
            D[x][y] = map->arc[x][y];
            P[x][y] = y;
        }
    }
    
    for(int k=0; k < map->numVertexes; k++)//k为any,any就是中继点
    {
        for(int x=0; x < map->numVertexes; x++)
        {
            for(int y=0; y < map->numVertexes; y++)
            {
                if (D[x][y] > D[x][k] + D[k][y]) {//k:1 x:0 y:2==>同理 迪杰斯特拉_最短路径_算法 的比较
                    D[x][y] = D[x][k] + D[k][y];
                    
                    if (P[x][k] != k) {
                        printf("%d ^ %d\n",P[x][k] , k);
                    }
                    
                    P[x][y] = P[x][k];//不直接写k(不直接写'中继点k',是因为当'中继点k'作为终点算最短路径时,有可能用到了其他的中继点.当然默认情况下,P[x][k]与k是相等的)
                    
                }
                
            }
        }
    }
    
    for(int i=0; i < map->numVertexes; i++ )
    {
        for( int j=0; j < map->numVertexes; j++ )
        {
            printf("%2d ",D[i][j]);
        }
        printf("\n");
    }
    
    printf("\n");
    
    for(int i=0; i < map->numVertexes; i++ )
    {
        for( int j=0; j < map->numVertexes; j++ )
        {
            printf("%2d ",P[i][j]);
        }
        printf("\n");
    }
    
    printf("\n");
    
}

int main(void)
{
    MGraph *map = (MGraph *)malloc(sizeof(MGraph));
    
    CreateMGraph(map);
    
    zc_floyd_find_path(map);
    
    return 0;
}

