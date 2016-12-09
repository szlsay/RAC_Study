//
//  AppDelegate.m
//  FRP_APP
//
//  Created by ST on 16/12/9.
//  Copyright © 2016年 ST. All rights reserved.
//

#import "AppDelegate.h"
#import "GalleryController.h"
#import "FRPGalleryViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(nullable NSDictionary *)launchOptions {
    
    NSString *consumerKey = @"DC2To2BS0ic1ChKDK15d44M42YHf9gbUJgdFoF0m";
    NSString *consumerSecret = @"i8WL4chWoZ4kw9fh3jzHK7XzTer1y5tUNvsTFNnB";
    
    [PXRequest setConsumerKey:consumerKey consumerSecret:consumerSecret];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[FRPGalleryViewController alloc] init]];
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}



@end
