//
//  LinkerManChatInfoViewController.m
//  bubble
//
//  Created by 周田龙 on 15/1/9.
//  Copyright (c) 2015年 blingstorm. All rights reserved.
//

#import "LinkerManChatInfoViewController.h"
#import "ChatMessageTableViewCell.h"
#import "AppDelegate.h"
#import "AppUtil.h"
#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <CoreMedia/CoreMedia.h>
#import "ChatMessageTableViewCell.h"
#import "lame.h"

@interface LinkerManChatInfoViewController ()

@property(nonatomic, strong)    AVAudioSession*     myAudioSession;
@property(nonatomic, strong)    AVAudioRecorder*    myAudioRecorder;
@property(nonatomic, strong)    AVAudioPlayer*      myAudioPlayer;

@property(nonatomic, strong)    NSString*           myAudioRawFileName;
@property(nonatomic, strong)    NSURL*              myAudioRawFileURL;
@property(nonatomic, strong)    NSString*           myAudioMp3FileName;

@end

@implementation LinkerManChatInfoViewController

-(instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil chatUserId:(NSString*)chatUserId
{
    self    =   [super  initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self)
    {
        self.chatUserId                 =   [chatUserId copy];
        self.hidesBottomBarWhenPushed   =   YES;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    self.inputTextField.delegate    =   self;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onKeyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(onKeyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    AppDelegate*    curAppDelegate  =   (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSMutableArray* curChatMessages =   (NSMutableArray*)[curAppDelegate.appContext.myChatMessageRecords objectForKey:self.chatUserId];
    if(!curChatMessages)
    {
        NSMutableArray* curMessages =   [[NSMutableArray alloc]init];
        [curAppDelegate.appContext.myChatMessageRecords setObject:curMessages forKey:[self.chatUserId copy]];
        
        for (AppStringChatMessage* tempStringMessage in curAppDelegate.appContext.myChatMessagetemple )
        {
            AppStringChatMessage* newStringMessage  =   [[AppStringChatMessage alloc]init];
            newStringMessage.chatMessageType    =   ChatMessageType_String;
            newStringMessage.isMyChatMessage    =   FALSE;
            newStringMessage.senderUserId       =   [self.chatUserId copy];
            newStringMessage.receiveUserId      =   [curAppDelegate.appContext.myInfo.userId copy];
            newStringMessage.contentString      =   [tempStringMessage.contentString copy];
            [curMessages insertObject:newStringMessage atIndex:curMessages.count];
        }
    }
    UINib*  pTempNib    =   [UINib  nibWithNibName:@"ChatMessageTableViewCell" bundle:nil];
    [self.curChatMessageTableView registerNib:pTempNib
                       forCellReuseIdentifier:@"ChatMessageTableViewCell"];
    
    self.myAudioRawFileName     =   [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/downloadFile.caf"];
    self.myAudioRawFileURL      =   [[NSURL alloc]initWithString:self.myAudioRawFileName];
    
    self.myAudioMp3FileName     =   [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/downloadFile.mp3"];
}

-(void)viewWillAppear:(BOOL)animated
{
    self.title  =   self.chatUserId;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AppDelegate*    curAppDelegate  =   (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSMutableArray* curChatArray    =   [curAppDelegate.appContext.myChatMessageRecords objectForKey:self.chatUserId];
    
    return curChatArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ChatMessageTableViewCell getTableCellHeight:indexPath
                                               withUser:self.chatUserId];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChatMessageTableViewCell*   pCurCell    =   [tableView dequeueReusableCellWithIdentifier:[ChatMessageTableViewCell reuseIdentityString] forIndexPath:indexPath];
    
    pCurCell.userId                 =   [self.chatUserId copy];
    pCurCell.chatMessageIndexPath   =   indexPath;
    
    return pCurCell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate*    curAppDelegate  =   (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSMutableArray* curChatMessages =   (NSMutableArray*)[curAppDelegate.appContext.myChatMessageRecords objectForKey:self.chatUserId];
    
    AppBaseChatMessage* selectedBaseMessage     =   (AppBaseChatMessage*)[curChatMessages objectAtIndex:indexPath.row];
    if(selectedBaseMessage.chatMessageType  ==  ChatMessageType_Video)
    {
        AppVideoChatMessage*    videoMessage    =   (AppVideoChatMessage*)selectedBaseMessage;
        [self playVideoWithFileName:videoMessage.contentVideoFileName];
    }
    else if(selectedBaseMessage.chatMessageType == chatMessageType_Music)
    {
        AppMusicChatMessage*    musicMessage    =   (AppMusicChatMessage*)selectedBaseMessage;
        [self playMyAudioWithFileName:musicMessage.contentMusicFileName];
    }
}


//notification for keyboard
-(void)onKeyBoardWillShow:(NSNotification*)note
{
    CGRect keyboardRect  =   [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardAnimationTime   =   [[note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    
    [UIView animateWithDuration:keyboardAnimationTime
                     animations:
                    ^{
                        self.view.transform    =   CGAffineTransformMakeTranslation(0, keyboardRect.size.height * (-1));
                     }];
}
-(void)onKeyBoardWillHide:(NSNotification*)note
{
    CGFloat keyboardAnimationTime   =   [[note.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    [UIView animateWithDuration:keyboardAnimationTime
                     animations:
                    ^{
                        self.view.transform =   CGAffineTransformIdentity;
                     }];
}

//text field delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    AppDelegate*    curAppDelegate  = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSMutableArray* curChatMessages = (NSMutableArray*)[curAppDelegate.appContext.myChatMessageRecords objectForKey:self.chatUserId];
    
    [AppUtil recordMessageString:self.inputTextField.text
                   ForSenderUser:self.chatUserId
                          ToUser:curAppDelegate.appContext.myInfo.userId
                  InMessageArray:curChatMessages];
    [self.curChatMessageTableView reloadData];
    
    self.inputTextField.text    =   @"";
    
    return YES;
}

//video recorder and player

//video recorder
- (void)videoThurmbImage:(UIImage *)image
{
    NSDateFormatter* formater   = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    self.videoThumbeFileString  =   [NSHomeDirectory() stringByAppendingFormat:@"/Documents/thumb-%@.png", [formater stringFromDate:[NSDate date]]];
     [UIImagePNGRepresentation(image) writeToFile:self.videoThumbeFileString options:NSAtomicWrite error:nil];
}
- (void) convertFinish
{
    [self.alertView dismissWithClickedButtonIndex:0 animated:YES];
    self.alertView = [[UIAlertView alloc] initWithTitle:@"Finish"
                                                     message:[NSString stringWithFormat:@"Successful, it takes %.2fs", 1.0f]
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles: nil];
    [self.alertView show];
    
    
    AppDelegate*    curAppDelegate  = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSMutableArray* curChatMessages = (NSMutableArray*)[curAppDelegate.appContext.myChatMessageRecords objectForKey:self.chatUserId];
    
    [AppUtil recordMessageVideoFileString:self.videoFileString
                  videoThumbImageFileName:self.videoThumbeFileString
                            ForSenderUser:self.chatUserId
                                   ToUser:curAppDelegate.appContext.myInfo.userId
                           InMessageArray:curChatMessages];
    [self.curChatMessageTableView reloadData];
}
-(void)recordVideo
{
    UIImagePickerController*    pickerView = [[UIImagePickerController alloc] init];
    pickerView.sourceType           = UIImagePickerControllerSourceTypeCamera;
    NSArray* availableMedia         = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    pickerView.cameraDevice         =   UIImagePickerControllerCameraDeviceFront;
    pickerView.mediaTypes           = @[(NSString*)availableMedia[1]];
    [self presentModalViewController:pickerView animated:YES];
    pickerView.videoMaximumDuration = 30;
    pickerView.delegate             = self;
//    [pickerView release];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString* firstVideoFileString = info[UIImagePickerControllerMediaURL];
    [self dismissModalViewControllerAnimated:YES];
    
    //encoder to mp4
    AVURLAsset *avAsset = [AVURLAsset URLAssetWithURL:firstVideoFileString options:nil];
    
    //find one image
    AVAssetImageGenerator*  generator   =   [[AVAssetImageGenerator alloc]initWithAsset:avAsset];
    generator.appliesPreferredTrackTransform    =   YES;
    CMTime  thumbTime   =   CMTimeMakeWithSeconds(0, 30);
    
    AVAssetImageGeneratorCompletionHandler handler =
    ^(CMTime requestedTime, CGImageRef im, CMTime actualTime, AVAssetImageGeneratorResult result, NSError *error)
    {
        if (result != AVAssetImageGeneratorSucceeded)
        {
            //没成功
        }
        
        UIImage *thumbImg = [UIImage imageWithCGImage:im];
//        [generator release];
        
        [self performSelectorOnMainThread:@selector(videoThurmbImage:) withObject:thumbImg waitUntilDone:YES];
        
    };
    generator.maximumSize   =   [ChatMessageTableViewCell getVideoThurmbSize];
    [generator generateCGImagesAsynchronouslyForTimes:
     [NSArray arrayWithObject:[NSValue valueWithCMTime:thumbTime]] completionHandler:handler];
    //end find one image
    
    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
    
    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality])
    {
        self.alertView  = [[UIAlertView alloc] init];
        [self.alertView setTitle:@"Waiting.."];
        
        UIActivityIndicatorView* activity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        activity.frame = CGRectMake(140,
                                    80,
                                    CGRectGetWidth(self.alertView.frame),
                                    CGRectGetHeight(self.alertView.frame));
        [self.alertView addSubview:activity];
        [activity startAnimating];
//        [activity release];
        [self.alertView show];
//        [self.firstAlertView release];
        
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc]initWithAsset:avAsset
                                                                              presetName:AVAssetExportPresetHighestQuality];
        NSDateFormatter* formater   = [[NSDateFormatter alloc] init];
        [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
        self.videoFileString     = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/video-%@.mp4", [formater stringFromDate:[NSDate date]]];
//        [formater release];
        
        exportSession.outputURL = [NSURL fileURLWithPath: self.videoFileString];
        exportSession.shouldOptimizeForNetworkUse = NO;
        exportSession.outputFileType = AVFileTypeMPEG4;
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            switch ([exportSession status]) {
                case AVAssetExportSessionStatusFailed:
                {
                    [self.alertView dismissWithClickedButtonIndex:0 animated:NO];
                    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                    message:[[exportSession error] localizedDescription]
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles: nil];
                    [alert show];
//                    [alert release];
                    break;
                }
                    
                case AVAssetExportSessionStatusCancelled:
                    NSLog(@"Export canceled");
                    [self.alertView dismissWithClickedButtonIndex:0
                                                              animated:YES];
                    break;
                case AVAssetExportSessionStatusCompleted:
                    NSLog(@"Successful!");
                    [self performSelectorOnMainThread:@selector(convertFinish) withObject:nil waitUntilDone:NO];
                    break;
                default:
                    break;
            }
//            [exportSession release];
        }];
    }
    else
    {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"AVAsset doesn't support mp4 quality"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
        [alert show];
//        [alert release];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)playVideoWithFileName:(NSString*)videoFileName
{
    MPMoviePlayerViewController* playerView = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:[NSString stringWithFormat:@"file://localhost/private%@", videoFileName]]];
    
    NSLog(@"%@",[NSString stringWithFormat:@"file://localhost/private%@", videoFileName]);
    
    [self presentModalViewController:playerView animated:YES];
}

- (IBAction)onClickToolBarVoice:(id)sender
{
    if(self.speakButton.hidden  ==  YES)
    {
        self.speakButton.hidden =   NO;
    }
    else
    {
        self.speakButton.hidden =   YES;
    }
}

- (IBAction)onClickToolBarMovie:(id)sender
{
    [self recordVideo];
//    [self playAudio];
}

- (IBAction)onClickSpeakButton:(id)sender
{
    self.myAudioSession             = [AVAudioSession sharedInstance];
    self.myAudioSession.delegate    = self;
    NSError *sessionError;
    [self.myAudioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    if(self.myAudioSession == nil)
    {
        NSLog(@"Error creating session: %@", [sessionError description]);
    }
    else
    {
        [self.myAudioSession setActive:YES error:nil];
    }
    //录音设置
    NSMutableDictionary *settings = [[NSMutableDictionary alloc] init];
    //录音格式 无法使用
    [settings setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey: AVFormatIDKey];
    //采样率
    [settings setValue :[NSNumber numberWithFloat:11025.0] forKey: AVSampleRateKey];//44100.0
    //通道数
    [settings setValue :[NSNumber numberWithInt:2] forKey: AVNumberOfChannelsKey];
    [settings setValue:[NSNumber numberWithInt:AVAudioQualityMin] forKey:AVEncoderAudioQualityKey];
    
    self.myAudioRecorder = [[AVAudioRecorder alloc] initWithURL:self.myAudioRawFileURL settings:settings error:nil];
    self.myAudioRecorder.delegate   =   self;
    [self.myAudioRecorder prepareToRecord];
    [self.myAudioRecorder record];
}

- (IBAction)onClickUpSpeakButton:(id)sender
{
    [self.myAudioRecorder stop];
    
    if(self.myAudioRecorder)
    {
        self.myAudioRecorder = nil;
    }
    
    NSDateFormatter* formater   = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    self.myAudioMp3FileName  = [NSHomeDirectory() stringByAppendingFormat:@"/Documents/audio-%@.mp3", [formater stringFromDate:[NSDate date]]];
    
    [self audio_PCMtoMP3];
    
    
//    [self.myAudioRecorder stop];
//    
//    //encoder
//    NSString*   audioFileName = [self audioTransformFromPCMToMP3];
//    
//    AppDelegate*    curAppDelegate  = (AppDelegate*)[UIApplication sharedApplication].delegate;
//    NSMutableArray* curChatMessages = (NSMutableArray*)[curAppDelegate.appContext.myChatMessageRecords objectForKey:self.chatUserId];
//    
//    [AppUtil recordMessageAudioFileString:audioFileName
//                            ForSenderUser:self.chatUserId
//                                   ToUser:curAppDelegate.appContext.myInfo.userId
//                           InMessageArray:curChatMessages];
//    [self.curChatMessageTableView reloadData];
}

- (void)audio_PCMtoMP3
{
    NSFileManager* fileManager=[NSFileManager defaultManager];
    if([fileManager removeItemAtPath:self.myAudioMp3FileName error:nil])
    {
        NSLog(@"删除");
    }
    
    @try
    {
        int read, write;
        
        FILE *pcm = fopen([self.myAudioRawFileName cStringUsingEncoding:1], "rb");  //source 被转换的音频文件位置
        fseek(pcm, 4*1024, SEEK_CUR);                                   //skip file header
        FILE *mp3 = fopen([self.myAudioMp3FileName cStringUsingEncoding:1], "wb");  //output 输出生成的Mp3文件位置
        
        const int PCM_SIZE = 8192;
        const int MP3_SIZE = 8192;
        short int pcm_buffer[PCM_SIZE*2];
        unsigned char mp3_buffer[MP3_SIZE];
        
        lame_t lame = lame_init();
        lame_set_in_samplerate(lame, 11025.0);
        lame_set_VBR(lame, vbr_default);
        lame_init_params(lame);
        
        do
        {
            read = fread(pcm_buffer, 2*sizeof(short int), PCM_SIZE, pcm);
            if (read == 0)
                write = lame_encode_flush(lame, mp3_buffer, MP3_SIZE);
            else
                write = lame_encode_buffer_interleaved(lame, pcm_buffer, read, mp3_buffer, MP3_SIZE);
            
            fwrite(mp3_buffer, write, 1, mp3);
            
        } while (read != 0);
        
        lame_close(lame);
        fclose(mp3);
        fclose(pcm);
    }
    @catch (NSException *exception)
    {
        NSLog(@"%@",[exception description]);
    }
}

- (void)playAudio
{
    NSError *playerError;
    self.myAudioPlayer  =   [[AVAudioPlayer alloc] initWithContentsOfURL:[[NSURL alloc] initFileURLWithPath:self.myAudioMp3FileName] error:&playerError];
    self.myAudioPlayer.volume   =   1.0f;
    if (self.myAudioPlayer == nil)
    {
        NSLog(@"ERror creating player: %@", [playerError description]);
    }
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategorySoloAmbient error: nil];
    self.myAudioPlayer.delegate = self;
//    [self.myAudioPlayer release];
    
    if(self.myAudioPlayer.isPlaying ==  YES)
    {
        [self.myAudioPlayer pause];
    }
    else
    {
        [self.myAudioPlayer play];
    }
}

- (void)playMyAudioWithFileName:(NSString*)myAudioFileName
{
    NSError *playerError;
    AVAudioPlayer *audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[[NSURL alloc] initFileURLWithPath:myAudioFileName] error:&playerError];
    self.myAudioPlayer          = audioPlayer;
    self.myAudioPlayer.volume   = 1.0f;
    if (self.myAudioPlayer == nil)
    {
        NSLog(@"ERror creating player: %@", [playerError description]);
    }
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategorySoloAmbient error: nil];
    self.myAudioPlayer.delegate = self;
    [self.myAudioPlayer play];
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag
{
    
}
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    //    [playButton setTitle:@"Play" forState:UIControlStateNormal];
}


@end
