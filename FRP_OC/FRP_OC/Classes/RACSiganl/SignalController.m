//
//  SignalController.m
//  FRP_OC
//
//  Created by ST on 16/12/7.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "SignalController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface SignalController ()

@end

@implementation SignalController

#pragma mark - --- 1.init 生命周期 ---

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 核心：信号类
    // 信号类作用：只要有数据改变，就会把数据包装成一个信号，传递出去。
    // 只要有数据改变，就会有信号发出。
    // 数据发出，并不是信号类发出。
    
    // 1.创建信号 createSignal:didSubscribe(block)
    // RACDisposable:取消订阅
    // RACSubscriber:发送数据
    
    // createSignal方法:
    // 1.创建RACDynamicSignal
    // 2.把didSubscribe保存到RACDynamicSignal
    
    RACSignal *siganl = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // block调用时刻:当信号被订阅的时候就会调用
        // block作用:描述当前信号哪些数据需要发送
        //       _subscriber = subscriber;
        // 发送数据
        NSLog(@"调用了didSubscribe");
        // 通常：传递数据出去
        [subscriber sendNext:@1];
        // 调用订阅者的nextBlock
        
        // 如果信号，想要被取消，就必须返回一个RACDisposable
        return [RACDisposable disposableWithBlock:^{
            
            // 信号什么时候被取消：1.自动取消，当一个信号的订阅者被销毁的时候，就会自动取消订阅 2.主动取消
            // block调用时刻:一旦一个信号，被取消订阅的时候就会调用
            // block作用：当信号取消订阅，用于清空一些资源
            NSLog(@"取消订阅");
        }];
    }];
    
    // subscribeNext:
    // 1.创建订阅者
    // 2.把nextBlock保存到订阅者里面
    // 订阅信号
    // 只要订阅信号，就会返回一个取消订阅信号的类
    RACDisposable *disposable = [siganl subscribeNext:^(id x) {
        
        // block:只要信号内部发送数据，就会调用这个block
        NSLog(@"%@",x);
    }];
    
    // 取消订阅
    //    [disposable dispose];
    
    // RACSignal使用步骤:
    // 1.创建信号
    
    // 2.订阅信号
    
    // RACSignal底层实现:
    // 1.当一个信号被订阅，创建订阅者，并且把nextBlock保存到订阅者里面
    // 2.[RACDynamicSignal subscribe:RACSubscriber]
    // 3.调用RACDynamicSignal的didSubscribe
    // 4.[subscriber sendNext:@1];
    // 5.拿到订阅者的nextBlock调用
}

#pragma mark - --- 2.delegate 视图委托 ---

#pragma mark - --- 3.event response 事件相应 ---

#pragma mark - --- 4.private methods 私有方法 ---

#pragma mark - --- 5.setters 属性 ---

#pragma mark - --- 6.getters 属性 —--

@end
