//
//  AppUtil.m
//  bubble
//
//  Created by 周田龙 on 15/1/11.
//  Copyright (c) 2015年 blingstorm. All rights reserved.
//

#import "AppUtil.h"
#import "AppBaseChatMessage.h"

@implementation AppUtil

+ (NSDictionary*) dictionaryReaderFromPlist:(NSString*)plistFileName
{
    NSString* pathString        =   [[NSBundle mainBundle] pathForResource:plistFileName ofType:@"plist"];
    NSDictionary* resourceDict  =   [[NSDictionary alloc]initWithContentsOfFile:pathString];
    
    return resourceDict;
}
+ (NSArray*)     arrayReaderFromPlist:(NSString*)pListFileName
{
    NSString*   pathString      =   [[NSBundle mainBundle]pathForResource:pListFileName ofType:@"plist"];
    NSArray*    resourceArray   =   [[NSArray alloc]initWithContentsOfFile:pathString];
    
    return resourceArray;
}

+ (CGSize)      getDrawingSizeString:(NSString *)srcString
                               width:(NSInteger)width
                            fontname:(NSString *)fontName
                            fontsize:(NSInteger)fontSize
{
    UIFont* theFont =   [UIFont fontWithName:fontName size:fontSize];
    NSDictionary*   theFontAttrbite =   @{NSFontAttributeName:theFont};
    
    CGSize  expectSize  =   CGSizeMake(width, MAXFLOAT);
    
    return  [srcString  boundingRectWithSize:expectSize
                                     options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                  attributes:theFontAttrbite
                                     context:nil].size;
}

+ (BOOL)             recordMessageString:(NSString*)messageString
                           ForSenderUser:(NSString *)userId
                                  ToUser:(NSString *)toUserId
                          InMessageArray:(NSMutableArray *)messageArray
{
    AppStringChatMessage*   curStringMessage    =   [[AppStringChatMessage alloc]init];
    curStringMessage.chatMessageType            =   ChatMessageType_String;
    curStringMessage.isMyChatMessage            =   YES;
    curStringMessage.senderUserId               =   [userId copy];
    curStringMessage.receiveUserId              =   [toUserId copy];
    curStringMessage.contentString              =   [messageString copy];
    
    [messageArray insertObject:curStringMessage atIndex:messageArray.count];
    
    return YES;
}

+ (BOOL)             recordMessageVideoFileString:(NSString *)videoString
                          videoThumbImageFileName:(NSString* )videoThumbImageString
                                    ForSenderUser:(NSString *)userId
                                           ToUser:(NSString *)toUserId
                                   InMessageArray:(NSMutableArray *)messageArray
{
    AppVideoChatMessage*   curVideoMessage     =   [[AppVideoChatMessage alloc]init];
    curVideoMessage.chatMessageType            =   ChatMessageType_Video;
    curVideoMessage.isMyChatMessage            =   YES;
    curVideoMessage.senderUserId               =   [userId copy];
    curVideoMessage.receiveUserId              =   [toUserId copy];
    curVideoMessage.contentThumbImageFileName  =   [videoThumbImageString copy];
    curVideoMessage.contentVideoFileName       =   [videoString copy];
    
    [messageArray insertObject:curVideoMessage atIndex:messageArray.count];
    
    return YES;
}

+ (BOOL)             recordMessageAudioFileString:(NSString*)audioFileName
                                    ForSenderUser:(NSString*)userId
                                           ToUser:(NSString*)toUserId
                                   InMessageArray:(NSMutableArray*)messageArray
{
    AppMusicChatMessage*   curAudioMessage     =   [[AppMusicChatMessage alloc]init];
    curAudioMessage.chatMessageType            =   chatMessageType_Music;
    curAudioMessage.isMyChatMessage            =   YES;
    curAudioMessage.senderUserId               =   [userId copy];
    curAudioMessage.receiveUserId              =   [toUserId copy];
    curAudioMessage.contentMusicFileName       =   [audioFileName copy];
    
    [messageArray insertObject:curAudioMessage atIndex:messageArray.count];
    
    return YES;
}


@end
