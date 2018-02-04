//
//  MobilePhone.m
//  BridgeDesignpattern
//
//  Created by 张三弓 on 2018/1/30.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import "MobilePhone.h"

@implementation MobilePhone
{
    MobilePhoneApp * _app;
}
- (void)installApp:(MobilePhoneApp *)app{
    _app = app;
}

- (void)runApp{
    [_app run];
}

@end
