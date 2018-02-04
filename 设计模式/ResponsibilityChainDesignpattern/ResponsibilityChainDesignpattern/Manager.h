//
//  Manager.h
//  ResponsibilityChainDesignpattern
//
//  Created by 张三弓 on 2018/1/30.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Request.h"

@interface Manager : NSObject

@property(strong,nonatomic)Manager * upManager;

- (void)hanleRequest:(Request *)request;

@end
