//
//  main.m
//  XXhh
//
//  Created by 张三弓 on 2018/2/2.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>

//递归
void print(){
    char a;
    scanf("%c",&a);
    if (a != '#') {
        print();
        printf("%c",a);
    }else{
        return;
    }
}

int main()
{
    print();
    return 0;
}
