//
//  ViewController.h
//  HttpsTrain
//
//  Created by Shendou on 2017/10/12.
//  Copyright © 2017年 Shendou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end

//+(void)js2GetDataFromUrl:(NSString*)url param:(NSDictionary *)param postPrama:(NSDictionary *)postPrama timeOut:(NSInteger)timeOut callback:(void (^)(NSDictionary* dicResponse))callback
//{
//	NSHTTPCookieStorage *cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
//	NSArray *cookies = [cookieJar cookiesForURL:[NSURL URLWithString:url]];
//	for (NSHTTPCookie *obj in cookies) {
//		[cookieJar deleteCookie:obj];
//	}
//	AFHTTPSessionManager * any = [[AFHTTPSessionManager alloc]init];
//	any.requestSerializer.timeoutInterval = timeOut;
//	
//	NSLog(@"zc-1-cz");
//	NSLog(@"%@",url);
//	NSLog(@"param---%@",param);
//	
//	NSURL *testUrl = [NSURL URLWithString:url];
//	if (testUrl == nil) {
//		url = [self js_enCodeUrl:url];
//	}
//	
//	NSLog(@"zc-2-cz");
//	
//	for (NSString * key in param.allKeys) {
//		[any.requestSerializer setValue:param[key] forHTTPHeaderField:key];
//	}
//	
//	any.responseSerializer = [AFHTTPResponseSerializer serializer];
//	
//	if (postPrama.count) {
//		[any POST:url parameters:postPrama success:^(NSURLSessionDataTask *task, id responseObject) {
//			NSLog(@"jsHttp post success");
//			NSString * resBody = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//			NSHTTPURLResponse * conver = (NSHTTPURLResponse *)task.response;
//			NSDictionary * resHeaders = conver.allHeaderFields;
//			NSDictionary * dic = @{
//								   @"networkError":@(NO),
//								   @"statusCode":@(conver.statusCode),
//								   @"resHeaders":resHeaders.count?resHeaders:@"",
//								   @"resBody":resBody.length?resBody:@""
//								   };
//			callback(dic);
//		} failure:^(NSURLSessionDataTask *task, NSError *error) {
//			
//			if (error.code == 302) {
//				return;
//			}
//			
//			NSLog(@"jsHttp post failure");
//			
//			NSHTTPURLResponse * conver = (NSHTTPURLResponse *)task.response;
//			if (conver) {
//				NSDictionary * resHeaders = conver.allHeaderFields;
//				NSDictionary * dic = @{
//									   @"networkError":@(NO),
//									   @"statusCode":@(conver.statusCode),
//									   @"resHeaders":resHeaders.count?resHeaders:@"",
//									   @"resBody":@""
//									   };
//				callback(dic);
//			}else{
//				NSDictionary * dic = @{
//									   @"networkError":@(YES),
//									   @"statusCode":@(error.code),
//									   @"resHeaders":@"",
//									   @"resBody":@""
//									   };
//				callback(dic);
//			}
//		}];
//	}else{
//		
//		[any GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
//			NSLog(@"jsHttp get success");
//			NSLog(@"%@",url);
//			NSString * resBody = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
//			NSHTTPURLResponse * conver = (NSHTTPURLResponse *)task.response;
//			NSDictionary * resHeaders = conver.allHeaderFields;
//			NSDictionary * dic = @{
//								   @"networkError":@(NO),
//								   @"statusCode":@(conver.statusCode),
//								   @"resHeaders":resHeaders.count?resHeaders:@"",
//								   @"resBody":resBody.length?resBody:@""
//								   };
//			callback(dic);
//		} failure:^(NSURLSessionDataTask *task, NSError *error) {
//			
//			if (error.code == 302) {
//				return;
//			}
//			
//			NSLog(@"jsHttp get failure");
//			NSHTTPURLResponse * conver = (NSHTTPURLResponse *)task.response;
//			if (conver) {
//				NSDictionary * resHeaders = conver.allHeaderFields;
//				NSDictionary * dic = @{
//									   @"networkError":@(NO),
//									   @"statusCode":@(conver.statusCode),
//									   @"resHeaders":resHeaders.count?resHeaders:@"",
//									   @"resBody":@""
//									   };
//				callback(dic);
//			}else{
//				NSDictionary * dic = @{
//									   @"networkError":@(YES),
//									   @"statusCode":@(error.code),
//									   @"resHeaders":@"",
//									   @"resBody":@""
//									   };
//				callback(dic);
//			}
//		}];
//	}
//	
//	[any setTaskWillPerformHTTPRedirectionBlock:^NSURLRequest *(NSURLSession *session, NSURLSessionTask *task, NSURLResponse *response, NSURLRequest *request) {
//		NSLog(@"jsHttp redirect");
//		NSHTTPURLResponse * conver = (NSHTTPURLResponse *)response;
//		NSDictionary * resHeaders = conver.allHeaderFields;
//		NSDictionary * dic = @{
//							   @"networkError":@(NO),
//							   @"statusCode":@(conver.statusCode),
//							   @"resHeaders":resHeaders.count?resHeaders:@"",
//							   @"resBody":@""
//							   };
//		callback(dic);
//		return nil;
//	}];
//}
