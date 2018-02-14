//
//  main.m
//  XXhh
//
//  Created by 张三弓 on 2018/2/2.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MAXVEX 9            // 最大顶点数
#define INFINITY 33        // 用65535来代表无穷大

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
            G->arc[i][j] = INFINITY;            // 邻接矩阵初始化
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
 以起点Va开始找直接路径最短的点,收录这个点Vb,通过Vb做中继点,更新Va到所有点的最短路径.
 这时可以简单的把Va和Vb看做一个'整体',以'整体'为起点开始找直接路径最短的点
 ......
 周而复始
 */

void zc_dijkstra_find_path(MGraph *map,int V0){
    
    int D[MAXVEX];
    int P[MAXVEX];
    int final[MAXVEX];
    
    int min = 0;
    int k = 0;
    
    // 初始化数据
    for(int x=0; x < map->numVertexes; x++)
    {
        final[x] = 0;                // 全部顶点初始化为未找到最短路径
        D[x] = map->arc[V0][x];        // 将与V0点有连线的顶点加上权值
        P[x] = 0;                // 初始化路径数组P为0
    }
    D[V0] = 0;        // V0至V0的路径为0
    final[V0] = 1;        // V0至V0不需要求路径
    
    // 开始主循环，每次求得V0到某个V顶点的最短路径
    for(int x=1; x < map->numVertexes; x++)
    {
        min = INFINITY;
        for(int i=0; i < map->numVertexes; i++)
        {
            if( !final[i] && D[i]<min )
            {
                k = i;
                min = D[i];
            }
        }
        final[k] = 1;    //将目前找到最近的节点存下来,后续以此点作为中继点,且排除此点做'最终节点'的可能
        
        printf("V%d收录到路径,后续以此点作为中继点\n",k);
        
        // 修正当前最短路径及距离
        for(int n=0; n < map->numVertexes; n++)
        {
            // 如果经过v顶点的路径比现在这条路径的长度短的话，更新！
            //0->1->x的总距离 小于 0->x的距离 (0通过1进而到达的节点,比任何0直接到达的节点更近,在这都会被替换掉)
            if( !final[n] && (min+map->arc[k][n] < D[n]) )
            {
                printf("(V0->V%d)的min[%d]+(V%d->V%d)[%d] < (V0->V%d)[%d]\n",k,min,k,n,map->arc[k][n],n,D[n]);
                D[n] = min + map->arc[k][n];    // 修改当前路径长度
                P[n] = k;                    // 存放前驱顶点
                
                for(int t=0; t < map->numVertexes; t++)
                {
                    printf("%d ",D[t]);             // 初始化路径数组P为0
                }
                printf("\n");
            }
        }
        printf("\n");
    }
    printf("\n");
}

int main(void)
{
    MGraph *map = (MGraph *)malloc(sizeof(MGraph));
    
    CreateMGraph(map);
    
    zc_dijkstra_find_path(map,0);
    
    return 0;
}

