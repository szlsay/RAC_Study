//
//  RACSubjectTwoController.m
//  FRP_OC
//
//  Created by ST on 16/12/7.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "RACSubjectTwoController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface RACSubjectTwoController ()

@end

@implementation RACSubjectTwoController

#pragma mark - --- 1.init 生命周期 ---
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
}
#pragma mark - --- 2.delegate 视图委托 ---

#pragma mark - --- 3.event response 事件相应 ---

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 通知ViewController做事情
    if (self.subject) {
        
        [self.subject sendNext:nil];
        [self.subject sendNext:self];
    }
}

#pragma mark - --- 4.private methods 私有方法 ---

#pragma mark - --- 5.setters 属性 ---

#pragma mark - --- 6.getters 属性 —--

@end
