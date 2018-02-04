//
//  IFactory.h
//  AbstractFactoryDesignpattern
//
//  Created by 张三弓 on 2018/1/31.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IUser.h"
#import "IDepartment.h"

@interface IFactory : NSObject
- (IUser *)createUser;
- (IDepartment *)createDepartment;
@end
