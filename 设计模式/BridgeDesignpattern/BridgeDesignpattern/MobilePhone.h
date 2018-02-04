//
//  MobilePhone.h
//  BridgeDesignpattern
//
//  Created by 张三弓 on 2018/1/30.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MobilePhoneApp.h"

@interface MobilePhone : NSObject

- (void)installApp:(MobilePhoneApp *)app;
- (void)runApp;

@end
