//
//  RACSubjectController.m
//  FRP_OC
//
//  Created by ST on 16/12/7.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "RACSubjectController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "RACSubjectTwoController.h"

@interface RACSubjectController ()

@end

@implementation RACSubjectController

#pragma mark - --- 1.init 生命周期 ---

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    // RACSubject:信号提供者
    // 1.创建信号
    RACSubject *subject = [RACSubject subject];
    
    // 2.订阅信号
    [subject subscribeNext:^(id x) {
        // block:当有数据发出的时候就会调用
        // block:处理数据
        NSLog(@"%@",x);
    }];
    
    // 3.发送信号
    [subject sendNext:@1];
    
    // 开发中，使用这个RACSubject代替代理
    
    //

}

#pragma mark - --- 2.delegate 视图委托 ---

#pragma mark - --- 3.event response 事件相应 ---

#pragma mark - --- 4.private methods 私有方法 ---
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    RACSubjectTwoController *twoVC = [RACSubjectTwoController new];
    twoVC.subject = [RACSubject subject];
    [twoVC.subject subscribeNext:^(id x) {
         NSLog(@"%s %@", __FUNCTION__, @"通知RACSubjectController");
         NSLog(@"%s %@", __FUNCTION__, x);
    }];
    [self.navigationController pushViewController:twoVC animated:YES];
}
#pragma mark - --- 5.setters 属性 ---

#pragma mark - --- 6.getters 属性 —--

@end
