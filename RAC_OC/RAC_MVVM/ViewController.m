//
//  ViewController.m
//  RAC_MVVM
//
//  Created by ST on 16/11/17.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "LoginViewModel.h"
@interface ViewController ()
/** 1. */
@property(nonatomic, strong)LoginViewModel *loginVM;
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@end

@implementation ViewController

#pragma mark - --- 1.init 生命周期 ---

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // MVVM:
    // VM:视图模型----处理展示的业务逻辑
    // 每一个控制器都对应一个VM模型
    
    
    
    RACSignal *loginEnableSignal = [RACSignal combineLatest:@[self.accountField.rac_textSignal, self.pwdField.rac_textSignal] reduce:^id(NSString *account, NSString *pwd){
        return @(account.length && pwd.length);
    }];
    // 设置按钮是否能点击
    RAC(self.loginBtn, enabled) = loginEnableSignal;
    
    // 创建登录命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        // block调用：执行命令就会调用
        // block作用：事件处理
        // 发送登录请求
        NSLog(@"发送登录请求");
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
                // 发送数据
                [subscriber sendNext:@"发送登录的数据"];
                [subscriber sendCompleted]; // 一定要记得写
            });
            
            return nil;
        }];
    }];
    // 获取命令中的信号源
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    // 监听命令执行过程
    [[command.executing skip:1] subscribeNext:^(id x) { // 跳过第一步（没有执行这步）
        if ([x boolValue] == YES) {
            NSLog(@"--正在执行");
            // 显示蒙版
        }else { //执行完成
            NSLog(@"执行完成");
            // 取消蒙版
        }
    }];
    
    // 监听登录按钮点击
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        NSLog(@"点击登录按钮");
        // 处理登录事件
        [command execute:nil];
        
    }];
}

#pragma mark - --- 2.delegate 视图委托 ---

#pragma mark - --- 3.event response 事件相应 ---

#pragma mark - --- 4.private methods 私有方法 ---

#pragma mark - --- 5.setters 属性 ---

#pragma mark - --- 6.getters 属性 —--

- (LoginViewModel *)loginVM
{
    if (!_loginVM) {
        _loginVM = [[LoginViewModel alloc]init];
    }
    return _loginVM;
}

@end
