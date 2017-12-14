//
//  CocoaAsyncSocketWithHttpsController.m
//  SocketTrain
//
//  Created by Shendou on 2017/12/11.
//  Copyright © 2017年 张三弓. All rights reserved.
//

#import "CocoaAsyncSocketWithHttpsController.h"
#import "GCDAsyncSocket.h"

@interface CocoaAsyncSocketWithHttpsController ()<GCDAsyncSocketDelegate>
{
    GCDAsyncSocket * _socket;
}
@end

@implementation CocoaAsyncSocketWithHttpsController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self startGCDAsyncSocketOnTLS];
    
}

- (void)startGCDAsyncSocketOnTLS{
    _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    if(![_socket connectToHost:@"127.0.0.1" onPort:443 withTimeout:30 error:nil]){
        NSLog(@"连接失败");
    }else{
        NSMutableDictionary *settings = [[NSMutableDictionary alloc] init];
        
        [settings setObject:[NSNumber numberWithBool:YES]
                     forKey:GCDAsyncSocketManuallyEvaluateTrust];
        
        [_socket startTLS:settings];
        
        [_socket readDataWithTimeout:-1 tag:110];
        
    }
}

- (IBAction)sendAct:(UIButton *)sender{
    NSString * reqest = @"GET /zc.json HTTP/1.1\r\n"
    "Host: 127.0.0.1\r\n"
    "Connection: close\r\n\r\n";
    NSData * data = [reqest dataUsingEncoding:NSUTF8StringEncoding];
    [_socket writeData:data withTimeout:-1 tag:110];
}

- (void)receiveAct:(UIButton *)sender{
    [_socket readDataWithTimeout:-1 tag:110];
}

- (void)closeAct:(UIButton *)sender{
    [_socket disconnect];
}

#pragma mark - GCDAsyncSocketDelegate
//连接成功调用
- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port
{
    NSLog(@"连接成功,host:%@,port:%d",host,port);
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
    NSLog(@"写的回调,tag:%ld",tag);
    //判断是否成功发送，如果没收到响应，则说明连接断了，则想办法重连
}

- (void)socket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *msg = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"收到消息：%@",msg);
    
    //-1永远监听，不超时，但是只收一次消息，所以每次接受到消息还得调用一次
    [_socket readDataWithTimeout:-1 tag:110];
}

- (void)socket:(GCDAsyncSocket *)sock didReceiveTrust:(SecTrustRef)trust completionHandler:(void (^)(BOOL shouldTrustPeer))completionHandler {
    NSLog(@"didReceiveTrust");
    
    //server certificate
    SecCertificateRef serverCertificate = SecTrustGetCertificateAtIndex(trust, 0);
    CFDataRef serverCertificateData = SecCertificateCopyData(serverCertificate);
    
    const UInt8* const serverData = CFDataGetBytePtr(serverCertificateData);
    const CFIndex serverDataSize = CFDataGetLength(serverCertificateData);
    NSData* cert1 = [NSData dataWithBytes:serverData length:(NSUInteger)serverDataSize];
    
    
    //local certificate
    NSString *localCertFilePath = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"cer"];
    NSData *localCertData = [NSData dataWithContentsOfFile:localCertFilePath];
    CFDataRef myCertData = (__bridge CFDataRef)localCertData;
    
    
    const UInt8* const localData = CFDataGetBytePtr(myCertData);
    const CFIndex localDataSize = CFDataGetLength(myCertData);
    NSData* cert2 = [NSData dataWithBytes:localData length:(NSUInteger)localDataSize];
    
    
    if (cert1 == nil || cert2 == nil) {
        NSLog(@"Certificate NULL");
        completionHandler(NO);
        return;
    }
    
    
    const BOOL equal = [cert1 isEqualToData:cert2];
    
    if (equal) {
        
        NSLog(@"Certificate match");
        completionHandler(YES);
        
    }else{
        
        NSLog(@"Certificate not match");
        completionHandler(NO);
    }
}

@end
