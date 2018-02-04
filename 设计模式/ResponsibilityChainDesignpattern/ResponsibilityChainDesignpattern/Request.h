//
//  Request.h
//  ResponsibilityChainDesignpattern
//
//  Created by 张三弓 on 2018/1/30.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Request : NSObject

@property(assign,nonatomic)NSInteger type;
@property(assign,nonatomic)int count;

@end
