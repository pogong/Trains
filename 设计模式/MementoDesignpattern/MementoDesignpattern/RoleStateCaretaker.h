//
//  RoleStateCaretaker.h
//  MementoDesignpattern
//
//  Created by 张三弓 on 2018/1/30.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoleStateMemento.h"

@interface RoleStateCaretaker : NSObject

@property(strong,nonatomic)RoleStateMemento * memento;

- (void)keepState:(RoleStateMemento *)memento;

@end
