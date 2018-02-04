//
//  Command.h
//  CommandDesignpattern
//
//  Created by 张三弓 on 2018/1/30.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Barbecuer.h"

@interface Command : NSObject

- (id)initWithBarbecuer:(Barbecuer *)barbecuer;

- (void)excute;

@end
