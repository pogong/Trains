//
//  ViewController.m
//  CommandDesignpattern
//
//  Created by 张三弓 on 2018/1/30.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import "ViewController.h"
#import "BakeMuttonCommand.h"
#import "BakeChickenWingCommand.h"
#import "Waiter.h"
#import "Barbecuer.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    Barbecuer * barbecuer = [Barbecuer new];
    
    BakeMuttonCommand * command1 = [[BakeMuttonCommand alloc]initWithBarbecuer:barbecuer];
    BakeChickenWingCommand * command2 = [[BakeChickenWingCommand alloc]initWithBarbecuer:barbecuer];
    
    Waiter * waiter = [[Waiter alloc]init];
    [waiter addCommand:command1];
    [waiter addCommand:command2];
    
    [waiter notify];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
