//
//  ActMixViewController.m
//  NativeMixRN
//
//  Created by 张三弓 on 2018/1/27.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import "ActMixViewController.h"
#import <React/RCTRootView.h>

@interface ActMixViewController ()

@end

@implementation ActMixViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"RN界面";
    NSURL *jsCodeLocation=[NSURL URLWithString:@"http://localhost:8081/index.ios.bundle?platform=ios&dev=true"];
    RCTRootView *rootView = [[RCTRootView alloc] initWithBundleURL:jsCodeLocation
                                                        moduleName:@"ActMixComponent"
                                                 initialProperties:nil
                                                     launchOptions:nil];
    self.view=rootView;
}

@end
