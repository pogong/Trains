//
//  main.m
//  XXhh
//
//  Created by 张三弓 on 2018/2/2.
//  Copyright © 2018年 张三弓. All rights reserved.
//

/*
 弧是活动,顶点是事件(事件是一个瞬间)
 
 关键路劲:权值总和最大的路径
 
 etv(Earliest Time Of Vertex)：事件最早发生时间，就是顶点的最早发生时间；
 ltv(Latest Time Of Vertex)：事件最晚发生时间，就是每个顶点对应的事件最晚需要开始的时间，如果超出此时间将会延误整个工期。
 
 ete(Earliest Time Of Edge)：活动的最早开工时间，就是弧的最早发生时间。
 lte(Latest Time Of Edge)：活动的最晚发生时间，就是不推迟工期的最晚开工时间。
 */

#import <Foundation/Foundation.h>

typedef enum {ERROR,OK} Status;

#define MAXVEX 9

// 边表结点声明
typedef struct EdgeNode
{
    int weight;
    int adjvex;
    struct EdgeNode *next;
}EdgeNode;

// 顶点表结点声明
typedef struct VertexNode
{
    int in;            // 顶点入度
    int data;
    EdgeNode *firstedge;
}VertexNode, AdjList[MAXVEX];

typedef struct
{
    AdjList adjList;
    int numVertexes, numEdges;
}graphAdjList, *GraphAdjList;

EdgeNode * createEdgeNode(int i){
    EdgeNode * eNode = (EdgeNode *)malloc(sizeof(EdgeNode));
    eNode->adjvex = i;
    eNode->next = NULL;
    return eNode;
}

void setLink0(AdjList vertexNodeList){
    VertexNode * vertexNode0 = &vertexNodeList[0];
    
    EdgeNode * node1 = createEdgeNode(1);
    node1->weight = 6;
    EdgeNode * node2 = createEdgeNode(2);
    node2->weight = 4;
    EdgeNode * node3 = createEdgeNode(3);
    node3->weight = 5;
    
    vertexNode0->firstedge = node1;
    node1->next = node2;
    node2->next = node3;
}

void setLink1(AdjList vertexNodeList){
    VertexNode * vertexNode1 = &vertexNodeList[1];
    
    EdgeNode * node4 = createEdgeNode(4);
    node4->weight = 1;
    
    vertexNode1->firstedge = node4;
}

void setLink2(AdjList vertexNodeList){
    VertexNode * vertexNode2 = &vertexNodeList[2];
    
    EdgeNode * node4 = createEdgeNode(4);
    node4->weight = 1;
    
    vertexNode2->firstedge = node4;
}

void setLink3(AdjList vertexNodeList){
    VertexNode * vertexNode3 = &vertexNodeList[3];
    
    EdgeNode * node5 = createEdgeNode(5);
    node5->weight = 2;
    
    vertexNode3->firstedge = node5;
}

void setLink4(AdjList vertexNodeList){
    VertexNode * vertexNode4 = &vertexNodeList[4];
    
    EdgeNode * node6 = createEdgeNode(6);
    node6->weight = 7;
    EdgeNode * node7 = createEdgeNode(7);
    node7->weight = 5;
    
    vertexNode4->firstedge = node6;
    node6->next = node7;
}

void setLink5(AdjList vertexNodeList){
    VertexNode * vertexNode5 = &vertexNodeList[5];
    
    EdgeNode * node7 = createEdgeNode(7);
    node7->weight = 4;
    
    vertexNode5->firstedge = node7;
}

void setLink6(AdjList vertexNodeList){
    VertexNode * vertexNode6 = &vertexNodeList[6];
    
    EdgeNode * node8 = createEdgeNode(8);
    node8->weight = 2;
    
    vertexNode6->firstedge = node8;
}

void setLink7(AdjList vertexNodeList){
    VertexNode * vertexNode7 = &vertexNodeList[7];
    
    EdgeNode * node8 = createEdgeNode(8);
    node8->weight = 2;//zc change 4->2
    
    vertexNode7->firstedge = node8;
}

