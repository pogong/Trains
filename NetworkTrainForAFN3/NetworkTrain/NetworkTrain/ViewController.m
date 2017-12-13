//
//  ViewController.m
//  NetworkTrain
//
//  Created by Shendou on 2017/9/28.
//  Copyright © 2017年 Shendou. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworkingController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
	UITableView * _tableView;
	NSArray * _dataArr;
}
@end

@implementation ViewController

- (nullable id)xxccAct{
    NSLog(@"123");
    return @"";
}
    
- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.title = @"PGRACTrain";
	
	self.automaticallyAdjustsScrollViewInsets = NO;
	self.edgesForExtendedLayout = UIRectEdgeAll;
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	_dataArr = @[@"AFNetworking"];
	
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
        AFNetworkingController * vc = [[AFNetworkingController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
	}else if (indexPath.row == 1){

	}else if (indexPath.row == 2){
        
	}
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
	
}

@end
