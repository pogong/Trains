//
//  IDepartment.h
//  AbstractFactoryDesignpattern
//
//  Created by 张三弓 on 2018/1/31.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Department.h"

@interface IDepartment : NSObject
- (void)insertDepartment:(Department *)department;
@end
