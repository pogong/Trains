//
//  ViewController.m
//  DNS-Anti-Spoofing-Train
//
//  Created by Shendou on 2018/1/16.
//  Copyright © 2018年 Shendou. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)btnPress:(UIButton *)sender {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://maps.googleapis.com/maps/api/geocode/json?address=San%20Francisco,%20CA&sensor=false"]];
    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.jianshu.com/p/688141d260ec"]];
    
    NSMutableURLRequest * mu = [request mutableCopy];
    mu.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
    
    [NSURLConnection sendAsynchronousRequest:[mu copy]
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                               if (connectionError) {
                                   NSLog(@"%@",connectionError.localizedDescription);
                               }else{
                                   NSLog(@"succ");
                               }
                           }];
}

@end
