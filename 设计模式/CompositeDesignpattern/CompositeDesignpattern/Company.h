//
//  Company.h
//  CompositeDesignpattern
//
//  Created by 张三弓 on 2018/1/30.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Company : NSObject

@property(nonatomic,copy)NSString * title;

- (void)add:(Company *)company;
- (void)remove:(Company *)company;
- (void)display;
@end
