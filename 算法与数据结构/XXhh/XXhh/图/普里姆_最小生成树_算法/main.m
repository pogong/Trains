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
        {0,1,6},
        {0,2,1},
        {0,3,5},
        {1,2,5},
        {1,4,3},
        {2,3,7},
        {2,4,5},
        {2,5,4},
        {3,5,2},
        {4,5,6}
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

int path[5][2];
int getPoint[6];

int getPathCount;

void clearBigPath(int pointA,int pointB,MGraph *map){
    for(int i=0; i < map->numVertexes; i++ )
    {
        if (i != pointA || i != pointB) {
            if (map->arc[pointA][i] > 0 && map->arc[pointB][i] > 0) {
                if (map->arc[pointA][i] > map->arc[pointB][i]) {
                    map->arc[pointA][i] = 0;
                }else{
                    map->arc[pointB][i] = 0;
                }
            }
        }
    }
}

bool needSerach(int point){
    for(int i=0; i < getPathCount; i++ )
    {
        int old = getPoint[i];
        if (old == point) {
            return false;
        }
    }
    return true;
}

//最小向中心靠拢

void zc_prim_find_path(MGraph *map){
    
    if (getPathCount >= 6) {
        printf("完成\n");
        return;
    }
    
    int oldPoint = -1;
    
    int lastPoint = -1;
    int lastPointWeight = 0;
    
    if (getPathCount == 0) {
        
        getPoint[getPathCount] = 0;
        getPathCount++;
        
        for(int i=0; i < map->numVertexes; i++ )
        {
            if (map->arc[0][i] > 0 && (lastPointWeight == 0 || map->arc[0][i] < lastPointWeight)) {
                lastPointWeight = map->arc[0][i];
                lastPoint = i;
            }
        }
        
        path[getPathCount][0] = 0;
        path[getPathCount][1] = lastPoint;
        
        printf("get path %d->%d\n",path[getPathCount][0],path[getPathCount][1]);
        
        getPoint[getPathCount] = lastPoint;
        getPathCount++;
        
        zc_prim_find_path(map);
        
    }else{
       
        for(int x=0; x < getPathCount; x++ )
        {
            int get = getPoint[x];
            for(int j=0; j < map->numVertexes; j++ )
            {
                if (get != j && (needSerach(j)==true)) {
                    if (map->arc[get][j] > 0 && (lastPointWeight == 0 || map->arc[get][j] < lastPointWeight)) {
                        lastPointWeight = map->arc[get][j];
                        lastPoint = j;
                        oldPoint = get;
                    }
                }
            }
        }
        
        path[getPathCount][0] = oldPoint;
        path[getPathCount][1] = lastPoint;
        
        printf("get path %d->%d\n",path[getPathCount][0],path[getPathCount][1]);
        
        getPoint[getPathCount] = lastPoint;
        getPathCount++;
        
        zc_prim_find_path(map);
        
    }
    
}

int main(void)
{
    MGraph *map = (MGraph *)malloc(sizeof(MGraph));
    
    CreateMGraph(map);
    
    zc_prim_find_path(map);
    
    return 0;
}

