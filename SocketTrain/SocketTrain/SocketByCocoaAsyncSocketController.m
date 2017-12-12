//
//  SocketByCocoaAsyncSocketController.m
//  SocketTrain
//
//  Created by Shendou on 2017/11/7.
//  Copyright © 2017年 Shendou. All rights reserved.
//

#import "SocketByCocoaAsyncSocketController.h"
#import "GCDAsyncSocket.h"

@interface SocketByCocoaAsyncSocketController ()<GCDAsyncSocketDelegate>
{
    GCDAsyncSocket * _socket;
}
@end

@implementation SocketByCocoaAsyncSocketController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    BOOL result = [_socket connectToHost:@"127.0.0.1" onPort:6969 error:nil];
    if (result) {
        NSLog(@"成功");
    }else{
        
    }
    
    [_socket readDataWithTimeout:-1 tag:110];
}

- (void)xxhh{
    
}

- (IBAction)sendAct:(UIButton *)sender{
    NSData * data = [@"zc send" dataUsingEncoding:NSUTF8StringEncoding];
    [_socket writeData:data withTimeout:-1 tag:110];;
}

- (IBAction)receiveAct:(UIButton *)sender{
    //[_socket readDataWithTimeout:-1 tag:110];
}

- (IBAction)closeAct:(UIButton *)sender{
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

@end
