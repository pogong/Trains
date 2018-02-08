//
//  ViewController.m
//  FactoryMethodDesignpattern
//
//  Created by 张三弓 on 2018/1/31.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import "ViewController.h"
#import "UndergraduateFactory.h"
#import "LeiFeng.h"
#import "VolunterFactory.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    IFactory * factory = [VolunterFactory new];
    LeiFeng * lf = [factory createLeifeng];
    
    [lf doSomething1];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
