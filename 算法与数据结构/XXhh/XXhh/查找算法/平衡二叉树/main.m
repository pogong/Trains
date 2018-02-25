//
//  main.m
//  XXhh
//
//  Created by 张三弓 on 2018/2/2.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>


#define TRUE  1
#define FALSE 0

// 定义平衡二叉树的结点结构
typedef struct BiTNode
{
    int data;
    int bf;             // 平衡因子
    struct BiTNode *lchild, *rchild;
}BiTNode, *BiTree;

typedef int Status;

// 右旋处理，即LL调整
void R_Rotate( BiTree *p )
{
    BiTree L;
    L = (*p)->lchild;
    (*p)->lchild = L->rchild;
    L->rchild = *p;
    *p = L;
}

//zc 觉得可以这样
void zc_R_Rotate( BiTree *p )
{
    BiTree L;
    L = (*p)->lchild;
    (*p)->lchild = NULL;//zc 觉得(*p)->lchild = L->rchild;没有必要
    L->rchild = *p;
    *p = L;
}

// 左旋处理，即RR调整
void L_Rotate( BiTree *p )
{
    BiTree R;
    R = (*p)->rchild;
    (*p)->rchild = R->lchild;
    R->lchild = *p;
    *p = R;
}


/*
 zc 总结:
 
 / 到 .^. : R_Rotate 右转
 < 到 .^. : 下部两个节点先L_Rotate转换成/,然后三个节点一起R_Rotate
 \ 到 .^. : 同理不多解释
 > 到 .^. : 同理不多解释
*/

// 左平衡旋转处理，包括 LL 和 LR 调整
void LeftBalance( BiTree *T )
{
    printf("----------LeftBalance in\n");
    BiTree L, Lr;
    L = (*T)->lchild;
    switch( L->bf ){
            
        case 1:        // 新结点插入在T的左孩子的左子树上，为LL型，作右旋处理即LL调整
            (*T)->bf = L->bf = 0;
            R_Rotate( T );
            break;
        case -1:        // 新结点插入在T的左孩子的右子树上，为LR型，作双旋处理
            Lr = L->rchild;
            
            switch( Lr->bf ){
            case 1:   //zc 觉得 剧情不会发生
                (*T)->bf = -1;
                L->bf = 0;
                break;
            case 0:
                (*T)->bf = L->bf = 0;
                break;
            case -1:  //zc 觉得 剧情不会发生
                (*T)->bf = 0;
                L->bf = 1;
                break;
            }
            
            Lr->bf = 0;
            
            L_Rotate( &(*T)->lchild );      // 先对T的左子树进行左旋处理即RR调整
            R_Rotate( T );                  // 再对T进行右旋处理即LL调整
            
    }
}

// 右平衡旋转处理，包括 RR 和 RL 调整
void RightBalance( BiTree *T )
{
    printf("----------RightBalance in\n");
    BiTree R, Rl;
    R = (*T)->rchild;
    switch( R->bf )
    {
        case -1:        // 新结点插入在T的右孩子的右子树上，为RR型，作左旋处理即RR调整
            (*T)->bf = R->bf = 0;
            L_Rotate( T );
            break;
        case 1:        // 新结点插入在T的右孩子的左子树上，为RL型，作双旋处理
            Rl = R->lchild;
            switch( Rl->bf )
        {
            case 1:
                (*T)->bf = 0;
                R->bf = -1;
                break;
            case 0:
                (*T)->bf = R->bf = 0;
                break;
            case -1:
                (*T)->bf = 1;
                R->bf = 0;
                break;
        }
            Rl->bf = 0;
            R_Rotate( &(*T)->rchild );      // 先对T的左子树进行左旋即RR调整
            L_Rotate( T );                  // 再对T进行右旋即LL调整
    }
}

// 若在平衡二叉树T中不存在和 e 具有相同数据的结点，则插入数据元素为 e 的新结点，
// 若因插入使二叉排序树失去平衡，则要作平衡调整，
// 布尔变量taller表示 T 的深度是否增加，TRUE表示增加，FALSE表示没有增加


/*
 zc 总结:递归逐层退出,A1层(节点由下至上)告诉A2层'高度差'是否变大,A2层结合'高度差'+'本身的平衡值'来做出对应的反应.
 */
Status InsertAVL( BiTree *T, int e, Status *taller )
{
    printf("InsertAVL in\n");
    
    if( !*T )
    {
        *T = (BiTree)malloc(sizeof(BiTNode));
        (*T)->data = e;
        (*T)->lchild = (*T)->rchild = NULL;
        (*T)->bf = 0;
        *taller = TRUE;
    }
    else
    {
        // 树中已有和e具有相同数据的结点，则不再插入
        if( e == (*T)->data )
        {
            *taller = FALSE;
            return FALSE;
        }
        
        if( e < (*T)->data )    // 继续在T的左子树进行搜索
        {
            if( !InsertAVL( &(*T)->lchild, e, taller ) ) // InsertAVL( &(*T)->lchild, e, taller )得到的是T的左孩子结点(*T)->lchild的 data,bf 等相关信息
            {
                return FALSE;
            }
            
            // 如果e已插入到T的左子树中，且左子树深度增加
            if( *taller )
            {
                switch( (*T)->bf )      // 检查T的平衡因子
                {
                    case 1:                // 原本左子树比右子树高，再加上此结点，导致不平衡，需要作LL或LR调整
                        LeftBalance( T );
                        *taller = FALSE;
                        break;
                    case 0:                // 原本左右子树等高，再加上此结点，左子树增高
                        (*T)->bf = 1;
                        *taller = TRUE;
                        break;
                    case -1:                // 原本右子树比左子树高，再加上此结点，左右子树变为等高
                        (*T)->bf = 0;
                        *taller = FALSE;
                        break;
                }
            }
        }
        else        // 在T的右子树进行搜索
        {
            if( !InsertAVL( &(*T)->rchild, e, taller ) )
            {
                return FALSE;
            }
            
            if( *taller )
            {
                switch( (*T)->bf )
                {
                    case 1:                // 原先左子树比右子树高，现在左右子树等高
                        (*T)->bf = 0;
                        *taller = FALSE;
                        break;
                    case 0:                // 原先左右子树等高，现在右子树增高
                        (*T)->bf = -1;
                        *taller = TRUE;
                        break;
                    case -1:                // 原先右子树比左子树高，现在再加上此结点，导致不平衡，需要作 RR 或 RL 调整
                        RightBalance( T );
                        *taller = FALSE;
                        break;
                }
            }
        }
    }
    
    printf("InsertAVL end\n");
    
    return TRUE;
}

// 对于实例，我们可以这样创建平衡二叉树
void CreateAVL()
{
    int i;
//    int a[10] = {2,1,0,3,4,5,6,9,8,7};
    int a[10] = {3,1,2,0,4,5,6,9,8,7};
    BiTree T = NULL;
    Status taller;
    
    for( i=0; i<10; i++ )
    {
        printf("%d start\n",a[i]);
        InsertAVL( &T, a[i], &taller );
        printf("%d end\n",a[i]);
    }
    
    printf("\n");
}

int main(){
    CreateAVL();
    return 1;
}