int *etv, *ltv;
int *stack2;            // 用于存储拓扑序列的栈
int top2;                // 用于stack2的栈顶指针

Status TopologicalSort(GraphAdjList GL)
{
    EdgeNode *e;
    int i, k, gettop;
    int top = 0;
    int count = 0;
    int *stack;
    
    stack = (int *)malloc(GL->numVertexes * sizeof(int));
    
    for( i=0; i < GL->numVertexes; i++ )
    {
        if( 0 == GL->adjList[i].in )
        {
            stack[++top] = i;
        }
    }
    
    top2 = 0;
    etv = (int *)malloc(GL->numVertexes*sizeof(int));
    for( i=0; i < GL->numVertexes; i++ )
    {
        etv[i] = 0;
    }
    stack2 = (int *)malloc(GL->numVertexes*sizeof(int));
    
    while( 0 != top )
    {
        gettop = stack[top--];
        stack2[++top2] = gettop;
        count++;
        
        for( e=GL->adjList[gettop].firstedge; e; e=e->next )
        {
            k = e->adjvex;
            
            if( !(--GL->adjList[k].in) )
            {
                stack[++top] = k;
            }
            
            //录入etv
            if( (etv[gettop]+e->weight) > etv[k] )
            {
                etv[k] = etv[gettop] + e->weight;
            }
        }
    }
    
    if( count < GL->numVertexes )
    {
        return ERROR;
    }
    else
    {
        return OK;
    }
}

// 求关键路径，GL为有向图，输出GL的各项关键活动
void CriticalPath(GraphAdjList GL)
{
    EdgeNode *e;
    int i, gettop, k, j;
    int ete, lte;
    
    // 调用改进后的拓扑排序，求出etv和stack2的值
    TopologicalSort(GL);
    
    // 初始化ltv都为汇点的时间
    ltv = (int *)malloc(GL->numVertexes*sizeof(int));
    for( i=0; i < GL->numVertexes; i++ )
    {
        ltv[i] = etv[GL->numVertexes-1];
    }
    
    // 从汇点倒过来逐个计算ltv
    while( 0 != top2 )
    {
        gettop = stack2[top2--];    // 注意，第一个出栈是'汇点',由后向前推导
        for( e=GL->adjList[gettop].firstedge; e; e=e->next )
        {
            k = e->adjvex;
            if( (ltv[k] - e->weight) < ltv[gettop] )
            {
                ltv[gettop] = ltv[k] - e->weight;
            }
        }
    }
    
    // 通过etv和ltv求ete和lte
    for( j=0; j < GL->numVertexes; j++ )
    {
        for( e=GL->adjList[j].firstedge; e; e=e->next )
        {
            k = e->adjvex;
            ete = etv[j];
            lte = ltv[k] - e->weight;
            
            if( ete == lte )
            {
                printf("<v%d,v%d> length: %d , ", GL->adjList[j].data+1, GL->adjList[k].data+1, e->weight );
            }
        }
    }
}

int main(void)
{
    int inArr[9]  = {0,1,1,1,2,1,1,2,2};
    
    AdjList vertexNodeList = {0};
    
    for (int i = 0; i<9; i++) {
        VertexNode * node = &vertexNodeList[i];
        node->in = inArr[i];
        node->data = i;
        node->firstedge = NULL;
    }
    
    setLink0(vertexNodeList);
    setLink1(vertexNodeList);
    setLink2(vertexNodeList);
    setLink3(vertexNodeList);
    setLink4(vertexNodeList);
    setLink5(vertexNodeList);
    setLink6(vertexNodeList);
    setLink7(vertexNodeList);
    
    GraphAdjList ad = (graphAdjList *)malloc(sizeof(graphAdjList));
    
    for (int i = 0; i<9; i++) {
        ad->adjList[i] = vertexNodeList[i];
    }
    ad->numEdges = 11;
    ad->numVertexes = 9;
    
    CriticalPath(ad);
    
    printf("\n");
    
    return 0;
}

