//
//  Operation.h
//  SimpleFactoryDesignpattern
//
//  Created by 张三弓 on 2018/1/31.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Operation : NSObject

@property(assign,nonatomic)NSInteger numberA;
@property(assign,nonatomic)NSInteger numberB;

+ (Operation *)createOperationWithOpString:(NSString *)opString;

- (NSInteger)getResult;

@end
