//
//  SocketByCController.m
//  SocketTrain
//
//  Created by Shendou on 2017/11/7.
//  Copyright © 2017年 Shendou. All rights reserved.
//

#import "SocketByCController.h"

#import <sys/types.h>
#import <sys/socket.h>
#import <netinet/in.h>
#import <arpa/inet.h>

@interface SocketByCController ()
{
    int _clientSocket;
}
@end

@implementation SocketByCController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //1 创建
    _clientSocket = socket(AF_INET, SOCK_STREAM, 0);
    
    //2 连接
    struct sockaddr_in sAddr={0};
    
    sAddr.sin_len=sizeof(sAddr);
    
    sAddr.sin_family = AF_INET;
    
    const char * server_ip = "127.0.0.1";
    inet_aton(server_ip, &sAddr.sin_addr);
    
    short server_port = 6969;
    sAddr.sin_port= htons(server_port);
    
    int result = connect(_clientSocket, (struct sockaddr *)&sAddr, sizeof(sAddr));
    if (result == 0) {
        NSLog(@"Socket 连接成功");
    }else{
        NSLog(@"Socket 连接失败");
    }
    
}

- (IBAction)sendAct:(UIButton *)sender {
    [self.view endEditing:YES];
    if (_sendWordsTF.text.length <= 0) {
        return;
    }
    const char *send_Message = [_sendWordsTF.text UTF8String];
    
    send(_clientSocket,send_Message,strlen(send_Message)+1,0);
}

- (IBAction)receiveAct:(UIButton *)sender {
    
    uint8_t recv_Message[1024] = {0};
    ssize_t receiveCount = recv(_clientSocket, recv_Message, sizeof(recv_Message), 0);//阻塞
    NSData * receiveData = [NSData dataWithBytes:recv_Message length:receiveCount];
    NSLog(@"receive message %@",[[NSString alloc]initWithData:receiveData encoding:NSUTF8StringEncoding]);
}

- (IBAction)closeAct:(UIButton *)sender {
    close(_clientSocket);
}

@end

/*
 zc note:
 
 int socket(int, int, int)函数:
 参数1:addressFamily
 参数2:socket的类型
 参数3:协议类型,参数通常设置为0,由参数2决定:SOCK_STREAM==>TCP协议(IPPROTO_TCP),SOCK_DGRAM==>UDP协议(IPPROTO_UDP)
 
 int connect(int, const struct sockaddr *, socklen_t)函数:
 参数1:socket描述符
 参数2:目标地址结构体(addressFamily,ip,port)
 参数3:目标地址结构体的大小
 
 ssize_t send(int, const void *, size_t, int)
 参数1:socket描述符
 参数2:发送的字符串
 参数3:发送的字符串长度
 参数4:[一般都填0,下面内容是查到的,我不知道是什么意思]
 0==>与write()无异
 MSG_DONTROUTE:告诉内核，目标主机在本地网络，不用查路由表
 MSG_DONTWAIT:将单个I／O操作设置为非阻塞模式
 MSG_OOB:指明发送的是带外信息
 
 ssize_t recv(int, void *, size_t, int)
 参数1:socket描述符
 参数2:字节数组
 参数3:字节数组的长度
 参数4:[一般都填0,下面内容是查到的,我不知道是什么意思]
 0==>常规操作,阻塞
 MSG_DONTWAIT:将单个I／O操作设置为非阻塞模式
 MSG_OOB:指明发送的是带外信息
 MSG_PEEK:可以查看可读的信息，在接收数据后不会将这些数据丢失
 MSG_WAITALL:通知内核直到读到请求的数据字节数时，才返回。
 
 int close(int)
 参数1:socket描述符
 
 Mac本地监听6969端口:nc -lk 6969
 
 */

