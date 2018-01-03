//
//  TYHSocketManager.m
//  CocoaSyncSocket
//
//  Created by 涂耀辉 on 16/12/28.
//  Copyright © 2016年 涂耀辉. All rights reserved.
//

#import "TYHSocketManager.h"
#import "GCDAsyncSocket.h" // for TCP

//读者需要修改这个Host,改成电脑（服务端IP地址）
static  NSString * Khost = @"192.168.199.114";//@"10.10.100.48";
static const uint16_t Kport = 6969;


@interface TYHSocketManager()<GCDAsyncSocketDelegate>
{
    GCDAsyncSocket *gcdSocket;
}

@end

@implementation TYHSocketManager

+ (instancetype)share
{
    static dispatch_once_t onceToken;
    static TYHSocketManager *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc]init];
        [instance initSocket];
    });
    return instance;
}

- (void)initSocket
{
    gcdSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    
}

#pragma mark - 对外的一些接口

//建立连接
- (BOOL)connect
{
    return  [gcdSocket connectToHost:Khost onPort:Kport error:nil];
}

//断开连接
- (void)disConnect
{
    [gcdSocket disconnect];
}

//字典转为Json字符串
- (NSString *)dictionaryToJson:(NSDictionary *)dic
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}



//发送消息
- (void)sendMsg
{
   
    NSData *data  = [@"你好" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data1  = [@"猪头" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data2  = [@"先生" dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSData *data3  = [@"今天天气好" dataUsingEncoding:NSUTF8StringEncoding];
    NSData *data4  = [@"吃饭了吗" dataUsingEncoding:NSUTF8StringEncoding];

    [self sendData:data type:@"txt" tag:1];
    [self sendData:data1 type:@"txt" tag:2];
    [self sendData:data2 type:@"txt" tag:3];
    
    [self sendData:data3 type:@"txt" tag:4];
    [self sendData:data4 type:@"txt" tag:5];
    
    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"test" ofType:@"jpeg"];
    NSData *data5 = [NSData dataWithContentsOfFile:filePath];
    [self sendData:data5 type:@"img" tag:6];
    
}

- (void)sendData:(NSData *)data type:(NSString *)type tag:(NSInteger)tag
{
    NSUInteger size = data.length;
    
    NSMutableDictionary *headDic = [NSMutableDictionary dictionary];
    [headDic setObject:type forKey:@"type"];
    [headDic setObject:[NSString stringWithFormat:@"%ld",size] forKey:@"size"];
    NSString *jsonStr = [self dictionaryToJson:headDic];

    
    NSData *lengthData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    
    
    NSMutableData *mData = [NSMutableData dataWithData:lengthData];
    //分界
    [mData appendData:[GCDAsyncSocket CRLFData]];
    
    [mData appendData:data];
    
    
    //第二个参数，请求超时时间
    [gcdSocket writeData:mData withTimeout:-1 tag:tag];
    
}

#pragma mark - GCDAsyncSocketDelegate
//连接成功调用
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"连接成功,host:%@,port:%d",host,port);
    
    
    //心跳写在这...
}

//断开连接的时候调用
- (void)socketDidDisconnect:(GCDAsyncSocket *)sock withError:(nullable NSError *)err
{
    NSLog(@"断开连接,host:%@,port:%d",sock.localHost,sock.localPort);
    
    //断线重连写在这...
    
}


//写的回调
- (void)socket:(GCDAsyncSocket*)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"zc func call 包->%zd 写入完成",tag);
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    
    NSString *msg = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"收到消息：%@",msg);
}


@end
