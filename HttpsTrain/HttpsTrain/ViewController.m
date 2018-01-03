//
//  ViewController.m
//  HttpsTrain
//
//  Created by Shendou on 2017/10/12.
//  Copyright © 2017年 Shendou. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

	[self getAct];
	
}

- (AFSecurityPolicy*)customSecurityPolicy
{
	// /先导入证书
	NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"cer"];//证书的路径
	NSData *certData = [NSData dataWithContentsOfFile:cerPath];
	
	// AFSSLPinningModeCertificate 使用证书验证模式
	AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
	
	securityPolicy.allowInvalidCertificates = YES;
	
	securityPolicy.validatesDomainName = NO;
	
	securityPolicy.pinnedCertificates = [NSSet setWithObject:certData];
	
	return securityPolicy;
}

- (AFSecurityPolicy*)zc_customSecurityPolicy
{
	/*
	 1.SSLPinningMode 模式:默认==>AFSSLPinningModeNone
	 AFSSLPinningModeNone==>不用AFN进行验证,交由系统处理
	 AFSSLPinningModePublicKey==>用本地的证书的公钥进行验证
	 AFSSLPinningModeCertificate==>用本地的证书进行验证
	 */
	AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];

	//2.allowInvalidCertificates 是否允许自签名:默认==>NO
	securityPolicy.allowInvalidCertificates = NO;
	
	//3.validatesDomainName 是否验证域名:默认==>YES
	securityPolicy.validatesDomainName = NO;
	
	//4.pinnedCertificates 本地导入的证书:默认==>app包内所有的.cer全会被添加进来
	NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"cer"];//证书的路径
	NSData *certData = [NSData dataWithContentsOfFile:cerPath];
	securityPolicy.pinnedCertificates = [NSSet setWithObject:certData];
	
	/*
	 5.validatesCertificateChain AFN3.0已经废弃,验证整个证书链,这里的验证是二进制级别的比对,不是系统级别的层层解开证书签名+比对hash值 默认==>YES
	 validatesCertificateChain=YES的时候,app包内必须导入所有证书链上的证书,才会验证成功
	 */
	
	return securityPolicy;
}

- (void)getAct
{
	// 1.获得请求管理者
	AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
	// 2.申明返回的结果是text/html类型
	mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
	
	// 加上这行代码，https ssl 验证。
	[mgr setSecurityPolicy:[self customSecurityPolicy]];

	[mgr GET:@"https://127.0.0.1/zc.json" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
		NSLog(@"zc succ");
	} failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
		NSLog(@"zc fail");
	}];
}

- (void)getAct1{
	NSURLSessionDataTask * jsonTask1 = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"https://127.0.0.1/zc.json"] completionHandler:^(NSData *data,
																																												 NSURLResponse *response,
																																												 NSError *error) {
		NSString * any = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
		NSLog(@"---");
		
	}];
	[jsonTask1 resume];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}


@end
