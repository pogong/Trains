//
//  GeneralManager.m
//  ResponsibilityChainDesignpattern
//
//  Created by 张三弓 on 2018/1/30.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import "GeneralManager.h"

@implementation GeneralManager

- (void)hanleRequest:(Request *)request{
    if (request.type < 6) {
        NSLog(@"%s 同意",__func__);
    }
}

@end
