//
//  OperationAdd.m
//  SimpleFactoryDesignpattern
//
//  Created by 张三弓 on 2018/1/31.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import "OperationAdd.h"

@implementation OperationAdd
- (NSInteger)getResult{
    return self.numberA + self.numberB;
}
@end
