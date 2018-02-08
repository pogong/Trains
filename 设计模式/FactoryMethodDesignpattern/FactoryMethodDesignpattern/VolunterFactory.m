//
//  VolunterFactory.m
//  FactoryMethodDesignpattern
//
//  Created by 张三弓 on 2018/1/31.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import "VolunterFactory.h"
#import "Volunteer.h"

@implementation VolunterFactory
- (LeiFeng *)createLeifeng{
    return [Volunteer new];
}
@end
