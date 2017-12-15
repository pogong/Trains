//
//  ViewController.h
//  SocketTrain
//
//  Created by 张三弓 on 2017/12/3.
//  Copyright © 2017年 张三弓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@end
//
////普通数读取
//- (void)zc_doReadData_nomal
//{
//    LogTrace();
//    
//    NSLog(@"zc func call-->doReadData");
//    
//    if ((currentRead == nil) || (flags & kReadsPaused))
//    {
//        LogVerbose(@"No currentRead or kReadsPaused");
//        
//        {
//            if (socketFDBytesAvailable > 0)
//            {
//                //zc read:防止监听重复开火
//                [self suspendReadSource];
//            }
//        }
//        
//        return;
//    }
//    
//    BOOL hasBytesAvailable = NO;
//    unsigned long estimatedBytesAvailable = 0;
//    
//    {
//        estimatedBytesAvailable = socketFDBytesAvailable;
//        
//        hasBytesAvailable = (estimatedBytesAvailable > 0);
//    }
//    
//    if ((hasBytesAvailable == NO) && ([preBuffer availableBytes] == 0))
//    {
//        LogVerbose(@"No data available to read...");
//        NSLog(@"zc func call -- socket与preBuffer都没有可读数据-----------packet stay");
//        [self resumeReadSource];
//        return;
//    }
//    
//    BOOL done        = NO;  // Completed read operation
//    NSError *error   = nil; // Error occurred
//    
//    NSUInteger totalBytesReadForCurrentRead = 0;
//    
//    //
//    // STEP 1 - READ FROM PREBUFFER
//    //
//    
//    if ([preBuffer availableBytes] > 0)
//    {
//        
//        NSUInteger bytesToCopy;
//        
//        if (currentRead->term != nil)
//        {
//            bytesToCopy = [currentRead readLengthForTermWithPreBuffer:preBuffer found:&done];//zc read:读取到一个明确的界限
//        }
//        else
//        {
//            bytesToCopy = [currentRead readLengthForNonTermWithHint:[preBuffer availableBytes]];
//        }
//        
//        [currentRead ensureCapacityForAdditionalDataOfLength:bytesToCopy];
//        
//        uint8_t *buffer = (uint8_t *)[currentRead->buffer mutableBytes] + currentRead->startOffset +
//        currentRead->bytesDone;
//        
//        memcpy(buffer, [preBuffer readBuffer], bytesToCopy);
//        NSLog(@"zc func call -- READ FROM PREBUFFER -->currentRead从preBuffer读入%zd个字节",bytesToCopy);
//        [preBuffer didRead:bytesToCopy];
//        
//        LogVerbose(@"copied(%lu) preBufferLength(%zu)", (unsigned long)bytesToCopy, [preBuffer availableBytes]);
//        
//        currentRead->bytesDone += bytesToCopy;
//        totalBytesReadForCurrentRead += bytesToCopy;
//        
//        if (currentRead->readLength > 0)
//        {
//            done = (currentRead->bytesDone == currentRead->readLength);
//        }
//        else if (currentRead->term != nil)
//        {
//            if (!done && currentRead->maxLength > 0)
//            {
//                if (currentRead->bytesDone >= currentRead->maxLength)
//                {
//                    error = [self readMaxedOutError];
//                }
//            }
//        }
//        else
//        {
//            done = ((currentRead->maxLength > 0) && (currentRead->bytesDone == currentRead->maxLength));
//        }
//        
//    }
//    
//    //
//    // STEP 2 - READ FROM SOCKET
//    //
//    
//    BOOL socketEOF = (flags & kSocketHasReadEOF) ? YES : NO;  // Nothing more to read via socket (end of file)
//    BOOL waiting   = !done && !error && !socketEOF && !hasBytesAvailable; // Ran out of data, waiting for more
//    
//    if (!done && !error && !socketEOF && hasBytesAvailable)
//    {
//        NSAssert(([preBuffer availableBytes] == 0), @"Invalid logic");
//        
//        BOOL readIntoPreBuffer = NO;
//        uint8_t *buffer = NULL;
//        size_t bytesRead = 0;
//        
//        {
//            NSUInteger bytesToRead;
//            
//            if (currentRead->term != nil)//zc read:外围不提供缓存块,而且是读边界,缓存长度为0;所以肯定要写入socket->preBuffer
//            {
//                bytesToRead = [currentRead readLengthForTermWithHint:estimatedBytesAvailable
//                                                     shouldPreBuffer:&readIntoPreBuffer];//什么时候readIntoPreBuffer=NO
//            }
//            else
//            {
//                bytesToRead = [currentRead readLengthForNonTermWithHint:estimatedBytesAvailable];
//            }
//            
//            if (bytesToRead > SIZE_MAX) { // NSUInteger may be bigger than size_t (read param 3)
//                bytesToRead = SIZE_MAX;
//            }
//            
//            if (readIntoPreBuffer)
//            {
//                [preBuffer ensureCapacityForWrite:bytesToRead];
//                
//                buffer = [preBuffer writeBuffer];
//            }
//            else
//            {
//                [currentRead ensureCapacityForAdditionalDataOfLength:bytesToRead];
//                
//                buffer = (uint8_t *)[currentRead->buffer mutableBytes]
//                + currentRead->startOffset
//                + currentRead->bytesDone;
//            }
//            
//            int socketFD = (socket4FD != SOCKET_NULL) ? socket4FD : (socket6FD != SOCKET_NULL) ? socket6FD : socketUN;
//            
//            ssize_t result = read(socketFD, buffer, (size_t)bytesToRead);
//            LogVerbose(@"read from socket = %i", (int)result);
//            
//            if (readIntoPreBuffer) {
//                NSLog(@"zc func call -- READ FROM SOCKET -->preBuffer从socket读入%zd个字节",result);
//            }else{
//                NSLog(@"zc func call -- READ FROM SOCKET -->currentRead从socket读入%zd个字节",result);
//            }
//            
//            if (result < 0)//zc read:读取报错 或者 是陷入阻塞
//            {
//                if (errno == EWOULDBLOCK)
//                    waiting = YES;
//                    else
//                        error = [self errnoErrorWithReason:@"Error in read() function"];
//                        
//                        socketFDBytesAvailable = 0;
//                        }
//            else if (result == 0)//zc read:读取结束符
//            {
//                socketEOF = YES;
//                socketFDBytesAvailable = 0;
//            }
//            else                //zc read:读取到正常数据
//            {
//                bytesRead = result;
//                
//                if (bytesRead < bytesToRead)//zc read:bytesRead真正读取到的 bytesToRead预备读取到的
//                {
//                    socketFDBytesAvailable = 0;
//                }
//                else
//                {
//                    if (socketFDBytesAvailable <= bytesRead)
//                        socketFDBytesAvailable = 0;
//                        else
//                            socketFDBytesAvailable -= bytesRead;
//                            }
//                
//                if (socketFDBytesAvailable == 0)//zc read:source监听到来的数据,被全部读完
//                {
//                    waiting = YES;
//                }
//            }
//        }
//        
//        if (bytesRead > 0)
//        {
//            if (currentRead->readLength > 0)
//            {
//                NSAssert(readIntoPreBuffer == NO, @"Invalid logic");
//                
//                currentRead->bytesDone += bytesRead;
//                totalBytesReadForCurrentRead += bytesRead;
//                
//                done = (currentRead->bytesDone == currentRead->readLength);
//            }
//            else if (currentRead->term != nil)
//            {
//                if (readIntoPreBuffer)
//                {
//                    [preBuffer didWrite:bytesRead];
//                    LogVerbose(@"read data into preBuffer - preBuffer.length = %zu", [preBuffer availableBytes]);
//                    NSUInteger bytesToCopy = [currentRead readLengthForTermWithPreBuffer:preBuffer found:&done];
//                    LogVerbose(@"copying %lu bytes from preBuffer", (unsigned long)bytesToCopy);
//                    
//                    [currentRead ensureCapacityForAdditionalDataOfLength:bytesToCopy];
//                    
//                    uint8_t *readBuf = (uint8_t *)[currentRead->buffer mutableBytes] + currentRead->startOffset
//                    + currentRead->bytesDone;
//                    
//                    memcpy(readBuf, [preBuffer readBuffer], bytesToCopy);//zc read:sockect收到44个字节的数据,preBuffer从socket读入44个字节,currentRead从preBuffer读入38个字节
//                    NSLog(@"zc func call -- READ FROM SOCKET -->currentRead从preBuffer读入%zd个字节",bytesToCopy);
//                    
//                    [preBuffer didRead:bytesToCopy];
//                    LogVerbose(@"preBuffer.length = %zu", [preBuffer availableBytes]);
//                    
//                    currentRead->bytesDone += bytesToCopy;
//                    totalBytesReadForCurrentRead += bytesToCopy;
//                    
//                }
//                else
//                {
//                    NSInteger overflow = [currentRead searchForTermAfterPreBuffering:bytesRead];
//                    
//                    if (overflow == 0)
//                    {
//                        currentRead->bytesDone += bytesRead;
//                        totalBytesReadForCurrentRead += bytesRead;
//                        done = YES;
//                    }
//                    else if (overflow > 0)
//                    {
//                        NSInteger underflow = bytesRead - overflow;
//                        
//                        LogVerbose(@"copying %ld overflow bytes into preBuffer", (long)overflow);
//                        [preBuffer ensureCapacityForWrite:overflow];
//                        
//                        uint8_t *overflowBuffer = buffer + underflow;
//                        memcpy([preBuffer writeBuffer], overflowBuffer, overflow);
//                        
//                        [preBuffer didWrite:overflow];
//                        LogVerbose(@"preBuffer.length = %zu", [preBuffer availableBytes]);
//                        
//                        currentRead->bytesDone += underflow;
//                        totalBytesReadForCurrentRead += underflow;
//                        done = YES;
//                    }
//                    else
//                    {
//                        currentRead->bytesDone += bytesRead;
//                        totalBytesReadForCurrentRead += bytesRead;
//                        done = NO;
//                    }
//                }
//                
//                if (!done && currentRead->maxLength > 0)
//                {
//                    if (currentRead->bytesDone >= currentRead->maxLength)
//                    {
//                        error = [self readMaxedOutError];
//                    }
//                }
//            }
//            else
//            {
//                if (readIntoPreBuffer)
//                {
//                    [preBuffer didWrite:bytesRead];
//                    
//                    [currentRead ensureCapacityForAdditionalDataOfLength:bytesRead];
//                    
//                    uint8_t *readBuf = (uint8_t *)[currentRead->buffer mutableBytes] + currentRead->startOffset
//                    + currentRead->bytesDone;
//                    
//                    memcpy(readBuf, [preBuffer readBuffer], bytesRead);
//                    
//                    [preBuffer didRead:bytesRead];
//                    
//                    currentRead->bytesDone += bytesRead;
//                    totalBytesReadForCurrentRead += bytesRead;
//                }
//                else
//                {
//                    currentRead->bytesDone += bytesRead;
//                    totalBytesReadForCurrentRead += bytesRead;
//                }
//                
//                done = YES;
//            }
//            
//        } // if (bytesRead > 0)
//        
//    } // if (!done && !error && !socketEOF && hasBytesAvailable)
//    
//    
//    if (!done && currentRead->readLength == 0 && currentRead->term == nil)
//    {
//        done = (totalBytesReadForCurrentRead > 0);
//    }
//    
//    NSLog(@"zc func call 数据未全部读取完毕,等待source_handler trigger;done->%zd,waiting->%zd",done,waiting);
//    
//    if (done)
//    {
//        [self completeCurrentRead];
//        
//        if (!error && (!socketEOF || [preBuffer availableBytes] > 0))//zc read:读取没有报错 且 (没读到结尾 或者 socket->preBuffer还有数据) 都要继续读取
//        {
//            [self maybeDequeueRead];
//        }
//    }
//    else if (totalBytesReadForCurrentRead > 0)
//    {
//        __strong id theDelegate = delegate;
//        
//        if (delegateQueue && [theDelegate respondsToSelector:@selector(socket:didReadPartialDataOfLength:tag:)])
//        {
//            long theReadTag = currentRead->tag;
//            
//            dispatch_async(delegateQueue, ^{ @autoreleasepool {
//                
//                [theDelegate socket:self didReadPartialDataOfLength:totalBytesReadForCurrentRead tag:theReadTag];
//            }});
//        }
//    }
//    
//    if (error)
//    {
//        [self closeWithError:error];
//    }
//    else if (socketEOF)
//    {
//        [self doReadEOF];
//    }
//    else if (waiting)
//    {
//        [self resumeReadSource];
//    }
//}

