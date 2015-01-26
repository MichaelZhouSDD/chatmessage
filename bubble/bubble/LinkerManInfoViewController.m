//
//  LinkerManInfoViewController.m
//  bubble
//
//  Created by 周田龙 on 15/1/9.
//  Copyright (c) 2015年 blingstorm. All rights reserved.
//

#import "LinkerManInfoViewController.h"
#import "AppDelegate.h"
#import "LinkerManChatInfoViewController.h"

@interface LinkerManInfoViewController ()

@end

@implementation LinkerManInfoViewController

- (instancetype)  initWithNibName:(NSString *)nibNameOrNil linkerManId:(NSString*)myLinkerManId
{
    self    =   [super initWithNibName:nibNameOrNil bundle:nil];
    if(self)
    {
        self.linkerManId    =   [myLinkerManId copy];
        self.title          =   @"LinkerManInfo";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    AppDelegate*    curAppDelegate  =   (AppDelegate*)[[UIApplication sharedApplication] delegate];
    AppUserInfo*    curUsrInfo      =   [curAppDelegate.appContext.myDictLinkerMenInfos objectForKey:self.linkerManId];
    
    self.linkerManName.text         =   curUsrInfo.userName;
    self.linkerManDesc.text         =   curUsrInfo.userDes;
    self.linkerManHeadView.image    =   [UIImage imageNamed:curUsrInfo.userHeadFileString];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)onChatNow:(id)sender
{
    LinkerManChatInfoViewController*    chatView    =   [[LinkerManChatInfoViewController alloc]initWithNibName:@"LinkerManChatInfoViewController" bundle:nil chatUserId:self.linkerManId];

    AppDelegate*    curAppDelegate  =   (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    [curAppDelegate.linkerMenNavigationController pushViewController:chatView
                                                            animated:YES];
}
@end
