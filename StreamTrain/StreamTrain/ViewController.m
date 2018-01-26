//
//  ViewController.m
//  StreamTrain
//
//  Created by Shendou on 2017/12/7.
//  Copyright © 2017年 Shendou. All rights reserved.
//

#import "ViewController.h"
#import "InputStreamController.h"
#import "OutputStreamController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
    NSArray * _dataArr;
}

@end

@implementation ViewController

/*
 Of particular importance are the events that indicate when bytes are available to read from an input stream and when an output stream signals that it’s ready to accept bytes.
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"NSURLSessionTrain";
//    NSStreamSOCKSProxyConfigurationKey
//    NSStreamSOCKSProxyConfigurationKey
//    NSStreamSOCKSProxyNameKey
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeAll;
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArr = @[@"InputStreamController",@"OutputStreamController",@"MultiDownloadController",@"ResumeMultiDownloadController"];
    
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
        InputStreamController * vc = [[InputStreamController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 1){
        OutputStreamController * vc = [[OutputStreamController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 2){
        
    }else if (indexPath.row == 3){
        
    }else if (indexPath.row == 4){
        
    }
}

@end
