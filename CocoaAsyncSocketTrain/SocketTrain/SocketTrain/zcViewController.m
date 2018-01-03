//
//  zcViewController.m
//  SocketTrain
//
//  Created by Shendou on 2017/11/10.
//  Copyright © 2017年 Shendou. All rights reserved.
//

#import "zcViewController.h"
#import <Security/Security.h>

@interface zcViewController ()

@end

@implementation zcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)xxhh{
//
//    //1
//    if ((currentRead == nil) || (flags & kReadsPaused))
//    {
//
//        return;
//    }
//    
//    BOOL hasBytesAvailable = NO;
//    unsigned long estimatedBytesAvailable = 0;
//    
//    //2
//    if ([self usingCFStreamForTLS])
//    {
//
//    else
//    {
//
//    }
//    
//    //3
//    if ((hasBytesAvailable == NO) && ([preBuffer availableBytes] == 0))
//    {
//        return;//zc read:调用doReadData真实的读取收到的数据后,还会调用一次doReadData,但因为socket内没有收到数据,所以止步于此
//    }
//    
//    //4
//    if (flags & kStartingReadTLS)
//    {
//        return;
//    }
//}

@end
