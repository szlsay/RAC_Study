//
//  AppDelegate.m
//  FRP_OC
//
//  Created by ST on 16/12/7.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "AppDelegate.h"
#import "TableViewController.h"
#import "TableView0Controller.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:[TableViewController new]];
    navVC.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemMore tag:0];
    UINavigationController *navVC0 = [[UINavigationController alloc]initWithRootViewController:[TableView0Controller new]];
    navVC0.tabBarItem = [[UITabBarItem alloc]initWithTabBarSystemItem:UITabBarSystemItemSearch tag:1];
    UITabBarController *tabbarVC = [[UITabBarController alloc]init];
    tabbarVC.viewControllers = @[navVC, navVC0];
    self.window.rootViewController = tabbarVC;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
