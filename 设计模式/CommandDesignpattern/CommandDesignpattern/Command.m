//
//  Command.m
//  CommandDesignpattern
//
//  Created by 张三弓 on 2018/1/30.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import "Command.h"

@implementation Command
{
    Barbecuer * _barbecuer;
}
- (id)initWithBarbecuer:(Barbecuer *)barbecuer
{
    self = [super init];
    if (self) {
        _barbecuer = barbecuer;
    }
    return self;
}

@end
