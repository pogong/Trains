//
//  Waiter.h
//  CommandDesignpattern
//
//  Created by 张三弓 on 2018/1/30.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Command.h"

@interface Waiter : NSObject

- (void)addCommand:(Command *)command;
- (void)removeCommand:(Command *)command;

- (void)notify;

@end
