//
//  ViewController.m
//  CompositeDesignpattern
//
//  Created by 张三弓 on 2018/1/30.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import "ViewController.h"
#import "ConcreteCompany.h"
#import "Department.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    ConcreteCompany * root = [ConcreteCompany new];
    root.title = @"总公司";
    
    ConcreteCompany * sub1 = [ConcreteCompany new];
    sub1.title = @"1公司";
    [root add:sub1];
    
    ConcreteCompany * sub2 = [ConcreteCompany new];
    sub2.title = @"2公司";
    [root add:sub2];
    
    ConcreteCompany * sub3 = [ConcreteCompany new];
    sub3.title = @"3公司";
    [root add:sub3];
    
    //
    Department * sub21 = [Department new];
    sub21.title = @"2公司-1部门";
    [sub2 add:sub21];
    
    Department * sub22 = [Department new];
    sub22.title = @"2公司-2部门";
    [sub2 add:sub22];
    
    [root display];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
