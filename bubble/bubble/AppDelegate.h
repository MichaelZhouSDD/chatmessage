//
//  AppDelegate.h
//  bubble
//
//  Created by 周田龙 on 15/1/9.
//  Copyright (c) 2015年 blingstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppContext.h"

@class MainLinkerMenViewController;
@class MainDiscoverInfoViewController;
@class MyInfoViewController;


@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (nonatomic, weak)   AppContext*               appContext;

@property (nonatomic, strong) UIWindow*                 window;

@property (nonatomic, strong) UITabBarController*       mainTabBarController;

@property (nonatomic, strong) UINavigationController*   linkerMenNavigationController;
@property (nonatomic, strong) UINavigationController*   disconverNavigationController;
@property (nonatomic, strong) UINavigationController*   myInfoNavigationController;

@property (nonatomic, strong) MainLinkerMenViewController*      mainLinkerMenViewController;
@property (nonatomic, strong) MainDiscoverInfoViewController*   mainDiscoverViewController;
@property (nonatomic, strong) MyInfoViewController*             myInfoViewController;

@end

