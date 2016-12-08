//
//  RACCommandController.m
//  FRP_OC
//
//  Created by ST on 16/12/8.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "RACCommandController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface RACCommandController ()

@property (nonatomic, strong) RACCommand *command;
@end

@implementation RACCommandController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 使用注意点：RACCommand中的block不能返回一个nil的信号
    // 创建命令类
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        
        // block什么时候调用:当执行这个命令类的时候就会调用
        NSLog(@"执行命令 %@",input);
        // block有什么作用:描述下如何处理事件，网络请求
        
        // 返回数据 1
        
        
        // 为什么RACCommand必须返回信号，处理事件的时候，肯定会有数据产生，产生的数据就通过返回的信号发出。
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            // block作用：发送处理事件的信号
            // block调用：当信号被订阅的时候才会调用
            [subscriber sendNext:@"信号发出的内容"];
            
            return nil;
        }];
    }];
    //    _command = command;
    // executionSignals:信号源，包含事件处理的所有信号。
    // executionSignals: signalOfSignals,什么是信号中的信号，就是信号发出的数据也是信号类
    
    // 如果想要接收信号源的信号内容，必须保证命令类不会被销毁
    [command.executionSignals subscribeNext:^(id x) {
        // x -> 信号
        [x subscribeNext:^(id x) {
            
             NSLog(@"%s --------- %@", __FUNCTION__, x);
        }];
    }];
    
    // 2.执行命令,调用signalBlock
    [command execute:@222222];
    
    [self signalOfSignals];
    
}

- (void)signalOfSignals
{
    // 创建一个信号中的信号
    RACSubject *signalOfSignals = [RACSubject subject];
    
    // 信号
    RACSubject *signal = [RACSubject subject];
    
    
    // 先订阅
    [signalOfSignals subscribeNext:^(id x) {
        
        // x -> 信号
        
        NSLog(@"%s %@", __FUNCTION__, x);
        
        [x subscribeNext:^(id x) {
             NSLog(@"%s %@", __FUNCTION__, x);
        }];
    }];
    
    // 在发送
    
    [signalOfSignals sendNext:signal];
    
    [signal sendNext:@11111];
    
    
}

@end
