//
//  RACMulticastConnectionController.m
//  FRP_OC
//
//  Created by ST on 16/12/8.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "RACMulticastConnectionController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface RACMulticastConnectionController ()

@end

@implementation RACMulticastConnectionController

- (void)viewDidLoad
{
    [super viewDidLoad];
   
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 发送请求，用一个信号内包装，不管有多少个订阅者，只想要发送一次请求
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        // didSubscribeblock中的代码都统称为副作用。
        // 发送请求
        NSLog(@"发送请求");
        
        [subscriber sendNext:@1];
        
        return nil;
    }];
    
    //    // 订阅信号
    [signal subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
    }];
    
    
    [signal subscribeNext:^(id x) {
        
        NSLog(@"%@",x);
    }];
    
    // 1.创建连接类
    RACMulticastConnection *connection = [signal publish];
    
    // 2.订阅信号
    [connection.signal subscribeNext:^(id x) {
        
        NSLog(@"0000%@",x);
    }];
    [connection.signal subscribeNext:^(id x) {
        
        NSLog(@"1111%@",x);
    }];
    [connection.signal subscribeNext:^(id x) {
        
        NSLog(@"2222%@",x);
    }];
    
    // 3.连接：才会把源信号变成热信号
    [connection connect];
}
@end
