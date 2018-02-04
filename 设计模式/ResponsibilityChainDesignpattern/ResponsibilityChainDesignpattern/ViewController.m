//
//  ViewController.m
//  ResponsibilityChainDesignpattern
//
//  Created by 张三弓 on 2018/1/30.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import "ViewController.h"
#import "CommandManager.h"
#import "Majordomo.h"
#import "GeneralManager.h"
#import "Request.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CommandManager * manager1 = [CommandManager new];
    Majordomo * manager2 = [Majordomo new];
    GeneralManager * manager3 = [GeneralManager new];
    
    manager1.upManager = manager2;
    manager2.upManager = manager3;
    
    Request * request1 = [[Request alloc]init];
    request1.type = 1;
    [manager1 hanleRequest:request1];
    
    Request * request2 = [[Request alloc]init];
    request2.type = 3;
    [manager1 hanleRequest:request2];
    
    Request * request3 = [[Request alloc]init];
    request3.type = 5;
    [manager1 hanleRequest:request3];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
