//
//  LinkerManChatInfoViewController.h
//  bubble
//
//  Created by 周田龙 on 15/1/9.
//  Copyright (c) 2015年 blingstorm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface LinkerManChatInfoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIImagePickerControllerDelegate, AVAudioRecorderDelegate, AVAudioPlayerDelegate, AVAudioSessionDelegate>

-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil chatUserId:(NSString*)chatUserId;

@property(nonatomic, strong)    NSString*       chatUserId;

@property (weak, nonatomic) IBOutlet UITableView *curChatMessageTableView;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@property(nonatomic, strong)    UIAlertView*      alertView;
@property(nonatomic, strong)    NSString*         videoThumbeFileString;
@property(nonatomic, strong)    NSString*         videoFileString;

@property (weak, nonatomic) IBOutlet UIButton *speakButton;

- (IBAction)onClickToolBarVoice:(id)sender;
- (IBAction)onClickToolBarMovie:(id)sender;

- (IBAction)onClickSpeakButton:(id)sender;
- (IBAction)onClickUpSpeakButton:(id)sender;
@end
