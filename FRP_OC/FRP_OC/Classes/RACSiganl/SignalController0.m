//
//  SignalController0.m
//  FRP_OC
//
//  Created by ST on 16/12/7.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "SignalController0.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface SignalController0 ()
/** 1. */
@property(nonatomic, strong)UILabel *label;
/** 2. */
@property(nonatomic, strong)UITextField *textField;

@property (nonatomic, strong)RACSignal *signal;
@end

@implementation SignalController0

#pragma mark - --- 1.init 生命周期 ---

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.label = [[UILabel alloc]initWithFrame:CGRectMake(0, 100, 100, 44)];
    self.label.textColor = [UIColor blueColor];
    [self.view addSubview:self.label];
    
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(0, 200, 100, 44)];
    self.textField.textColor = [UIColor blueColor];
    self.textField.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.textField];
    

//    [self test];
//    [self test2];
    
    [self testAndtest2];
    [self test3];
}

#pragma mark - --- 2.delegate 视图委托 ---

#pragma mark - --- 3.event response 事件相应 ---

#pragma mark - --- 4.private methods 私有方法 ---
/**
 * RAC:把一个对象的某个属性绑定一个信号,只要发出信号,就会把信号的内容给对象的属性赋值
 * 给label的text属性绑定了文本框改变的信号
 */
- (void)test
{
    RAC(self.label, text) = self.textField.rac_textSignal;
//    [self.textField.rac_textSignal subscribeNext:^(id text) {
//        self.label.text = text;
//    }];
}

/**
 *  KVO
 *  RACObserveL:快速的监听某个对象的某个属性改变
 *  返回的是一个信号,对象的某个属性改变的信号
 */
- (void)test2 {
    [RACObserve(self.view, center) subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    [RACObserve(self, view) subscribeNext:^(id x) {
         NSLog(@"%s %@", __FUNCTION__, x);
    }];
}

- (void)testAndtest2 // textField输入的值赋值给label，监听label文字改变,
{
    RAC(self.label, text) = self.textField.rac_textSignal;
    [RACObserve(self.label, text) subscribeNext:^(id x) {
        NSLog(@"%s ====label的文字变了 %@", __FUNCTION__, x);
    }];
    
}

/**
 *  循环引用问题
 */
- (void)test3 {
    @weakify(self)
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        NSLog(@"%@",self.view);
        return nil;
    }];
    _signal = signal;
}

/**
 * 元祖
 * 快速包装一个元组
 * 把包装的类型放在宏的参数里面,就会自动包装
 */
- (void)test4 {
    RACTuple *tuple = RACTuplePack(@1,@2,@4);
    // 宏的参数类型要和元祖中元素类型一致， 右边为要解析的元祖。
    RACTupleUnpack_(NSNumber *num1, NSNumber *num2, NSNumber * num3) = tuple;// 4.元祖
    // 快速包装一个元组
    // 把包装的类型放在宏的参数里面,就会自动包装
    NSLog(@"%@ %@ %@", num1, num2, num3);
    
}
#pragma mark - --- 5.setters 属性 ---

#pragma mark - --- 6.getters 属性 —--


@end

