//
//  ViewController.m
//  BridgeDesignpattern
//
//  Created by 张三弓 on 2018/1/30.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import "ViewController.h"
#import "MobilePhone.h"
#import "MobilePhoneApp1.h"
#import "MobilePhoneApp2.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    MobilePhone * phone = [MobilePhone new];
    
    [phone installApp:[MobilePhoneApp1 new]];
    [phone runApp];
    
    [phone installApp:[MobilePhoneApp2 new]];
    [phone runApp];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
