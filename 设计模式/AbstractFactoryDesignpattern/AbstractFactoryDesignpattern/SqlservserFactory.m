//
//  SqlservserFactory.m
//  AbstractFactoryDesignpattern
//
//  Created by 张三弓 on 2018/1/31.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import "SqlservserFactory.h"
#import "SqlserverUser.h"
#import "SqlServerDepartment.h"

@implementation SqlservserFactory
- (IUser *)createUser{
    return [SqlserverUser new];
}
- (IDepartment *)createDepartment{
    return [SqlServerDepartment new];
}
@end
