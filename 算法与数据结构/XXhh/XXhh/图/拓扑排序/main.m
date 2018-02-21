//
//  main.m
//  XXhh
//
//  Created by 张三弓 on 2018/2/2.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {ERROR,OK} Status;

#define MAXVEX 15

// 边表结点声明
typedef struct EdgeNode
{
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

// 拓扑排序算法
// 若GL无回路，则输出拓扑排序序列并返回OK，否则返回ERROR
Status TopologicalSort(GraphAdjList GL)
{
    EdgeNode *e;
    int k, gettop;
    int top = 0;        // 用于栈指针下标索引
    int count = 0;        // 用于统计输出顶点的个数
    int *stack;            // 用于存储入度为0的顶点
    
    stack = (int *)malloc(GL->numVertexes * sizeof(int));
    
    for(int i=0; i < GL->numVertexes; i++ )
    {
        if( 0 == GL->adjList[i].in )
        {
            stack[++top] = i;    // 将度为0的顶点下标入栈
//            printf("入栈 ==> %d\n",i);
        }
    }
    
    while( 0 != top )
    {
        gettop = stack[top--];    // 出栈
//        printf("出栈 ====> %d\n",gettop);
        printf("%d -> ", GL->adjList[gettop].data+1);
        count++;
        
        for(EdgeNode * e=GL->adjList[gettop].firstedge; e; e=e->next )
        {
            k = e->adjvex;

            if( !(--GL->adjList[k].in) )
            {
                stack[++top] = k;
//                printf("%d 入栈 ==> %d\n",gettop,k);
            }
        }
    }
    
    if( count < GL->numVertexes )    // 如果count小于顶点数，说明存在环
    {
        return ERROR;
    }
    else
    {
        return OK;
    }
}

EdgeNode * createEdgeNode(int i){
    EdgeNode * eNode = (EdgeNode *)malloc(sizeof(EdgeNode));
    eNode->adjvex = i;
    eNode->next = NULL;
    return eNode;
}

void setLink0(AdjList vertexNodeList){
    VertexNode * vertexNode0 = &vertexNodeList[0];
    
    EdgeNode * node1 = createEdgeNode(1);
    EdgeNode * node2 = createEdgeNode(2);
    EdgeNode * node3 = createEdgeNode(3);
    
    vertexNode0->firstedge = node1;
    node1->next = node2;
    node2->next = node3;
}

void setLink2(AdjList vertexNodeList){
    VertexNode * vertexNode2 = &vertexNodeList[2];
    
    EdgeNode * node5 = createEdgeNode(5);
    EdgeNode * node6 = createEdgeNode(6);
    EdgeNode * node8 = createEdgeNode(8);
    EdgeNode * node9 = createEdgeNode(9);
    
    vertexNode2->firstedge = node5;
    node5->next = node6;
    node6->next = node8;
    node8->next = node9;
}

void setLink3(AdjList vertexNodeList){
    VertexNode * vertexNode3 = &vertexNodeList[3];
    
    EdgeNode * node6 = createEdgeNode(6);
    EdgeNode * node7 = createEdgeNode(7);
    EdgeNode * node9 = createEdgeNode(9);
    vertexNode3->firstedge = node6;
    node6->next = node7;
    node7->next = node9;
}

void setLink9(AdjList vertexNodeList){
    VertexNode * vertexNode9 = &vertexNodeList[9];
    
    EdgeNode * node6_2 = createEdgeNode(6);
    EdgeNode * node10 = createEdgeNode(10);
    vertexNode9->firstedge = node6_2;
    node6_2->next = node10;
}

void setLink10(AdjList vertexNodeList){
    VertexNode * vertexNode10 = &vertexNodeList[10];
    
    EdgeNode * node11 = createEdgeNode(11);
    vertexNode10->firstedge = node11;
}

void setLink12(AdjList vertexNodeList){
    VertexNode * vertexNode12 = &vertexNodeList[12];
    
    EdgeNode * node12 = createEdgeNode(13);
    EdgeNode * node3_2 = createEdgeNode(3);
    vertexNode12->firstedge = node12;
    node12->next = node3_2;
}

void setLink13(AdjList vertexNodeList){
    VertexNode * vertexNode13 = &vertexNodeList[13];
    
    EdgeNode * node1 = createEdgeNode(1);
    EdgeNode * node2 = createEdgeNode(2);
    EdgeNode * node14 = createEdgeNode(14);
    vertexNode13->firstedge = node1;
    node1->next = node2;
    node2->next = node14;
}

void setLink14(AdjList vertexNodeList){
    VertexNode * vertexNode14 = &vertexNodeList[14];
    
    EdgeNode * node4 = createEdgeNode(4);
    vertexNode14->firstedge = node4;
}

int main(void)
{
    int inArr[15]  = {0,2,2,2,1,1,3,1,1,2,1,1,0,1,1};
    AdjList vertexNodeList = {0};
    
    for (int i = 0; i<15; i++) {
        VertexNode * node = &vertexNodeList[i];
        node->in = inArr[i];
        node->data = i;
        node->firstedge = NULL;
    }
    
    //0 3
    setLink0(vertexNodeList);

    //2 4
    setLink2(vertexNodeList);
    
    //3 1
    setLink3(vertexNodeList);
    
    //9 2
    setLink9(vertexNodeList);
    
    //10 1
    setLink10(vertexNodeList);
    
    //12 2
    setLink12(vertexNodeList);
    
    //13 3 //1 2 14
    setLink13(vertexNodeList);
    
    //14 1
    setLink14(vertexNodeList);
    
    GraphAdjList ad = (graphAdjList *)malloc(sizeof(graphAdjList));
//    ad->adjList = vertexNodeList;//数组不能直接那么写
    
    for (int i = 0; i<15; i++) {
        ad->adjList[i] = vertexNodeList[i];
    }
    ad->numEdges = 19;
    ad->numVertexes = 15;
    
    TopologicalSort(ad);
    
    printf("\n");
    
    return 0;
}

