//
//  main.m
//  XXhh
//
//  Created by 张三弓 on 2018/2/2.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>

#define MATRIX 8

int chess[MATRIX][MATRIX] = {0};

int step = 0;

bool pointAllow(int x,int y,int x_add,int y_add){
    
    if (x+x_add >= 0 && x+x_add <= 7 && y+y_add >= 0 && y+y_add <= 7 && chess[x+x_add][y+y_add] == 0) {
    
        return true;
    }
    
    return false;
}

void startPoint(int x,int y){
    
    step++;
    printf("get %d step \n",step);
    chess[x][y] = step;
    
    if (step >= 64) {
        printf("\n");
        printf("done\n");
        printf("\n");
        for (int i = 0; i<8; i++) {
            for (int j = 0; j<8; j++) {
                printf("%2d  ",chess[i][j]);
            }
            printf("\n");
        }
        
        printf("\n");
        
        return;
    }
    
    if (pointAllow(x, y,-1,-2)) {
        startPoint(x-1,y-2);
    }
    if (pointAllow(x, y,-2,-1)) {
        startPoint(x-2,y-1);
    }
    if (pointAllow(x, y,-2,1)) {
        startPoint(x-2,y+1);
    }
    if (pointAllow(x, y,-1,2)) {
        startPoint(x-1,y+2);
    }
    if (pointAllow(x, y,1,2)) {
        startPoint(x+1,y+2);
    }
    if (pointAllow(x, y,2,1)) {
        startPoint(x+2,y+1);
    }
    if (pointAllow(x, y,2,-1)) {
        startPoint(x+2,y-1);
    }
    if (pointAllow(x, y,1,-2)) {
        startPoint(x+1,y-2);
    }
    
//    printf("失败\n");
    
}

int main(void)
{
    startPoint(2, 0);
    
    return 0;
}

