//
//  LinkerManInfoViewController.h
//  bubble
//
//  Created by 周田龙 on 15/1/9.
//  Copyright (c) 2015年 blingstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LinkerManInfoViewController : UIViewController

- (instancetype)  initWithNibName:(NSString *)nibNameOrNil linkerManId:(NSString*)myLinkerManId;

@property(nonatomic, strong)    NSString*         linkerManId;

@property (weak, nonatomic) IBOutlet UIImageView* linkerManHeadView;
@property (weak, nonatomic) IBOutlet UILabel*     linkerManName;
@property (weak, nonatomic) IBOutlet UILabel*     linkerManDesc;

- (IBAction)onChatNow:(id)sender;

@end
