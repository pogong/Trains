//
//  ViewController.m
//  MementoDesignpattern
//
//  Created by 张三弓 on 2018/1/30.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import "ViewController.h"
#import "PlayRole.h"
#import "RoleStateMemento.h"
#import "RoleStateCaretaker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    PlayRole * role = [[PlayRole alloc]init];
    
    RoleStateCaretaker * caretaker = [RoleStateCaretaker new];
    [caretaker keepState:role.saveState];
    
    [role stateDisplay];
    
    [role fight];
    
    [role stateDisplay];
    
    [role recoveryState:caretaker.memento];
    
    [role stateDisplay];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
