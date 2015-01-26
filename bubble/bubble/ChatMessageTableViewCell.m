//
//  ChatMessageTableViewCell.m
//  bubble
//
//  Created by 周田龙 on 15/1/14.
//  Copyright (c) 2015年 blingstorm. All rights reserved.
//

#import "ChatMessageTableViewCell.h"
#import "AppContext.h"
#import "AppDelegate.h"
#import "AppUtil.h"

#define MarginX         5
#define MarginY         5
#define HeadSizeX       40
#define HeadSizeY       40
#define ExtendWidth     35
#define ExtendHeight    30
#define StringMarginX   20
#define StringMarginY   5
#define VideoThumbWidth     200
#define VideoThumbHeight    200
#define AudioImageWidth     200
#define AudioImageHeigh     60

@implementation ChatMessageTableViewCell

+ (CGSize)      getVideoThurmbSize
{
    return CGSizeMake(VideoThumbWidth, VideoThumbHeight);
}

+ (CGSize)      getAudioImageSize
{
    return CGSizeMake(AudioImageWidth, AudioImageHeigh);
}

+ (NSString*)   reuseIdentityString
{
    return @"ChatMessageTableViewCell";
}
+ (NSString*)   fontName
{
    return @"HelveticaNeue";
}
+ (NSInteger)   fontSize
{
    return 15;
}

