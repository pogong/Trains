//
//  main.m
//  XXhh
//
//  Created by 张三弓 on 2018/2/2.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 BFS:广度优先遍历==>类似树的层遍历
 0入队列,0出队列,将与0相连的所有节点入队列(1,3,4);
 按照队列先进先出的原则,1出队列,'重复上述过程'.
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

typedef struct _QueueNode{
    char pointData;
    int index;
    struct _QueueNode * next;
}QueueNode;

typedef struct _Queue{
    QueueNode * first;
    QueueNode * last;
}Queue;

//void zc_dfs(int index,MGraph *G){
//
//    printf("%c\n",G->vexs[index]);
//    visited[index] = true;
//
//    for(int i = 0; i < MAXVEX; i++)
//    {
//        if (G->arc[index][i] > 0) {
//
//            if (visited[i] == false) {
//                zc_dfs(i,G);
//            }
//
//        }
//    }
//}

bool visited[MAXVEX];

void zc_addQueueNode(int i,Queue * queue,MGraph * map){
    QueueNode * one = (QueueNode *)malloc(sizeof(QueueNode));
    one->pointData = map->vexs[i];
    one->next = NULL;
    one->index = i;
    
    visited[i] = true;
    
    if (queue->first == NULL) {
        
        queue->first = one;
        queue->last = one;
        
    }else{
        
        queue->last->next = one;
        queue->last = one;
        
    }
    
}

void zc_bfs(MGraph * map,Queue *queue){

    if (queue->first == NULL) {
        printf("广度遍历完毕\n");
    }else{
        
        int index = queue->first->index;
        
        printf("%c\n",queue->first->pointData);
        
        if (queue->first == queue->last) {
            queue->first = NULL;
            queue->last = NULL;
        }else{
            queue->first = queue->first->next;
        }
        
        for(int i = 0; i < MAXVEX; i++)
        {
            if (map->arc[index][i] > 0 && visited[i] == false) {
                
                zc_addQueueNode(i,queue,map);
              
            }
        }

        zc_bfs(map,queue);
    }
}

int main(void)
{
    MGraph *map = (MGraph *)malloc(sizeof(MGraph));
    
    CreateMGraph(map);
    
    Queue *queue = (Queue *)malloc(sizeof(Queue));
    
    zc_addQueueNode(0,queue,map);
    
    zc_bfs(map,queue);
    
    return 0;
}

