//
//  ViewController.m
//  AbstractFactoryDesignpattern
//
//  Created by 张三弓 on 2018/1/31.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import "ViewController.h"
#import "IFactory.h"
#import "AccessFactory.h"
#import "IUser.h"
#import "User.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    IFactory * factory = [AccessFactory new];
    IUser * iuser = [factory createUser];
    
    [iuser insertUser:[User new]];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