+ (CGFloat) getTableCellHeight:(NSIndexPath*)cellIndexPath
                      withUser:(NSString*)userId
{
    AppDelegate*    curAppDelegate  =   (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSMutableArray* messageRecords  =   [curAppDelegate.appContext.myChatMessageRecords objectForKey:userId];
    if(messageRecords)
    {
        AppBaseChatMessage* curBaseMessage  =   [messageRecords objectAtIndex:cellIndexPath.row];
        if(curBaseMessage.chatMessageType == ChatMessageType_String)
        {
            AppStringChatMessage*  curStringMessage = (AppStringChatMessage*)curBaseMessage;
            CGSize stringSize       =   [AppUtil getDrawingSizeString: curStringMessage.contentString
                                                                width: 200
                                                             fontname:[ChatMessageTableViewCell fontName]
                                                             fontsize:[ChatMessageTableViewCell fontSize]];
            return MarginX + MAX(stringSize.height + ExtendHeight, HeadSizeY) + MarginX;
        }
        else if(curBaseMessage.chatMessageType == chatMessageType_Music)
        {
            CGSize  audioSize   =   [ChatMessageTableViewCell getAudioImageSize];
            return MarginX + MAX(audioSize.height, HeadSizeY) + MarginX;
        }
        else if(curBaseMessage.chatMessageType == ChatMessageType_Video)
        {
            CGSize  videoThumbSize  =   [ChatMessageTableViewCell getVideoThurmbSize];
            return MarginX + MAX(videoThumbSize.height, HeadSizeY) + MarginX;
        }
    }
    return 80;
}

- (void)setChatMessageIndexPath:(NSIndexPath *)chatMessageIndexPath
{
    _chatMessageIndexPath   =   chatMessageIndexPath;
    
    AppDelegate*    curAppDelegate  =   (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    AppBaseChatMessage*     curBaseChatMessage = [[curAppDelegate.appContext.myChatMessageRecords objectForKey:self.userId] objectAtIndex:chatMessageIndexPath.row];
    if(curBaseChatMessage)
    {
        if(curBaseChatMessage.isMyChatMessage   ==  NO)
        {
            AppUserInfo*    curUserInfo     =   [curAppDelegate.appContext.myDictLinkerMenInfos objectForKey:self.userId];
            self.headImageView.image    =   [UIImage imageNamed:curUserInfo.userHeadFileString];
            self.headImageView.frame    =   CGRectMake(MarginX, MarginY, HeadSizeX, HeadSizeY);
        }
        else
        {
            CGSize  windowSize  =   [UIScreen mainScreen].bounds.size;
            self.headImageView.frame    =   CGRectMake(windowSize.width - HeadSizeX - MarginX, MarginY, HeadSizeX, HeadSizeY);
            self.headImageView.image    =   [UIImage imageNamed:curAppDelegate.appContext.myInfo.userHeadFileString];
            
        }
        if(curBaseChatMessage.chatMessageType == ChatMessageType_String)
        {
            AppStringChatMessage*   curStringChatMessage    =   (AppStringChatMessage*)curBaseChatMessage;
            self.contentString.text = curStringChatMessage.contentString;
            CGSize  stringSize  =   [AppUtil getDrawingSizeString:curStringChatMessage.contentString
                                                            width:200
                                                         fontname:[ChatMessageTableViewCell fontName]
                                                         fontsize:[ChatMessageTableViewCell fontSize]];
            
            if(curStringChatMessage.isMyChatMessage ==  NO)
            {
                //content view
                CGSize  viewSize    =   CGSizeMake(stringSize.width + ExtendWidth, stringSize.height + ExtendHeight);
                CGFloat viewX       =   MarginX + HeadSizeX + MarginX;
                CGFloat viewY       =   MarginY;
                self.mycontentView.frame            =   CGRectMake(viewX, viewY, viewSize.width, viewSize.height);
                
                //content background image view
                UIImage*    bgImage     =   [UIImage imageNamed:@"chatfrom_bg_normal.png"];
                CGSize      bgImageSize =   bgImage.size;
                bgImage                 =   [bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(bgImageSize.height / 4, bgImageSize.width / 4, bgImageSize.height / 4, bgImageSize.width / 4)
                                                                    resizingMode:UIImageResizingModeStretch];
                self.contentBackGround.image    =   bgImage;
                self.contentBackGround.frame    =   CGRectMake(0, 0, self.mycontentView.bounds.size.width, self.mycontentView.bounds.size.height);
                
                //content string
                self.contentString.frame    =   CGRectMake(StringMarginX, StringMarginY, stringSize.width, stringSize.height);
            }
            else
            {
                CGSize  winSize =   [UIScreen mainScreen].bounds.size;
                
                //content view
                CGSize  viewSize    =   CGSizeMake(stringSize.width + ExtendWidth, stringSize.height + ExtendHeight);
                CGFloat viewX       =   winSize.width - MarginX - HeadSizeX - MarginX - viewSize.width;
                CGFloat viewY       =   MarginY;
                self.mycontentView.frame  = CGRectMake(viewX, viewY, viewSize.width, viewSize.height);
                
                //content background image view
                UIImage*    bgImage     =   [UIImage imageNamed:@"chatto_bg_normal.png"];
                CGSize      bgImageSize =   bgImage.size;
                bgImage                 =   [bgImage resizableImageWithCapInsets:UIEdgeInsetsMake(bgImageSize.height / 4, bgImageSize.width / 4, bgImageSize.height / 4, bgImageSize.width / 4)
                                                                    resizingMode:UIImageResizingModeStretch];
                self.contentBackGround.image    =   bgImage;
                self.contentBackGround.frame    =   CGRectMake(0, 0, self.mycontentView.bounds.size.width, self.mycontentView.bounds.size.height);
                
                //content string
                self.contentString.frame    =   CGRectMake(StringMarginX - 8, StringMarginY, stringSize.width, stringSize.height);
            }
        }
        else if(curBaseChatMessage.chatMessageType == chatMessageType_Music)
        {
            AppMusicChatMessage*    curMusicMessage =   (AppMusicChatMessage*)curBaseChatMessage;
            if(curMusicMessage.isMyChatMessage  ==  YES)
            {
                CGSize  windowSize  =   [UIScreen mainScreen].bounds.size;
                CGSize  myContentSize  = [ChatMessageTableViewCell getAudioImageSize];
                self.mycontentView.frame    =   CGRectMake(windowSize.width - MarginX - HeadSizeX - MarginX - myContentSize.width, MarginY, myContentSize.width, myContentSize.height);
                self.contentBackGround.image    =   [UIImage imageNamed:@"voice.png"];
                self.contentBackGround.frame    =   CGRectMake(0, 0, self.mycontentView.bounds.size.width, self.mycontentView.bounds.size.height);
                self.contentString.text         =   @"Listen To Me Now.";
            }
            else
            {
                CGSize  myContentSize  = [ChatMessageTableViewCell getAudioImageSize];
                self.mycontentView.frame    =   CGRectMake(MarginX + HeadSizeX + MarginX, MarginY, myContentSize.width, myContentSize.height);
                self.contentBackGround.image    =   [UIImage imageNamed:@"voice.png"];
                self.contentBackGround.frame    =   CGRectMake(0, 0, self.mycontentView.bounds.size.width, self.mycontentView.bounds.size.height);
                self.contentString.text         =   @"Listen To Me Now.";
            }
        }
        else if(curBaseChatMessage.chatMessageType == ChatMessageType_Video)
        {
            AppVideoChatMessage*    curVideoMessage =   (AppVideoChatMessage*)curBaseChatMessage;
            if(curVideoMessage.isMyChatMessage  ==  YES)
            {
                CGSize  windowSize  =   [UIScreen mainScreen].bounds.size;
                CGSize  myContentSize  = [ChatMessageTableViewCell getVideoThurmbSize];
                self.mycontentView.frame    =   CGRectMake(windowSize.width - MarginX - HeadSizeX - MarginX - myContentSize.width, MarginY, myContentSize.width, myContentSize.height);
                self.contentBackGround.image    =   [[UIImage alloc]initWithContentsOfFile:curVideoMessage.contentThumbImageFileName];
                self.contentBackGround.frame    =   CGRectMake(0, 0, self.mycontentView.bounds.size.width, self.mycontentView.bounds.size.height);
                self.contentString.text         =   @"Click Me Now.";
            }
            else
            {
                CGSize  myContentSize  = [ChatMessageTableViewCell getVideoThurmbSize];
                self.mycontentView.frame    =   CGRectMake(MarginX + HeadSizeX + MarginX, MarginY, myContentSize.width, myContentSize.height);
                self.contentBackGround.image    =   [[UIImage alloc]initWithContentsOfFile:curVideoMessage.contentThumbImageFileName];
                self.contentBackGround.frame    =   CGRectMake(0, 0, self.mycontentView.bounds.size.width, self.mycontentView.bounds.size.height);
                self.contentString.text         =   @"Click Me Now.";
            }
        }
    }
    
}

- (void)awakeFromNib
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

@end
