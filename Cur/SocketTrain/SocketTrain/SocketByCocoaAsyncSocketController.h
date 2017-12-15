//
//  SocketByCocoaAsyncSocketController.h
//  SocketTrain
//
//  Created by 张三弓 on 2017/12/3.
//  Copyright © 2017年 张三弓. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SocketByCocoaAsyncSocketController : UIViewController

- (IBAction)sendAct:(UIButton *)sender;
- (IBAction)receiveAct:(UIButton *)sender;
- (IBAction)closeAct:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UITextField *sendWordsTF;

@end
