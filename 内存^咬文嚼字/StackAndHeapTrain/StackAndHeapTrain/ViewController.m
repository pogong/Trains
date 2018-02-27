//
//  ViewController.m
//  StackAndHeapTrain
//
//  Created by 张三弓 on 2018/2/27.
//  Copyright © 2018年 张三弓. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(assign,nonatomic)NSObject * obj;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self stackAddressAndHeapAddress];
    
}

//区分 堆上对象的地址 和 栈上指向对象的地址
- (void)stackAddressAndHeapAddress{
    NSObject * obj1 = [[NSObject alloc]init];
    NSLog(@"%p",obj1);//栈上指向对象的地址
    NSLog(@"%p",&obj1);//堆上对象的地址
}

//造坏地址错误
- (void)EXE_BAD_ACCESS_SHOW{
    NSObject * obj1 = [[NSObject alloc]init];
    
    self.obj = obj1;
    
    obj1 = nil;
    /*
     对象在堆上,对象指针在栈上;
     这个置为nil的动作不是直接销毁'堆上的对象',而是'栈上的对象指针'指向'空','堆上的对象'会相应的减少引用计数而已;
     当然'堆上的对象'的引用计数减为0了,也自然会销毁;
     还有不明白的可以看==>方法EXE_BAD_ACCESS_SHOW2
     */
    
    NSLog(@"%@",obj1);
    NSLog(@"%@",self.obj);//assign修饰的属性仍然指向已经'销毁的对象',调用当然是野指针
}

//反例
- (void)EXE_BAD_ACCESS_SHOW2{
    NSObject * obj1 = [[NSObject alloc]init];
    NSObject * obj2 = obj1;
    
    self.obj = obj1;
    
    obj1 = nil;
    
    NSLog(@"%@",obj1);
    NSLog(@"%@",obj2);
    NSLog(@"%@",self.obj);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
