//
//  RACColdHot2Controller.m
//  FRP_OC
//
//  Created by ST on 16/12/9.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "RACColdHot2Controller.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <AFNetworking/AFNetworking.h>
@interface RACColdHot2Controller ()
/** 1. */
@property(nonatomic, strong)AFHTTPSessionManager *sessionManager ;
@end

@implementation RACColdHot2Controller

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://api.xxxx.com"]];
    
    self.sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    @weakify(self)
    RACSignal *fetchData = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(self)
        NSURLSessionDataTask *task = [self.sessionManager GET:@"fetchData" parameters:@{@"someParameter": @"someValue"} success:^(NSURLSessionDataTask *task, id responseObject) {
            [subscriber sendNext:responseObject];
            [subscriber sendCompleted];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [subscriber sendError:error];
        }];
        return [RACDisposable disposableWithBlock:^{
            if (task.state != NSURLSessionTaskStateCompleted) {
                [task cancel];
            }
        }];
    }];
    
    RACSignal *title = [fetchData flattenMap:^RACSignal *(NSDictionary *value) {
        if ([value[@"title"] isKindOfClass:[NSString class]]) {
            return [RACSignal return:value[@"title"]];
        } else {
            return [RACSignal error:[NSError errorWithDomain:@"some error" code:400 userInfo:@{@"originData": value}]];
        }
    }];
    
    RACSignal *desc = [fetchData flattenMap:^RACSignal *(NSDictionary *value) {
        if ([value[@"desc"] isKindOfClass:[NSString class]]) {
            return [RACSignal return:value[@"desc"]];
        } else {
            return [RACSignal error:[NSError errorWithDomain:@"some error" code:400 userInfo:@{@"originData": value}]];
        }
    }];
    
//    RACSignal *renderedDesc = [desc flattenMap:^RACStream *(NSString *value) {
//        NSError *error = nil;
//        RenderManager *renderManager = [[RenderManager alloc] init];
//        NSAttributedString *rendered = [renderManager renderText:value error:&error];
//        if (error) {
//            return [RACSignal error:error];
//        } else {
//            return [RACSignal return:rendered];
//        }
//    }];
//    
//    RAC(self.someLablel, text) = [[title catchTo:[RACSignal return:@"Error"]]  startWith:@"Loading..."];
//    RAC(self.originTextView, text) = [[desc catchTo:[RACSignal return:@"Error"]] startWith:@"Loading..."];
//    RAC(self.renderedTextView, attributedText) = [[renderedDesc catchTo:[RACSignal return:[[NSAttributedString alloc] initWithString:@"Error"]]] startWith:[[NSAttributedString alloc] initWithString:@"Loading..."]];
//    
//    [[RACSignal merge:@[title, desc, renderedDesc]] subscribeError:^(NSError *error) {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:error.domain delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alertView show];
//    }];

}

@end
