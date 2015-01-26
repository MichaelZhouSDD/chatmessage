//
//  MainLinkerMenViewController.m
//  bubble
//
//  Created by 周田龙 on 15/1/9.
//  Copyright (c) 2015年 blingstorm. All rights reserved.
//

#import "MainLinkerMenViewController.h"
#import "AppDelegate.h"
#import "LinkerManInfoViewController.h"

@interface MainLinkerMenViewController ()

@end

@implementation MainLinkerMenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.linkerMenTabelViewData =   @[
                                      @{@"name":@"Michael", @"desp":@"good man" },
                                      @{@"name":@"Sdd"    , @"desp":@"good girl"},
                                      @{@"name":@"MaMa"   , @"desp":@"good mama"},
                                     ];
    UINib*  nibCell =   [UINib nibWithNibName:@"MainLinkerMenTableViewCell" bundle:nil];
    [self.linkerMenTableView    registerNib:nibCell forCellReuseIdentifier:[MainLinkerMenTableViewCell getTableViewCellIdentifier]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDelegate and UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AppDelegate*    curAppDelegate  =   (AppDelegate*)[[UIApplication sharedApplication]delegate];
    return [curAppDelegate.appContext.myArrayLinkerMenInfos count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [MainLinkerMenTableViewCell getHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger      curRow  =   indexPath.row;
    AppDelegate*    curAppDelegate  =   (AppDelegate*)[[UIApplication sharedApplication]delegate];
    AppUserInfo*    curUserInfo     =   [curAppDelegate.appContext.myArrayLinkerMenInfos objectAtIndex:curRow];
    
    MainLinkerMenTableViewCell* curCell =   [tableView dequeueReusableCellWithIdentifier:[MainLinkerMenTableViewCell getTableViewCellIdentifier]];
    curCell.nameLabelString             =   curUserInfo.userName;
    curCell.descriptionLabelString      =   curUserInfo.userDes;
    curCell.headImageView.image         =   [UIImage imageNamed:curUserInfo.userHeadFileString];
    
    return curCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate*    curAppDelegate  =   (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    NSInteger   curRow  =   indexPath.row;
    AppUserInfo*    curUserInfo =   [curAppDelegate.appContext.myArrayLinkerMenInfos objectAtIndex:curRow];
    LinkerManInfoViewController*    curLinkerManInfoViewController  =   [[LinkerManInfoViewController alloc]initWithNibName:@"LinkerManInfoViewController" linkerManId:curUserInfo.userId];
    [curAppDelegate.linkerMenNavigationController pushViewController:curLinkerManInfoViewController animated:YES];
}

@end
