//
//  AppDelegate.m
//  FRP_APP
//
//  Created by ST on 16/12/9.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "AppDelegate.h"
#import "GalleryController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [GalleryController new];
    [self.window makeKeyWindow];
    return YES;
}


@end
