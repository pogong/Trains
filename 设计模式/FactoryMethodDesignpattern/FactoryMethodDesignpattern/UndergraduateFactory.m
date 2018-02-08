//
//  UndergraduateFactory.m
//  FactoryMethodDesignpattern
//
//  Created by 张三弓 on 2018/1/31.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import "UndergraduateFactory.h"
#import "Undergraduate.h"

@implementation UndergraduateFactory
- (LeiFeng *)createLeifeng{
    return [Undergraduate new];
}
@end
