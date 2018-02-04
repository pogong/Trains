//
//  ConcreteCompany.m
//  CompositeDesignpattern
//
//  Created by 张三弓 on 2018/1/30.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import "ConcreteCompany.h"

@implementation ConcreteCompany
{
    NSMutableArray * _subCompanys;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _subCompanys = [NSMutableArray array];
    }
    return self;
}

- (void)add:(Company *)company{
    [_subCompanys addObject:company];
}
- (void)remove:(Company *)company{
    [_subCompanys removeObject:company];
}

- (void)display{
    NSLog(@"%@",self.title);
    for (Company * company in _subCompanys) {
        if ([company respondsToSelector:@selector(display)]) {
            [company display];
        }else{
            NSLog(@"---%@",company.title);
        }
    }
}

@end
