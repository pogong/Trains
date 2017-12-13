//
//  ViewController.m
//  SocketTrain
//
//  Created by Shendou on 2017/11/7.
//  Copyright © 2017年 Shendou. All rights reserved.
//

#import "ViewController.h"
#import "SocketByCController.h"
#import "SocketByCocoaAsyncSocketController.h"
#import "CocoaAsyncSocketWithHttpController.h"
#import "CocoaAsyncSocketWithHttpsController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    NSArray * _dataArr;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Socket";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArr = @[@"SocketByCController",@"SocketByCocoaAsyncSocketController",@"CocoaAsyncSocketWithHttpController",@"CocoaAsyncSocketWithHttpsController"];
    
    CGRect frame = self.view.bounds;
    frame.size.height -= 64;
    frame.origin.y = 64;
    
    _tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStyleGrouped];
    _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell = [_tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        SocketByCController * vc = [[SocketByCController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        SocketByCocoaAsyncSocketController * vc = [[SocketByCocoaAsyncSocketController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2){
        CocoaAsyncSocketWithHttpController * vc = [[CocoaAsyncSocketWithHttpController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 3){
        CocoaAsyncSocketWithHttpsController * vc = [[CocoaAsyncSocketWithHttpsController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 4){
        
    }
}

@end


