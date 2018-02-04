//
//  Waiter.m
//  CommandDesignpattern
//
//  Created by 张三弓 on 2018/1/30.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import "Waiter.h"

@implementation Waiter
{
    NSMutableArray * _commandList;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        _commandList = [NSMutableArray array];
    }
    return self;
}

- (void)addCommand:(Command *)command{
    [_commandList addObject:command];
}

- (void)removeCommand:(Command *)command{
    [_commandList removeObject:command];
}

- (void)notify{
    for (Command * command in _commandList) {
        [command excute];
    }
}
@end
