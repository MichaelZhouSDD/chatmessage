//
//  AppBaseChatMessage.h
//  bubble
//
//  Created by 周田龙 on 15/1/13.
//  Copyright (c) 2015年 blingstorm. All rights reserved.
//

#import <Foundation/Foundation.h>
//
//typedef enum : NSUInteger
//{
//    ChatMessageType_String,
//    chatMessageType_Music,
//    ChatMessageType_Video,
//    
//} ChatMessageType;

typedef NS_ENUM(NSUInteger, ChatMessageType)
{
    ChatMessageType_String  =   0,
    chatMessageType_Music,
    ChatMessageType_Video,
};

@interface AppBaseChatMessage : NSObject

@property                 ChatMessageType   chatMessageType;
@property                       Boolean     isMyChatMessage;

@property(nonatomic, strong)    NSString*   senderUserId;
@property(nonatomic, strong)    NSString*   receiveUserId;

@end

@interface AppStringChatMessage : AppBaseChatMessage

@property(nonatomic, strong)    NSString*   contentString;

@end

@interface AppMusicChatMessage  : AppBaseChatMessage

@property(nonatomic, strong)    NSString*   contentMusicFileName;

@end

@interface AppVideoChatMessage : AppBaseChatMessage

@property(nonatomic, strong)    NSString*   contentThumbImageFileName;
@property(nonatomic, strong)    NSString*   contentVideoFileName;

@end