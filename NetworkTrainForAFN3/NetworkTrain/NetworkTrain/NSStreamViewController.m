//
//  NSStreamViewController.m
//  NetworkTrain
//
//  Created by 张三弓 on 2017/10/15.
//  Copyright © 2017年 Shendou. All rights reserved.
//

#import "NSStreamViewController.h"

//待跟进

@interface NSStreamViewController ()<NSStreamDelegate>{
    NSInputStream *_inputStream;
    NSOutputStream *_outputSteam;
}

@end

@implementation NSStreamViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)connectToServer:(id)sender {
    //ios里实现sokcet的连接，使用C语言
    
    // 1.与服务器通过三次握手建立连接
    NSString *host = @"127.0.0.1";
    int port = 12345;
    
    // 2.定义输入输出流
    CFReadStreamRef readStream;
    CFWriteStreamRef writeStream;
    
    // 3.分配输入输出流的内存空间
    CFStreamCreatePairWithSocketToHost(NULL, (__bridge CFStringRef)host, port, &readStream, &writeStream);//读写 双管齐下
    
    // 4.把C语言的输入输出流转成OC对象
    _inputStream = (__bridge NSInputStream *)readStream;
    _outputSteam = (__bridge NSOutputStream *)(writeStream);
    
    // 5.设置代理,监听数据接收的状态
    _outputSteam.delegate = self;//NSStreamDelegate
    _inputStream.delegate = self;//NSStreamDelegate
    
    // 把输入输入流添加到主运行循环(RunLoop)
    // 主运行循环是监听网络状态
    [_outputSteam scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [_inputStream scheduleInRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    
    // 6.打开输入输出流
    [_inputStream open];
    [_outputSteam open];
}


//代理的回调是在主线程
//NSLog(@"%@",[NSThread currentThread]);
-(void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode{
    
    //    NSStreamEventOpenCompleted = 1UL << 0,
    //    NSStreamEventHasBytesAvailable = 1UL << 1,
    //    NSStreamEventHasSpaceAvailable = 1UL << 2,
    //    NSStreamEventErrorOccurred = 1UL << 3,
    //    NSStreamEventEndEncountered = 1UL << 4
    
    switch (eventCode) {
        case NSStreamEventOpenCompleted:
            NSLog(@"%@",aStream);
            NSLog(@"成功连接建立，形成输入输出流的传输通道");
            break;
            
        case NSStreamEventHasBytesAvailable:
            NSLog(@"有数据可读");
            [self readData];
            break;
            
        case NSStreamEventHasSpaceAvailable:
            NSLog(@"可以发送数据");
            break;
            
        case NSStreamEventErrorOccurred:
            NSLog(@"有错误发生，连接失败");
            break;
            
        case NSStreamEventEndEncountered:
            NSLog(@"正常的断开连接");
            //把输入输入流关闭，而还要从主运行循环移除
            [_inputStream close];
            [_outputSteam close];
            [_inputStream removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
            [_outputSteam removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
            
            break;
        default:
            break;
    }
    
}

- (IBAction)loginBtnClick:(id)sender {
    //发送登录请求 使用输出流
    
    //拼接登录的指令 iam:zhangsan
    NSString *loginStr = @"iam:zhangsan";
    
    //uint8_t * 字符数组
    NSData *data = [loginStr dataUsingEncoding:NSUTF8StringEncoding];
    [_outputSteam write:data.bytes maxLength:data.length];
    
}


#pragma mark 读取服务器返回的数据
-(void)readData{
    
    //定义缓冲区 这个缓冲区只能存储1024字节
    uint8_t buf[1024];
    
    // 读取数据
    // len为从服务器读取到的实际字节数
    NSInteger len = [_inputStream read:buf maxLength:sizeof(buf)];
    
    // 把缓冲区里的实现字节数转成字符串
    NSString *receiverStr = [[NSString alloc] initWithBytes:buf length:len encoding:NSUTF8StringEncoding];
    NSLog(@"%@",receiverStr);
    
}
@end
