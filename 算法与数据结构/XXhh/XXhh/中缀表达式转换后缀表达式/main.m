//
//  main.m
//  XXhh
//
//  Created by 张三弓 on 2018/2/2.
//  Copyright © 2018年 张三弓. All rights reserved.
//

//线性表:链表+顺序表

//静态列表:没有C言语时期的列表,有点复杂

//队列==>链表+顺序表都可以 栈==>顺序表(数组)

#import <Foundation/Foundation.h>

#define STACK_INIT_SIZE 20
#define STACKINCREMENT 10
#define MAXBUFFER   10

typedef char ElemType;
typedef struct
{
    ElemType *base;
    ElemType *top;
    int stackSize;
}sqStack;

void InitStack(sqStack *s)
{
    s->base = (ElemType *)malloc(STACK_INIT_SIZE * sizeof(ElemType));
    if( !s->base )
        exit(0);
    
    s->top = s->base;
    s->stackSize = STACK_INIT_SIZE;
    
}

void Push(sqStack *s, ElemType e)
{
    //如果栈满一定要增加空间，所以在之前要做一个判断
    if( s->top - s->base >= s->stackSize)
    {
        s->base = (ElemType *)realloc(s->base, (s->stackSize + STACKINCREMENT)* sizeof(ElemType));
        if(!s->base)
            exit(0);
        
        s->top = s->base + s->stackSize;
        s->stackSize = s->stackSize + STACKINCREMENT;
    }
    
    *(s->top) = e;
    s->top++;
    
}

void Pop(sqStack *s, ElemType *e)
{
    if( s->top == s->base)
        return;
    
    *e = *--(s->top); //将栈顶元素弹出并修改栈顶指针
    
}

int StackLen(sqStack s)
{
    return (s.top - s.base);
}

int main()
{
    sqStack s;
    ElemType c,e;
    
    
    InitStack( &s );
    
    printf("请输入中缀表达式，以#为结束标志：");
    scanf("%c", &c);//zc note:我输入1+(2-3)*4+10/5#,scanf挨个拿
    printf("step input %c \n",c);
    
    while( c != '#')
    {
        while( c >= '0' && c <= '9')
        {
            printf("%c", c);
            scanf("%c",&c);
            if( c<'0' || c>'9')
            {
                printf(" ");
            }
        }
        
        if( ')' == c )
        {
            Pop(&s, &e);
            while('(' != e)
            {
                printf("%c ", e);
                Pop(&s, &e);
            }
        }
        else if( '+' == c || '-' == c)
        {
            if( !StackLen(s) )
            {
                Push(&s, c);
            }
            else
            {
                do
                {
                    Pop(&s, &e);
                    if( '(' == e)
                    {
                        Push(&s, e);
                    }
                    else
                    {
                        printf("%c ", e);
                    }
                }while( StackLen(s) && '(' != e);
                Push(&s, c);
            }
        }
        else if( '*' == c || '/' == c || '(' == c)
        {
            Push(&s, c);
        }
        else if( '#' == c)
        {
            break;
        }
        else
        {
            printf("输入错误，请重新输入!\n");
            return -1;
        }
        scanf("%c", &c);
        printf("step input %c \n",c);
    }
    
    while( StackLen(s))
    {
        Pop( &s, &e);
        printf("%c ", e);
    }
    return 0;
}
