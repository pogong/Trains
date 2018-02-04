//
//  CommandManager.m
//  ResponsibilityChainDesignpattern
//
//  Created by 张三弓 on 2018/1/30.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import "CommandManager.h"

@implementation CommandManager

- (void)hanleRequest:(Request *)request{
    if (request.type < 2) {
        NSLog(@"%s 同意",__func__);
    }else{
        [self.upManager hanleRequest:request];
    }
}

@end
