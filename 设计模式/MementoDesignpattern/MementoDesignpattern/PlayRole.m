//
//  PlayRole.m
//  MementoDesignpattern
//
//  Created by 张三弓 on 2018/1/30.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import "PlayRole.h"

@implementation PlayRole
- (instancetype)init{
    self = [super init];
    if (self) {
        _atk = 100;
        _def = 100;
        _vit = 100;
    }
    return self;
}

- (RoleStateMemento *)saveState{
    RoleStateMemento * memento = [RoleStateMemento new];
    memento.atk = self.atk;
    memento.def = self.def;
    memento.vit = self.vit;
    return memento;
}

- (void)fight{
    NSLog(@"fight");
    _atk = 50;
    _vit = 50;
    _def = 50;
}

- (void)recoveryState:(RoleStateMemento *)state{
    NSLog(@"recoveryState");
    self.atk = state.atk;
    self.def = state.def;
    self.vit = state.vit;
}

-(void)stateDisplay{
    NSLog(@"self.atk==>%d,self.def==>%d,self.vit==>%d",self.atk,self.def,self.vit);
}

@end
