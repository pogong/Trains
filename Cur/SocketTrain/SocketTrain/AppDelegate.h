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

- (void)doReadData
{
    LogTrace();
    
    // This method is called on the socketQueue.
    // It might be called directly, or via the readSource when data is available to be read.
    
    if ((currentRead == nil) || (flags & kReadsPaused))
    {
        LogVerbose(@"No currentRead or kReadsPaused");
        
        // Unable to read at this time
        
        if (flags & kSocketSecure)
        {
            // Here's the situation:
            //
            // We have an established secure connection.
            // There may not be a currentRead, but there might be encrypted data sitting around for us.
            // When the user does get around to issuing a read, that encrypted data will need to be decrypted.
            //
            // So why make the user wait?
            // We might as well get a head start on decrypting some data now.
            //
            // The other reason we do this has to do with detecting a socket disconnection.
            // The SSL/TLS protocol has it's own disconnection handshake.
            // So when a secure socket is closed, a "goodbye" packet comes across the wire.
            // We want to make sure we read the "goodbye" packet so we can properly detect the TCP disconnection.
            
            [self flushSSLBuffers];
        }
        
        if ([self usingCFStreamForTLS])
        {
            // CFReadStream only fires once when there is available data.
            // It won't fire again until we've invoked CFReadStreamRead.
        }
        else
        {
            // If the readSource is firing, we need to pause it
            // or else it will continue to fire over and over again.
            //
            // If the readSource is not firing,
            // we want it to continue monitoring the socket.
            
            if (socketFDBytesAvailable > 0)
            {
                [self suspendReadSource];
            }
        }
        return;
    }
    
    BOOL hasBytesAvailable = NO;
    unsigned long estimatedBytesAvailable = 0;
    
    if ([self usingCFStreamForTLS])
    {
#if TARGET_OS_IPHONE
        
        // Requested CFStream, rather than SecureTransport, for TLS (via GCDAsyncSocketUseCFStreamForTLS)
        
        estimatedBytesAvailable = 0;
        if ((flags & kSecureSocketHasBytesAvailable) && CFReadStreamHasBytesAvailable(readStream))
            hasBytesAvailable = YES;
            else
                hasBytesAvailable = NO;
                
#endif
                }
    else
    {
        estimatedBytesAvailable = socketFDBytesAvailable;
        
        if (flags & kSocketSecure)
        {
            // There are 2 buffers to be aware of here.
            //
            // We are using SecureTransport, a TLS/SSL security layer which sits atop TCP.
            // We issue a read to the SecureTranport API, which in turn issues a read to our SSLReadFunction.
            // Our SSLReadFunction then reads from the BSD socket and returns the encrypted data to SecureTransport.
            // SecureTransport then decrypts the data, and finally returns the decrypted data back to us.
            //
            // The first buffer is one we create.
            // SecureTransport often requests small amounts of data.
            // This has to do with the encypted packets that are coming across the TCP stream.
            // But it's non-optimal to do a bunch of small reads from the BSD socket.
            // So our SSLReadFunction reads all available data from the socket (optimizing the sys call)
            // and may store excess in the sslPreBuffer.
            
            estimatedBytesAvailable += [sslPreBuffer availableBytes];
            
            // The second buffer is within SecureTransport.
            // As mentioned earlier, there are encrypted packets coming across the TCP stream.
            // SecureTransport needs the entire packet to decrypt it.
            // But if the entire packet produces X bytes of decrypted data,
            // and we only asked SecureTransport for X/2 bytes of data,
            // it must store the extra X/2 bytes of decrypted data for the next read.
            //
            // The SSLGetBufferedReadSize function will tell us the size of this internal buffer.
            // From the documentation:
            //
            // "This function does not block or cause any low-level read operations to occur."
            
            size_t sslInternalBufSize = 0;
            SSLGetBufferedReadSize(sslContext, &sslInternalBufSize);
            
            estimatedBytesAvailable += sslInternalBufSize;
        }
        
        hasBytesAvailable = (estimatedBytesAvailable > 0);
    }
    
    if ((hasBytesAvailable == NO) && ([preBuffer availableBytes] == 0))
    {
        LogVerbose(@"No data available to read...");
        
        // No data available to read.
        
        if (![self usingCFStreamForTLS])
        {
            // Need to wait for readSource to fire and notify us of
            // available data in the socket's internal read buffer.
            
            [self resumeReadSource];
        }
        return;//zc read:调用doReadData真实的读取收到的数据后,还会调用一次doReadData,但因为socket内没有收到数据,所以止步于此
    }
    
    if (flags & kStartingReadTLS)
    {
        LogVerbose(@"Waiting for SSL/TLS handshake to complete");
        
        // The readQueue is waiting for SSL/TLS handshake to complete.
        
        if (flags & kStartingWriteTLS)
        {
            if ([self usingSecureTransportForTLS] && lastSSLHandshakeError == errSSLWouldBlock)
            {
                // We are in the process of a SSL Handshake.
                // We were waiting for incoming data which has just arrived.
                
                [self ssl_continueSSLHandshake];
            }
        }
        else
        {
            // We are still waiting for the writeQueue to drain and start the SSL/TLS process.
            // We now know data is available to read.
            
            if (![self usingCFStreamForTLS])
            {
                // Suspend the read source or else it will continue to fire nonstop.
                
                [self suspendReadSource];
            }
        }
        
        return;
    }
    
    BOOL done        = NO;  // Completed read operation
    NSError *error   = nil; // Error occurred
    
    NSUInteger totalBytesReadForCurrentRead = 0;
    
    //zc read:All in all=>先从prebuffer中去读取,如果读完了,当前数据包任务仍未完成,那么再从socket中去读取.
    
    //
    // STEP 1 - READ FROM PREBUFFER
    //
    
    if ([preBuffer availableBytes] > 0)//zc read:缓存内是否有数据
    {
        // There are 3 types of read packets:
        //
        // 1) Read all available data.
        // 2) Read a specific length of data.
        // 3) Read up to a particular terminator.
        
        NSUInteger bytesToCopy;
        
        if (currentRead->term != nil)
        {
            // Read type #3 - read up to a terminator
            
            bytesToCopy = [currentRead readLengthForTermWithPreBuffer:preBuffer found:&done];
        }
        else
        {
            // Read type #1 or #2
            
            bytesToCopy = [currentRead readLengthForNonTermWithHint:[preBuffer availableBytes]];
        }
        
        // Make sure we have enough room in the buffer for our read.
        
        [currentRead ensureCapacityForAdditionalDataOfLength:bytesToCopy];
        
        // Copy bytes from prebuffer into packet buffer
        
        uint8_t *buffer = (uint8_t *)[currentRead->buffer mutableBytes] + currentRead->startOffset +
        currentRead->bytesDone;
        //zc read:把preBuffer内读取出bytesToCopy的长度放入currentRead->buffer
        memcpy(buffer, [preBuffer readBuffer], bytesToCopy);
        
        // Remove the copied bytes from the preBuffer
        [preBuffer didRead:bytesToCopy];
        
        LogVerbose(@"copied(%lu) preBufferLength(%zu)", (unsigned long)bytesToCopy, [preBuffer availableBytes]);
        
        // Update totals
        
        currentRead->bytesDone += bytesToCopy;
        totalBytesReadForCurrentRead += bytesToCopy;
        
        // Check to see if the read operation is done
        
        if (currentRead->readLength > 0)
        {
            // Read type #2 - read a specific length of data
            
            done = (currentRead->bytesDone == currentRead->readLength);
        }
        else if (currentRead->term != nil)
        {
            // Read type #3 - read up to a terminator
            
            // Our 'done' variable was updated via the readLengthForTermWithPreBuffer:found: method
            
            if (!done && currentRead->maxLength > 0)
            {
                // We're not done and there's a set maxLength.
                // Have we reached that maxLength yet?
                
                if (currentRead->bytesDone >= currentRead->maxLength)
                {
                    error = [self readMaxedOutError];
                }
            }
        }
        else
        {
            // Read type #1 - read all available data
            //
            // We're done as soon as
            // - we've read all available data (in prebuffer and socket)
            // - we've read the maxLength of read packet.
            
            done = ((currentRead->maxLength > 0) && (currentRead->bytesDone == currentRead->maxLength));
        }
        
    }
    
    //
    // STEP 2 - READ FROM SOCKET
    //
    
    BOOL socketEOF = (flags & kSocketHasReadEOF) ? YES : NO;  // Nothing more to read via socket (end of file)
    BOOL waiting   = !done && !error && !socketEOF && !hasBytesAvailable; // Ran out of data, waiting for more
    
    if (!done && !error && !socketEOF && hasBytesAvailable)
    {
        NSAssert(([preBuffer availableBytes] == 0), @"Invalid logic");
        
        BOOL readIntoPreBuffer = NO;
        uint8_t *buffer = NULL;
        size_t bytesRead = 0;
        
        if (flags & kSocketSecure)
        {
            if ([self usingCFStreamForTLS])
            {
#if TARGET_OS_IPHONE
                
                // Using CFStream, rather than SecureTransport, for TLS
                
                NSUInteger defaultReadLength = (1024 * 32);
                
                NSUInteger bytesToRead = [currentRead optimalReadLengthWithDefault:defaultReadLength
                                                                   shouldPreBuffer:&readIntoPreBuffer];
                
                // Make sure we have enough room in the buffer for our read.
                //
                // We are either reading directly into the currentRead->buffer,
                // or we're reading into the temporary preBuffer.
                
                if (readIntoPreBuffer)
                {
                    [preBuffer ensureCapacityForWrite:bytesToRead];
                    
                    buffer = [preBuffer writeBuffer];
                }
                else
                {
                    [currentRead ensureCapacityForAdditionalDataOfLength:bytesToRead];
                    
                    buffer = (uint8_t *)[currentRead->buffer mutableBytes]
                    + currentRead->startOffset
                    + currentRead->bytesDone;
                }
                
                // Read data into buffer
                
                CFIndex result = CFReadStreamRead(readStream, buffer, (CFIndex)bytesToRead);
                LogVerbose(@"CFReadStreamRead(): result = %i", (int)result);
                
                if (result < 0)
                {
                    error = (__bridge_transfer NSError *)CFReadStreamCopyError(readStream);
                }
                else if (result == 0)
                {
                    socketEOF = YES;
                }
                else
                {
                    waiting = YES;
                    bytesRead = (size_t)result;
                }
                
                // We only know how many decrypted bytes were read.
                // The actual number of bytes read was likely more due to the overhead of the encryption.
                // So we reset our flag, and rely on the next callback to alert us of more data.
                flags &= ~kSecureSocketHasBytesAvailable;
                
#endif
            }
            else
            {
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
                
                NSUInteger defaultReadLength = (1024 * 32);
                
                if (defaultReadLength < estimatedBytesAvailable) {
                    defaultReadLength = estimatedBytesAvailable + (1024 * 16);
                }
                
                NSUInteger bytesToRead = [currentRead optimalReadLengthWithDefault:defaultReadLength
                                                                   shouldPreBuffer:&readIntoPreBuffer];
                
                if (bytesToRead > SIZE_MAX) { // NSUInteger may be bigger than size_t
                    bytesToRead = SIZE_MAX;
                }
                
                // Make sure we have enough room in the buffer for our read.
                //
                // We are either reading directly into the currentRead->buffer,
                // or we're reading into the temporary preBuffer.
                
                if (readIntoPreBuffer)
                {
                    [preBuffer ensureCapacityForWrite:bytesToRead];
                    
                    buffer = [preBuffer writeBuffer];
                }
                else
                {
                    [currentRead ensureCapacityForAdditionalDataOfLength:bytesToRead];
                    
                    buffer = (uint8_t *)[currentRead->buffer mutableBytes]
                    + currentRead->startOffset
                    + currentRead->bytesDone;
                }
                
                // The documentation from Apple states:
                //
                //     "a read operation might return errSSLWouldBlock,
                //      indicating that less data than requested was actually transferred"
                //
                // However, starting around 10.7, the function will sometimes return noErr,
                // even if it didn't read as much data as requested. So we need to watch out for that.
                
                OSStatus result;
                do
                {
                    void *loop_buffer = buffer + bytesRead;
                    size_t loop_bytesToRead = (size_t)bytesToRead - bytesRead;
                    size_t loop_bytesRead = 0;
                    
                    result = SSLRead(sslContext, loop_buffer, loop_bytesToRead, &loop_bytesRead);
                    LogVerbose(@"read from secure socket = %u", (unsigned)loop_bytesRead);
                    
                    bytesRead += loop_bytesRead;
                    
                } while ((result == noErr) && (bytesRead < bytesToRead));
                
                
                if (result != noErr)
                {
                    if (result == errSSLWouldBlock)
                        waiting = YES;
                        else
                        {
                            if (result == errSSLClosedGraceful || result == errSSLClosedAbort)
                            {
                                // We've reached the end of the stream.
                                // Handle this the same way we would an EOF from the socket.
                                socketEOF = YES;
                                sslErrCode = result;
                            }
                            else
                            {
                                error = [self sslError:result];
                            }
                        }
                    // It's possible that bytesRead > 0, even if the result was errSSLWouldBlock.
                    // This happens when the SSLRead function is able to read some data,
                    // but not the entire amount we requested.
                    
                    if (bytesRead <= 0)
                    {
                        bytesRead = 0;
                    }
                }
                
                // Do not modify socketFDBytesAvailable.
                // It will be updated via the SSLReadFunction().
            }
        }
        else
        {
            // Normal socket operation
            
            NSUInteger bytesToRead;
            
            // There are 3 types of read packets:
            //
            // 1) Read all available data.
            // 2) Read a specific length of data.
            // 3) Read up to a particular terminator.
            //zc read://3种类型的读法，1、全读、2、读取特定长度、3、读取到一个明确的界限(follow hui)
            
            if (currentRead->term != nil)
            {
                // Read type #3 - read up to a terminator
                //zc read:currentRead->buffer够用就不用preBuffer,否则就用preBuffer
                bytesToRead = [currentRead readLengthForTermWithHint:estimatedBytesAvailable
                                                     shouldPreBuffer:&readIntoPreBuffer];
            }
            else
            {
                // Read type #1 or #2
                bytesToRead = [currentRead readLengthForNonTermWithHint:estimatedBytesAvailable];
            }
            
            /*
             [currentRead readLengthForTermWithHint:estimatedBytesAvailable shouldPreBuffer:&readIntoPreBuffer];
             [currentRead readLengthForNonTermWithHint:estimatedBytesAvailable];
             
             这两个方法核心的思路就是，如果当前读取包，长度给明了，则直接流向currentRead，
             如果数据长度不清楚，那么则去判断这一次读取的长度，和currentRead可用空间长度去对比，如果长度比currentRead可用空间小，则流向currentRead，否则先用prebuffer来缓冲.
             */
            
            if (bytesToRead > SIZE_MAX) { // NSUInteger may be bigger than size_t (read param 3)
                bytesToRead = SIZE_MAX;
            }
            
            // Make sure we have enough room in the buffer for our read.
            //
            // We are either reading directly into the currentRead->buffer,
            // or we're reading into the temporary preBuffer.
            
            //zc read:要么写入socket->currentRead->buffer,要么写入socket->preBuffer;socket->currentRead->buffer可能会出现不够的情况,则需要写入socket->preBuffer
            
            if (readIntoPreBuffer)
            {
                [preBuffer ensureCapacityForWrite:bytesToRead];
                
                buffer = [preBuffer writeBuffer];
            }
            else
            {
                //zc read:这
                [currentRead ensureCapacityForAdditionalDataOfLength:bytesToRead];
                
                buffer = (uint8_t *)[currentRead->buffer mutableBytes]
                + currentRead->startOffset
                + currentRead->bytesDone;
            }
            
            // Read data into buffer
            
            int socketFD = (socket4FD != SOCKET_NULL) ? socket4FD : (socket6FD != SOCKET_NULL) ? socket6FD : socketUN;
            
            //zc read4:socket读
            ssize_t result = read(socketFD, buffer, (size_t)bytesToRead);
            LogVerbose(@"read from socket = %i", (int)result);
            
            if (result < 0)//zc read:读取报错 或者 是陷入阻塞
            {
                if (errno == EWOULDBLOCK)
                    waiting = YES;
                    else
                        error = [self errnoErrorWithReason:@"Error in read() function"];
                        
                        socketFDBytesAvailable = 0;
                        }
            else if (result == 0)//zc read:读取结束符
            {
                socketEOF = YES;
                socketFDBytesAvailable = 0;
            }
            else                //zc read:读取到正常数据
            {
                bytesRead = result;
                
                if (bytesRead < bytesToRead)
                {
                    // The read returned less data than requested.
                    // This means socketFDBytesAvailable was a bit off due to timing,
                    // because we read from the socket right when the readSource event was firing.
                    socketFDBytesAvailable = 0;
                }
                else
                {
                    if (socketFDBytesAvailable <= bytesRead)
                        socketFDBytesAvailable = 0;
                        else
                            socketFDBytesAvailable -= bytesRead;
                            }
                
                if (socketFDBytesAvailable == 0)
                {
                    waiting = YES;
                }
            }
        }
        
        if (bytesRead > 0)
        {
            // Check to see if the read operation is done
            
            if (currentRead->readLength > 0)
            {
                // Read type #2 - read a specific length of data
                //
                // Note: We should never be using a prebuffer when we're reading a specific length of data.
                
                NSAssert(readIntoPreBuffer == NO, @"Invalid logic");
                
                currentRead->bytesDone += bytesRead;
                totalBytesReadForCurrentRead += bytesRead;
                
                done = (currentRead->bytesDone == currentRead->readLength);
            }
            else if (currentRead->term != nil)
            {
                // Read type #3 - read up to a terminator
                
                if (readIntoPreBuffer)
                {
                    // We just read a big chunk of data into the preBuffer
                    
                    [preBuffer didWrite:bytesRead];
                    LogVerbose(@"read data into preBuffer - preBuffer.length = %zu", [preBuffer availableBytes]);
                    
                    // Search for the terminating sequence
                    
                    NSUInteger bytesToCopy = [currentRead readLengthForTermWithPreBuffer:preBuffer found:&done];
                    LogVerbose(@"copying %lu bytes from preBuffer", (unsigned long)bytesToCopy);
                    
                    // Ensure there's room on the read packet's buffer
                    
                    [currentRead ensureCapacityForAdditionalDataOfLength:bytesToCopy];
                    
                    // Copy bytes from prebuffer into read buffer
                    
                    uint8_t *readBuf = (uint8_t *)[currentRead->buffer mutableBytes] + currentRead->startOffset
                    + currentRead->bytesDone;
                    
                    memcpy(readBuf, [preBuffer readBuffer], bytesToCopy);
                    
                    // Remove the copied bytes from the prebuffer
                    [preBuffer didRead:bytesToCopy];
                    LogVerbose(@"preBuffer.length = %zu", [preBuffer availableBytes]);
                    
                    // Update totals
                    currentRead->bytesDone += bytesToCopy;
                    totalBytesReadForCurrentRead += bytesToCopy;
                    
                    // Our 'done' variable was updated via the readLengthForTermWithPreBuffer:found: method above
                }
                else
                {
                    // We just read a big chunk of data directly into the packet's buffer.
                    // We need to move any overflow into the prebuffer.
                    
                    NSInteger overflow = [currentRead searchForTermAfterPreBuffering:bytesRead];//zc discover:会溢出的只会发生在读取边界的情况下
                    
                    if (overflow == 0)
                    {
                        // Perfect match!
                        // Every byte we read stays in the read buffer,
                        // and the last byte we read was the last byte of the term.
                        
                        currentRead->bytesDone += bytesRead;
                        totalBytesReadForCurrentRead += bytesRead;
                        done = YES;
                    }
                    else if (overflow > 0)
                    {
                        // The term was found within the data that we read,
                        // and there are extra bytes that extend past the end of the term.
                        // We need to move these excess bytes out of the read packet and into the prebuffer.
                        
                        NSInteger underflow = bytesRead - overflow;
                        
                        // Copy excess data into preBuffer
                        
                        LogVerbose(@"copying %ld overflow bytes into preBuffer", (long)overflow);
                        [preBuffer ensureCapacityForWrite:overflow];
                        
                        uint8_t *overflowBuffer = buffer + underflow;
                        memcpy([preBuffer writeBuffer], overflowBuffer, overflow);
                        
                        [preBuffer didWrite:overflow];
                        LogVerbose(@"preBuffer.length = %zu", [preBuffer availableBytes]);
                        
                        // Note: The completeCurrentRead method will trim the buffer for us.
                        
                        currentRead->bytesDone += underflow;
                        totalBytesReadForCurrentRead += underflow;
                        done = YES;
                    }
                    else
                    {
                        // The term was not found within the data that we read.
                        
                        currentRead->bytesDone += bytesRead;
                        totalBytesReadForCurrentRead += bytesRead;
                        done = NO;
                    }
                }
                
                if (!done && currentRead->maxLength > 0)
                {
                    // We're not done and there's a set maxLength.
                    // Have we reached that maxLength yet?
                    
                    if (currentRead->bytesDone >= currentRead->maxLength)
                    {
                        error = [self readMaxedOutError];
                    }
                }
            }
            else
            {
                // Read type #1 - read all available data
                
                if (readIntoPreBuffer)
                {
                    // We just read a chunk of data into the preBuffer
                    
                    [preBuffer didWrite:bytesRead];
                    
                    // Now copy the data into the read packet.
                    //
                    // Recall that we didn't read directly into the packet's buffer to avoid
                    // over-allocating memory since we had no clue how much data was available to be read.
                    //
                    // Ensure there's room on the read packet's buffer
                    
                    [currentRead ensureCapacityForAdditionalDataOfLength:bytesRead];
                    
                    // Copy bytes from prebuffer into read buffer
                    
                    uint8_t *readBuf = (uint8_t *)[currentRead->buffer mutableBytes] + currentRead->startOffset
                    + currentRead->bytesDone;
                    
                    memcpy(readBuf, [preBuffer readBuffer], bytesRead);
                    
                    // Remove the copied bytes from the prebuffer
                    [preBuffer didRead:bytesRead];
                    
                    // Update totals
                    currentRead->bytesDone += bytesRead;
                    totalBytesReadForCurrentRead += bytesRead;
                }
                else
                {
                    currentRead->bytesDone += bytesRead;
                    totalBytesReadForCurrentRead += bytesRead;
                }
                
                done = YES;
            }
            
        } // if (bytesRead > 0)
        
    } // if (!done && !error && !socketEOF && hasBytesAvailable)
    
    
    if (!done && currentRead->readLength == 0 && currentRead->term == nil)
    {
        // Read type #1 - read all available data
        //
        // We might arrive here if we read data from the prebuffer but not from the socket.
        
        done = (totalBytesReadForCurrentRead > 0);
    }
    
    // Check to see if we're done, or if we've made progress
    
    if (done)
    {
        //zc read:读数据完毕
        [self completeCurrentRead];
        
        if (!error && (!socketEOF || [preBuffer availableBytes] > 0))
        {
            [self maybeDequeueRead];//zc read:maybeDequeueRead内调用有doReadData的操作,但这边的调用不是为继续调用doReadData,而是在maybeDequeueRead内也有关于阅后即停的判断
        }
    }
    else if (totalBytesReadForCurrentRead > 0)
    {
        // We're not done read type #2 or #3 yet, but we have read in some bytes
        
        __strong id theDelegate = delegate;
        
        if (delegateQueue && [theDelegate respondsToSelector:@selector(socket:didReadPartialDataOfLength:tag:)])
        {
            long theReadTag = currentRead->tag;
            
            dispatch_async(delegateQueue, ^{ @autoreleasepool {
                
                [theDelegate socket:self didReadPartialDataOfLength:totalBytesReadForCurrentRead tag:theReadTag];
            }});
        }
    }
    
    // Check for errors
    
    if (error)
    {
        [self closeWithError:error];
    }
    else if (socketEOF)
    {
        [self doReadEOF];
    }
    else if (waiting)
    {
        if (![self usingCFStreamForTLS])
        {
            // Monitor the socket for readability (if we're not already doing so)
            [self resumeReadSource];
        }
    }
    
    // Do not add any code here without first adding return statements in the error cases above.
}
