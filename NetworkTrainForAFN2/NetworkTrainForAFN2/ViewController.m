//
//  ViewController.m
//  NetworkTrainForAFN2
//
//  Created by 张三弓 on 2017/10/7.
//  Copyright © 2017年 张三弓. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface ViewController ()<NSURLConnectionDataDelegate>
{
    NSMutableData * _allData;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _allData = [NSMutableData data];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSURL *url = [NSURL URLWithString:@"http://c.3g.163.com/photo/api/list/0096/4GJ60096.json"];
        NSURLRequest * request = [[NSURLRequest alloc]initWithURL:url];
        NSURLConnection * connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
        [connection start];
        NSLog(@"zc NSThread 1 %@",[NSThread currentThread]);
    });

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    manager.operationQueue.maxConcurrentOperationCount = 1;
    
    [manager GET:@"http://cfg.kaikai001.com/user/ios_01.00.00.txt" parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
         }];
    
    NSString *filePath1 = [[NSBundle mainBundle] pathForResource:@"on_show_1.png" ofType:nil];
    NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"on_show_2.png" ofType:nil];
    
    NSData * data1 = [NSData dataWithContentsOfFile:filePath1];
    NSData * data2 = [NSData dataWithContentsOfFile:filePath2];
    
    NSArray * attributeDataArr = @[@{@"data":data1,@"name":@"zc[]",@"fileName":@"on_show_1",@"mimeType":@"image/png"},
                                   @{@"data":data2,@"name":@"zc[]",@"fileName":@"on_show_2",@"mimeType":@"image/png"}];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:@"http://192.168.8.11/upload.php" parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        for (NSDictionary * attributeData in attributeDataArr)
        {
            [formData appendPartWithFileData:attributeData[@"data"]
                                        name:attributeData[@"name"]
                                    fileName:attributeData[@"fileName"]
                                    mimeType:attributeData[@"mimeType"]];
        }
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [_allData appendData:data];
    NSLog(@"zc NSThread 2 %@",[NSThread currentThread]);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    NSError *er = nil;
    id result = [NSJSONSerialization JSONObjectWithData:_allData options:NSJSONReadingMutableContainers error:&er];
    NSLog(@"zc NSThread 3 %@",[NSThread currentThread]);
}


- (void)sendImagesByURLSession
{
    NSString *URLString = @"http://192.168.8.11/upload.php";
    NSString *serverFileName = @"zc[]";
    NSString *filePath1 = [[NSBundle mainBundle] pathForResource:@"on_show_1.png" ofType:nil];
    NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"on_show_2.png" ofType:nil];
    NSArray *filePaths = @[filePath1,filePath2];
    NSDictionary *textDict = @{@"kkk":@"vvv"};
    [self uploadFilesWithURLString:URLString serverFileName:serverFileName filePaths:filePaths textDict:textDict];
}

- (void)uploadFilesWithURLString:(NSString *)URLString serverFileName:(NSString *)serverFileName filePaths:(NSArray *)filePaths textDict:(NSDictionary *)textDict
{
    NSURL *URL = [NSURL URLWithString:URLString];
    
    NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:URL];
    [requestM setValue:@"multipart/form-data; boundary=itcast" forHTTPHeaderField:@"Content-Type"];
    requestM.HTTPMethod = @"POST";
    requestM.HTTPBody = [self getHTTPBodyWithServerFileName:serverFileName filePaths:filePaths textDict:textDict];
    [[[NSURLSession sharedSession] dataTaskWithRequest:requestM completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil && data != nil) {
            NSLog(@"%@",[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
            NSLog(@"44");
        } else {
            NSLog(@"%@",error);
        }
    }] resume];
}

- (NSData *)getHTTPBodyWithServerFileName:(NSString *)serverFileName filePaths:(NSArray *)filePaths textDict:(NSDictionary *)textDict
{
    NSMutableData *dataM = [NSMutableData data];
    
    [filePaths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableString *stringM = [NSMutableString string];
        [stringM appendString:@"--itcast\r\n"];
        [stringM appendFormat:@"Content-Disposition: form-data; name=%@; filename=%@\r\n",serverFileName,[obj lastPathComponent]];
        [stringM appendString:@"Content-Type: image/png\r\n"];
        [stringM appendString:@"\r\n"];
        [dataM appendData:[stringM dataUsingEncoding:NSUTF8StringEncoding]];
        [dataM appendData:[NSData dataWithContentsOfFile:obj]];
        [dataM appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    }];
    
    [textDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSMutableString *stringM = [NSMutableString string];
        [stringM appendString:@"--itcast\r\n"];
        [stringM appendFormat:@"Content-Disposition: form-data; name=%@\r\n",key];
        [stringM appendString:@"\r\n"];
        [stringM appendFormat:@"%@\r\n",obj];
        
        [dataM appendData:[stringM dataUsingEncoding:NSUTF8StringEncoding]];
    }];
    
    [dataM appendData:[@"--itcast--" dataUsingEncoding:NSUTF8StringEncoding]];
    
    return dataM.copy;
}

@end
