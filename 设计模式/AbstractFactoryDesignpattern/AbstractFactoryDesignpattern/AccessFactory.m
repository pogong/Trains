//
//  AccessFactory.m
//  AbstractFactoryDesignpattern
//
//  Created by 张三弓 on 2018/1/31.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import "AccessFactory.h"
#import "AccessUser.h"
#import "AccessDepartment.h"

@implementation AccessFactory
- (IUser *)createUser{
    return [AccessUser new];
}
- (IDepartment *)createDepartment{
    return [AccessDepartment new];
}
@end
