//
//  RACMacroController.m
//  FRP_OC
//
//  Created by ST on 16/12/8.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "RACMacroController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface RACMacroController ()

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UITextField *textField;

@property (nonatomic, strong) RACSignal *signal;

@end

@implementation RACMacroController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.label];
    [self.view addSubview:self.textField];
    
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //    [_textField.rac_textSignal subscribeNext:^(id x) {
    //
    //        self.label.text = x;
    //    }];
    //
    // RAC:把一个对象的某个属性绑定一个信号,只要发出信号,就会把信号的内容给对象的属性赋值
    // 给label的text属性绑定了文本框改变的信号
    RAC(self.label,text) = _textField.rac_textSignal;
    
    // KVO
    // RACObserveL:快速的监听某个对象的某个属性改变
    // 返回的是一个信号,对象的某个属性改变的信号
    [RACObserve(self.view, center) subscribeNext:^(id x) {
        NSLog(@"%@",x);
    }];
    
    // 3.循环引用问题
    // 把self转换成一个弱指针
    @weakify(self);
    
    // 创建信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        @strongify(self);
        
        NSLog(@"%@",self.view);
        
        return nil;
    }];
    
    _signal = signal;
    
    // 4.元祖
    // 快速包装一个元组
    // 把包装的类型放在宏的参数里面,就会自动包装
    RACTuple *tuple = RACTuplePack(@1,@3);
    
    //    NSLog(@"%@",tuple);
    
    // 快速的解析一个元组对象
    // 等会的右边表示解析哪个元组
    // 宏的参数:表示解析成什么
    RACTupleUnpack_(NSNumber *num1,NSNumber *num2) = tuple;
    NSLog(@"%@ %@",num1,num2);
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 120, 100, 44)];
        [_label setBackgroundColor:[UIColor greenColor]];
    }
    return _label;
}

- (UITextField *)textField
{
    if (!_textField) {
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 200, 100, 44)];
        [_textField setBackgroundColor:[UIColor redColor]];
    }
    return _textField;
}
@end
