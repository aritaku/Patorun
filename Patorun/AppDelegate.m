//
//  AppDelegate.m
//  Patorun
//
//  Created by yoshitooooom on 2014/08/10.
//  Copyright (c) 2014年 yoshitooooom. All rights reserved.
//

#import "AppDelegate.h"

#import "JASidePanelController.h"
#import "CenterViewController.h"
#import "LeftViewController.h"


@implementation AppDelegate

@synthesize window = _window;
//@synthesize viewController = _viewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    // set Side Panel UI
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    
//    self.viewController = [[JASidePanelController alloc] init];
//    self.viewController.shouldDelegateAutorotateToVisiblePanel = NO;
//    
//    self.viewController.leftPanel = [[LeftViewController alloc] init];
//    self.viewController.centerPanel = [[UINavigationController alloc] initWithRootViewController:[[CenterViewController alloc] init]];
//    
//    self.window.rootViewController = self.viewController;
//    [self.window makeKeyAndVisible];
    
    // set navigation bar UI
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        [UINavigationBar appearance].barTintColor = [UIColor colorWithRed:(float)255/255 green:(float)140/255 blue:(float)0/255 alpha:1.0];
        [UINavigationBar appearance].tintColor = [UIColor whiteColor];
        [UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]}; // text color on navigation bar
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent]; // text color on status bar
    }
    
    return YES;
}

@end
