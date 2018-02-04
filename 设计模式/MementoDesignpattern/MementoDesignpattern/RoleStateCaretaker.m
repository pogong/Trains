//
//  RoleStateCaretaker.m
//  MementoDesignpattern
//
//  Created by 张三弓 on 2018/1/30.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import "RoleStateCaretaker.h"

@implementation RoleStateCaretaker

- (void)keepState:(RoleStateMemento *)memento{
    _memento = memento;
}

@end
