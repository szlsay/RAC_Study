//
//  AppDelegate.m
//  FRP_OC
//
//  Created by ST on 16/12/7.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "AppDelegate.h"
#import "TableViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:[TableViewController new]];
    self.window.rootViewController = navVC;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
