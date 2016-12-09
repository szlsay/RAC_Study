//
//  RACCommonController.m
//  FRP_OC
//
//  Created by ST on 16/12/8.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "RACCommonController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface RACRedView : UIView
/** 1. */
@property(nonatomic, strong)UIButton *button;
@end

@implementation RACRedView

#pragma mark - --- 1.init 生命周期 ---

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.button];
    }
    return self;
}

#pragma mark - --- 2.delegate 视图委托 ---

#pragma mark - --- 3.event response 事件相应 ---
- (void)btnClick:(UIButton *)sender
{
    NSLog(@"点击了红色view中的按钮");
    
    [self changeColor:self.backgroundColor];
}

- (void)changeColor:(UIColor *)color{

}

#pragma mark - --- 4.private methods 私有方法 ---

#pragma mark - --- 5.setters 属性 ---

#pragma mark - --- 6.getters 属性 —--

- (UIButton *)button
{
    if (!_button) {
        _button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 150, 30)];
        [_button setBackgroundColor:[UIColor redColor]];
        [_button setTitle:@"I am a button" forState:UIControlStateNormal];
        [_button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _button;
}

@end


@interface RACCommonController ()<UIAlertViewDelegate>
@property (strong, nonatomic) UIButton *button;

@property (nonatomic, assign) int age;
@property (strong, nonatomic) RACRedView *redView;
@property (strong, nonatomic) UITextField *textField;

@end

@implementation RACCommonController

#pragma mark - --- 1.init 生命周期 ---
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.button];
    [self.view addSubview:self.redView];
    [self.view addSubview:self.textField];
    
    // 创建热门商品的信号
    RACSignal *signalA = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 处理信号
        NSLog(@"请求热门商品");
        
        // 发送数据
        [subscriber sendNext:@"热门商品"];
        
        return nil;
    }];
    
    // 创建热门商品的信号
    RACSignal *signalB = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 处理信号
        NSLog(@"请求最新商品");
        
        // 发送数据
        [subscriber sendNext:@"最新商品"];
        
        return nil;
    }];
    
    // RAC:就可以判断两个信号有没有都发出内容
    // SignalsFromArray:监听哪些信号的发出
    // 当signals数组中的所有信号都发送sendNext就会触发方法调用者(self)的selector
    // 注意:selector方法的参数不能乱写,有几个信号就对应几个参数
    // 不需要主动订阅signalA,signalB,方法内部会自动订阅
    [self rac_liftSelector:@selector(updateUIWithHot:new:) withSignalsFromArray:@[signalA,signalB]];
    
    [self textChange];
    [self event];
    [self notification];
    [self KVO];
    [self delegate];
}
#pragma mark - --- 2.delegate 视图委托 ---

#pragma mark - --- 3.event response 事件相应 ---
- (void)updateUIWithHot:(NSString *)hot
{
    
}
// 更新UI
- (void)updateUIWithHot:(NSString *)hot new:(NSString *)new
{
     NSLog(@"更新UI %s %@ %@", __FUNCTION__, hot, new);
    
}

- (void)textChange
{
    // 5.监听文本框文字改变
    // 获取文本框文字改变的信号
    [self.textField.rac_textSignal subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    [[self.textField rac_signalForControlEvents:UIControlEventEditingChanged] subscribeNext:^(id x){
        NSLog(@"change");
    }];
}

- (void)notification
{
    // 4.监听通知
    // 只要发出这个通知,又会转换成一个信号
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(id x) {
        NSLog(@"弹出键盘");
    }];
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"postData" object:nil] subscribeNext:^(NSNotification *notification) {
        NSLog(@"%@", notification.name);
        NSLog(@"%@", notification.object);
         NSLog(@"%s %@", __FUNCTION__, notification.userInfo);
    }];
}

- (void)event
{
    // 3.监听事件
    // 只要产生UIControlEventTouchUpInside就会转换成信号
    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        NSLog(@"点击了按钮");
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"postData" object:self userInfo:@{@"name":@"ios"}];
        
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [[tap rac_gestureSignal] subscribeNext:^(id x) {
        NSLog(@"tap");
    }];
    [self.view addGestureRecognizer:tap];
}

- (void)KVO
{
    // 2.KVO
    // 监听哪个对象的属性改变
    // 方法调用者:就是被监听的对象
    // KeyPath:监听的属性
    
    // 把监听到内容转换成信号
    [[self rac_valuesForKeyPath:@"age" observer:nil] subscribeNext:^(id x) {
        // block:只要属性改变就会调用,并且把改变的值传递给你
        NSLog(@"%@",x);
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.age++;
}

// 1.RAC替换代理
- (void)delegate
{
    // 1.RAC替换代理
    // RAC:判断下一个方法有没有调用,如果调用了就会自动发送一个信号给你
    
    // 只要self调用viewDidLoad就会转换成一个信号
    // 监听_redView有没有调用btnClick:,如果调用了就会转换成信号
    [[_redView rac_signalForSelector:@selector(btnClick:)] subscribeNext:^(id x) {
         NSLog(@"控制器知道,点击了红色的view %s %@", __FUNCTION__, x);
    }];
    
    [[_redView rac_signalForSelector:@selector(changeColor:)] subscribeNext:^(id x) {
        NSLog(@"控制器知道颜色 %s %@", __FUNCTION__, x);
    }];
    
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Title" message:@"message" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"ok", nil];
    [alertView show];
    
    [[self rac_signalForSelector:@selector(alertView:clickedButtonAtIndex:) fromProtocol:@protocol(UIAlertViewDelegate)] subscribeNext:^(RACTuple *tuple) {
        NSLog(@"%@",tuple.first);
        NSLog(@"%@",tuple.second);
        NSLog(@"%@",tuple.third);
    }];
    
    [[alertView rac_buttonClickedSignal] subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
}
#pragma mark - --- 4.private methods 私有方法 ---

#pragma mark - --- 5.setters 属性 ---

#pragma mark - --- 6.getters 属性 —--

- (UIButton *)button
{
    if (!_button) {
        _button = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, 100, 30)];
        [_button setTitle:@"Button" forState:UIControlStateNormal];
        [_button setBackgroundColor:[UIColor greenColor]];
    }
    return _button;
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(100, 100, 100, 30)];
        [_textField setBackgroundColor:[UIColor yellowColor]];
    }
    return _textField;
}

- (RACRedView *)redView
{
    if (!_redView) {
        _redView = [[RACRedView alloc]initWithFrame:CGRectMake(100, 200, 200, 200)];
        [_redView setBackgroundColor:[UIColor grayColor]];
    }
    return _redView;
}





@end

