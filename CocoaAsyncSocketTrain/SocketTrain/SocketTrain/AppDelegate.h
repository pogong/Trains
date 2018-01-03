//
//  AppDelegate.h
//  SocketTrain
//
//  Created by 张三弓 on 2017/12/3.
//  Copyright © 2017年 张三弓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

// Using SecureTransport for TLS
//
// We know:
// - how many bytes are available on the socket
// - how many encrypted bytes are sitting in the sslPreBuffer
// - how many decypted bytes are sitting in the sslContext
//
// But we do NOT know:
// - how many encypted bytes are sitting in the sslContext
//
// So we play the regular game of using an upper bound instead.
//----------------------------------------------------------------------------
// Figure out if there is any data available to be read
//
// socketFDBytesAvailable        <- Number of encrypted bytes we haven't read from the bsd socket ==>加密的
// [sslPreBuffer availableBytes] <- Number of encrypted bytes we've buffered from bsd socket ==>加密的
// sslInternalBufSize            <- Number of decrypted bytes SecureTransport has buffered ==>解密的
//
// We call the variable "estimated" because we don't know how many decrypted bytes we'll get
// from the encrypted bytes in the sslPreBuffer.
// However, we do know this is an upper bound on the estimation.

