//
//  AppDelegate.m
//  bubble
//
//  Created by 周田龙 on 15/1/9.
//  Copyright (c) 2015年 blingstorm. All rights reserved.
//

#import "AppDelegate.h"

#import "MainLinkerMenViewController.h"
#import "MainDiscoverInfoViewController.h"
#import "MyInfoViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//init data
    self.appContext                         =   [AppContext getInstance];
    
//begin--alloc navigationcontroller
    //MainLinkerMenViewController   and  linkerMenNavigationController  and tab bar
    self.mainLinkerMenViewController        =   [[MainLinkerMenViewController alloc]initWithNibName:@"MainLinkerMenViewController" bundle:nil];
    self.mainLinkerMenViewController.title  =   @"LinkerMen";
    
    self.linkerMenNavigationController      =   [[UINavigationController alloc]initWithRootViewController:self.mainLinkerMenViewController];

    UITabBarItem*   linkerMenTabBarItem     =   [[UITabBarItem alloc]initWithTitle:@"LinkerMen" image:[UIImage imageNamed:@"tabbaritem_linkermen.png"] tag:0];
    
    self.linkerMenNavigationController.tabBarItem   =   linkerMenTabBarItem;
    
    //MainDiscoverViewControlller   and   discoverNavigationController  and tab bar
    self.mainDiscoverViewController         =   [[MainDiscoverInfoViewController alloc]initWithNibName:@"MainDiscoverInfoViewController" bundle:nil];
    self.mainDiscoverViewController.title   =   @"Discover";
    
    
    self.disconverNavigationController      =   [[UINavigationController alloc]initWithRootViewController:self.mainDiscoverViewController];
    UITabBarItem*   discoverTabBarItem      =   [[UITabBarItem alloc]initWithTitle:@"Discover" image:[UIImage imageNamed:@"tabbaritem_linkermen.png"] tag:1];
    self.disconverNavigationController.tabBarItem   =   discoverTabBarItem;
    
    //MyInfoViewController          and    myInfoNavigationController  and tab bar
    self.myInfoViewController               =   [[MyInfoViewController alloc]initWithNibName:@"MyInfoViewController" bundle:nil];
    self.myInfoViewController.title         =   @"MyInfo";
    
    
    self.myInfoNavigationController         =   [[UINavigationController alloc]initWithRootViewController:self.myInfoViewController];
    UITabBarItem*   myInfoTabBarItem        =   [[UITabBarItem alloc]initWithTitle:@"MyInfo" image:[UIImage imageNamed:@"tabbaritem_myinfo.png"] tag:2];
    self.myInfoNavigationController.tabBarItem  =   myInfoTabBarItem;
//end--alloc navigationcontroller
    
//begin--UITabBarController
    NSArray*    allNavControllers   =   [[NSArray alloc]initWithObjects:self.linkerMenNavigationController, self.disconverNavigationController, self.myInfoNavigationController, nil];
    self.mainTabBarController       =   [[UITabBarController alloc]init];
    self.mainTabBarController.viewControllers   =   allNavControllers;
//end--UITabBarController
    
    self.window                     =   [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    self.window.rootViewController  =   self.mainTabBarController;
    self.window.backgroundColor     =   [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
