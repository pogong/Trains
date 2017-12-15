//
//  OutputStreamController.m
//  StreamTrain
//
//  Created by Shendou on 2017/12/7.
//  Copyright © 2017年 Shendou. All rights reserved.
//

#import "OutputStreamController.h"

@interface OutputStreamController ()<NSStreamDelegate>
{
    NSData * _old_date;
    NSInteger _doneIndex;
}
@end

@implementation OutputStreamController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSStream
    
    UIImage * image = [UIImage imageNamed:@"on_show"];
    
    _old_date = UIImagePNGRepresentation(image);
    
    NSOutputStream * outputStream = [[NSOutputStream alloc]initToMemory];
    outputStream.delegate = self;
    [outputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [outputStream open];
    
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode{
    switch (eventCode) {
        case NSStreamEventOpenCompleted:{
            NSLog(@"zc know NSStreamEventOpenCompleted");
        }break;
        case NSStreamEventHasBytesAvailable:{

        }break;
        case NSStreamEventHasSpaceAvailable:{
            NSLog(@"zc know NSStreamEventHasSpaceAvailable");
            NSOutputStream * outputStream = (NSOutputStream *)aStream;
            
            uint8_t *readBytes = (uint8_t *)_old_date.bytes;
            readBytes += _doneIndex;
            int data_len = [_old_date length];
            unsigned int len = ((data_len - _doneIndex >= 1024) ?
                                1024 : (data_len-_doneIndex));
            uint8_t buf[len];
            (void)memcpy(buf, readBytes, len);
            len = [outputStream write:(const uint8_t *)buf maxLength:len];
            _doneIndex += len;
        }break;
        case NSStreamEventErrorOccurred:{
            NSLog(@"zc know NSStreamEventErrorOccurred");
        }break;
        case NSStreamEventEndEncountered:{
            NSOutputStream * outputStream = (NSOutputStream *)aStream;
            NSData * outData = [outputStream propertyForKey:NSStreamDataWrittenToMemoryStreamKey];
            UIImage * image = [UIImage imageWithData:outData];
            
            UIImageView * iv = [[UIImageView alloc]init];
            iv.frame = CGRectMake(64.0, 64.0, 100.0, 100.0);
            [self.view addSubview:iv];
            iv.image = image;
            
            [outputStream close];
            [outputStream removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
            
            
        }break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
