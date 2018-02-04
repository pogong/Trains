//
//  Operation.m
//  SimpleFactoryDesignpattern
//
//  Created by 张三弓 on 2018/1/31.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import "Operation.h"
#import "OperationAdd.h"
#import "OperationSub.h"
#import "OperationDiv.h"
#import "OperationMul.h"

@implementation Operation

+ (Operation *)createOperationWithOpString:(NSString *)opString{
    Operation * op = nil;
    if ([opString isEqualToString:@"+"]) {
        op = [OperationAdd new];
    }else if([opString isEqualToString:@"-"]) {
        op = [OperationSub new];
    }else if([opString isEqualToString:@"*"]) {
        op = [OperationMul new];
    }else if([opString isEqualToString:@"/"]) {
        op = [OperationDiv new];
    }
    return op;
}

@end
