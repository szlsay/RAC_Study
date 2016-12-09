//
//  RACSignalSubscriptionController.m
//  FRP_OC
//
//  Created by ST on 16/12/8.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "RACSignalSubscriptionController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface RACSignalSubscriptionController ()

@end

@implementation RACSignalSubscriptionController
#pragma mark - --- 1.init 生命周期 ---

#pragma mark - --- 2.delegate 视图委托 ---

#pragma mark - --- 3.event response 事件相应 ---

#if 0
-(RACSignal *)signInSignal {
    // part 1:[RACSignal createSignal]来获得signal
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [self.signInService
         signInWithUsername:self.usernameTextField.text
         password:self.passwordTextField.text
         complete:^(BOOL success) {
             
             // part 3: 进入didSubscribe，通过[subscriber sendNext:]来执行next block
             [subscriber sendNext:@(success)];
             [subscriber sendCompleted];
         }];
        return nil;
    }];
}

// part 2 : [signal subscribeNext:]来获得subscriber，然后进行subscription
[[self signInSignal] subscribeNext:^(id x) {
    NSLog(@"Sign in result: %@", x); 
}];
#endif
#pragma mark - --- 4.private methods 私有方法 ---

#pragma mark - --- 5.setters 属性 ---

#pragma mark - --- 6.getters 属性 —--

@end
