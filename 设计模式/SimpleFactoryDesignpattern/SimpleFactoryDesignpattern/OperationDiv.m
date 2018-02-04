//
//  OperationDiv.m
//  SimpleFactoryDesignpattern
//
//  Created by 张三弓 on 2018/1/31.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import "OperationDiv.h"

@implementation OperationDiv
- (NSInteger)getResult{
    NSAssert((self.numberB != 0), @"除数不能为0");
    
    return self.numberA / self.numberB;
}
@end
