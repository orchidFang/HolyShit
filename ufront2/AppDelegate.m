//
//  AppDelegate.m
//  ufront2
//
//  Created by cyyun on 14-9-19.
//  Copyright (c) 2014年 cyyun. All rights reserved.
//

#import "AppDelegate.h"
#import "UIKit+AFNetworking/AFNetworkActivityIndicatorManager.h"
#import "Utils.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"loggedIn"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self configNavigationBarAndTabBar];
    // Override point for customization after application launch.
    return YES;
}


-(void)configNavigationBarAndTabBar
{
    //设置导航栏背景图片
    if ([Utils getSystemVersion] >= 7.0) {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbar_bg_ios7.png"] forBarMetrics:UIBarMetricsDefault];
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    }else
    {
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbar_bg.png"] forBarMetrics:UIBarMetricsDefault];
    }
    
    //设置导航栏文本颜色
    [[UINavigationBar appearance] setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor],UITextAttributeFont:[UIFont systemFontOfSize:20.0f]}];
    
    //设置TabBar
    
    UIImage *backgroundImage = [Utils imageWithColor:[UIColor colorWithRed:129.0/255 green:129.0/255 blue:129.0/255 alpha:1.0] andSize:CGSizeMake(320, 49)];
    UIImage *selectedImage = [Utils imageWithColor:[UIColor colorWithRed:89.0/255 green:89.0/255 blue:89.0/255 alpha:1.0] andSize:CGSizeMake(323.0/3, 49)];
    [[UITabBar appearance] setBackgroundImage:backgroundImage];
    [[UITabBar appearance] setSelectionIndicatorImage:selectedImage];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    
    
    
    [[UITabBarItem appearance] setTitleTextAttributes:@{UITextAttributeTextColor:[UIColor whiteColor]}forState:UIControlStateNormal];
    
    UITabBarController *tabBarController = (UITabBarController*)self.window.rootViewController;
    UINavigationController *messageNavigationController = tabBarController.viewControllers[0];
    UITabBarItem *messageItem = messageNavigationController.tabBarItem;
    [messageItem setFinishedSelectedImage:[UIImage imageNamed:@"icon_m_msg.png"]
              withFinishedUnselectedImage:[UIImage imageNamed:@"icon_m_msg.png"]];

    UINavigationController *contactNavigationController =
        tabBarController.viewControllers[1];
    UITabBarItem *contactItem = contactNavigationController.tabBarItem;
    [contactItem
           setFinishedSelectedImage:[UIImage imageNamed:@"icon_m_adrsbook.png"]
        withFinishedUnselectedImage:[UIImage imageNamed:@"icon_m_adrsbook.png"]];

    UINavigationController *settingNavigationController =
        tabBarController.viewControllers[2];
    UITabBarItem *settingItem = settingNavigationController.tabBarItem;
    [settingItem
           setFinishedSelectedImage:[UIImage imageNamed:@"icon_m_settings.png"]
        withFinishedUnselectedImage:[UIImage imageNamed:@"icon_m_settings.png"]];

}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
