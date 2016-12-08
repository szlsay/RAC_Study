//
//  RACSequenceController.m
//  FRP_OC
//
//  Created by ST on 16/12/8.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "RACSequenceController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
@interface RACSequenceController ()

@end

@implementation RACSequenceController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    // 创建集合
    // 使用场景：遍历数组或者字典
    NSArray *arr = @[@1,@2,@3];
    
    // 1.把数组转换成RAC中集合类RACSequence
    // 2.把RACSequence转换成信号
    // 3.订阅信号，订阅的信号是集合，就会遍历集合，把集合的数据全部发送出来
        [arr.rac_sequence.signal subscribeNext:^(id x) {
    
            NSLog(@"%@",x);
        }];
    
    
    NSDictionary *dict = @{@"key":@1,@"key1":@2};
    
    [dict.rac_sequence.signal subscribeNext:^(RACTuple *x) {
        
//                NSLog(@"%@",x);
//                NSString *key = x[0];
//                NSString *value = x[1];
        
        // RACTupleUnpack宏：专门用来解析元组
        // RACTupleUnpack 等会右边：需要解析的元组 宏的参数，填解析的什么样数据
        // 元组里面有几个值，宏的参数就必须填几个
        RACTupleUnpack(NSString *key,NSString *value) = x;
         NSLog(@"%s %@ %@", __FUNCTION__, key,value);
        
    }];
    
    // 字典转模型
    NSString *path = [[NSBundle mainBundle] pathForResource:@"flags.plist" ofType:nil];
    // 解析plist文件
    NSArray *dictArr = [NSArray arrayWithContentsOfFile:path];
    [dictArr.rac_sequence.signal subscribeNext:^(id x) {
//         NSLog(@"%s %@", __FUNCTION__, x);
        
    }];
}

@end
