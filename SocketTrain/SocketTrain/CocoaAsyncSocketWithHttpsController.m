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
    
    _socket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:dispatch_get_main_queue()];
    BOOL result = [_socket connectToHost:@"127.0.0.1" onPort:80 error:nil];
    if (result) {
        NSLog(@"连接成功");
    }else{
        NSLog(@"连接失败");
    }
    
    [_socket readDataWithTimeout:-1 tag:110];
}

- (IBAction)sendAct:(UIButton *)sender{
    NSString * reqest = @"GET /zc.json HTTP/1.1\r\n"
    "Host: 127.0.0.1\r\n"
    "Connection: close\r\n\r\n";
    NSData * data = [reqest dataUsingEncoding:NSUTF8StringEncoding];
    [_socket writeData:data withTimeout:-1 tag:110];;
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

- (void)doTLSConnect:(GCDAsyncSocket *)sock {
    //HTTPS
    NSMutableDictionary *sslSettings = [[NSMutableDictionary alloc] init];
    NSData *pkcs12data = [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"xxx.xxxxxxx.com" ofType:@"p12"]];//已经支持https的网站会有CA证书，给服务器要一个导出的p12格式证书
    CFDataRef inPKCS12Data = (CFDataRef)CFBridgingRetain(pkcs12data);
    CFStringRef password = CFSTR("xxxxxx");//这里填写上面p12文件的密码
    const void *keys[] = { kSecImportExportPassphrase };
    const void *values[] = { password };
    CFDictionaryRef options = CFDictionaryCreate(NULL, keys, values, 1, NULL, NULL);
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    
    OSStatus securityError = SecPKCS12Import(inPKCS12Data, options, &items);
    CFRelease(options);
    CFRelease(password);
    
    if (securityError == errSecSuccess) {
        NSLog(@"Success opening p12 certificate.");
    }
    
    CFDictionaryRef identityDict = CFArrayGetValueAtIndex(items, 0);
    SecIdentityRef myIdent = (SecIdentityRef)CFDictionaryGetValue(identityDict, kSecImportItemIdentity);
    SecIdentityRef  certArray[1] = { myIdent };
    CFArrayRef myCerts = CFArrayCreate(NULL, (void *)certArray, 1, NULL);
    [sslSettings setObject:(id)CFBridgingRelease(myCerts) forKey:(NSString *)kCFStreamSSLCertificates];
    [sslSettings setObject:@"api.pandaworker.com" forKey:(NSString *)kCFStreamSSLPeerName];
    [sock startTLS:sslSettings];//最后调用一下GCDAsyncSocket这个方法进行ssl设置就Ok了
}

@end
