//
//  InputStreamController.m
//  StreamTrain
//
//  Created by Shendou on 2017/12/7.
//  Copyright © 2017年 Shendou. All rights reserved.
//

#import "InputStreamController.h"

@interface InputStreamController ()<NSStreamDelegate>
{
    NSMutableData * _appData;
}
@end

@implementation InputStreamController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    _appData = [NSMutableData data];
    
    NSString * path = [[NSBundle mainBundle]pathForResource:@"on_show" ofType:@"png"];
    NSInputStream * inputStream = [[NSInputStream alloc]initWithFileAtPath:path];
    inputStream.delegate = self;
    [inputStream scheduleInRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    [inputStream open];
    
}

/*
 NSStreamEventNone = 0,
 NSStreamEventOpenCompleted = 1UL << 0,
 NSStreamEventHasBytesAvailable = 1UL << 1,
 NSStreamEventHasSpaceAvailable = 1UL << 2,
 NSStreamEventErrorOccurred = 1UL << 3,
 NSStreamEventEndEncountered = 1UL << 4
 */
- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode{
    switch (eventCode) {
        case NSStreamEventOpenCompleted:{
            NSLog(@"zc know NSStreamEventOpenCompleted");
        }break;
        case NSStreamEventHasBytesAvailable:{
            NSLog(@"zc know NSStreamEventHasBytesAvailable");
            uint8_t buf[1024];
            NSInputStream * inputStream = (NSInputStream *)aStream;
            NSInteger len = [inputStream read:buf maxLength:1024];
            if (len) {
                [_appData appendBytes:buf length:len];
            }else {
                NSLog(@"zc know no buffer!");
            }
        }break;
        case NSStreamEventHasSpaceAvailable:{
            
        }break;
        case NSStreamEventErrorOccurred:{
            NSLog(@"zc know NSStreamEventErrorOccurred");
        }break;
        case NSStreamEventEndEncountered:{
            NSLog(@"zc know NSStreamEventEndEncountered");
            NSString * libPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) firstObject];
            NSLog(@"%@",libPath);
            [_appData writeToFile:[NSString stringWithFormat:@"%@/zc.png",libPath] atomically:YES];
            [aStream close];
            [aStream removeFromRunLoop:[NSRunLoop currentRunLoop]
                              forMode:NSDefaultRunLoopMode];
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
