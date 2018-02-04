//
//  PlayRole.h
//  MementoDesignpattern
//
//  Created by 张三弓 on 2018/1/30.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RoleStateMemento.h"

@interface PlayRole : NSObject

@property(assign,nonatomic)int vit;
@property(assign,nonatomic)int def;
@property(assign,nonatomic)int atk;

- (RoleStateMemento *)saveState;

- (void)fight;

- (void)recoveryState:(RoleStateMemento *)state;

-(void)stateDisplay;

@end
