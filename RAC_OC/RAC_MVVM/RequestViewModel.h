//
//  RequestViewModel.h
//  RAC_OC
//
//  Created by ST on 16/11/17.
//  Copyright © 2016年 ST. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"
#import "AFNetworking.h"

//#import <AFNetworking.h>

@interface RequestViewModel : NSObject
@property(nonatomic, strong, readonly)RACCommand *requestCommand;
@end
