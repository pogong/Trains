//
//  AFNetworkingController.m
//  NetworkTrain
//
//  Created by Shendou on 2017/9/28.
//  Copyright © 2017年 Shendou. All rights reserved.
//

#import "AFNetworkingController.h"
#import <AFNetworking.h>

@interface AFNetworkingController ()

@end

@implementation AFNetworkingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	self.view.backgroundColor = [UIColor whiteColor];
    
	AFHTTPSessionManager * manger = [AFHTTPSessionManager manager];
	manger.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
	[manger GET:@"http://c.3g.163.com/photo/api/list/0096/4GJ60096.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * responseData) {
		NSLog(@"responseData-----%@",responseData);
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		
	}];
}

@end
