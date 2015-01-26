//
//  AppContext.m
//  bubble
//
//  Created by 周田龙 on 15/1/11.
//  Copyright (c) 2015年 blingstorm. All rights reserved.
//

#import "AppContext.h"
#import "AppUtil.h"

static  AppContext*     s_appContext    =   nil;

@implementation AppContext

+ (AppContext*)     getInstance
{
    @synchronized(self)
    {
        if(!s_appContext)
        {
            s_appContext    =   [[self alloc] init];
        }
    }
    return s_appContext;
}

- (void)    onInit
{
    static  NSString*   s_myInfoString            =   @"myinfo";
    static  NSString*   s_myLinkerMenInfosString  =   @"linkermen";
    
    //my info
    NSDictionary*   myInfoFromPlist =   [AppUtil dictionaryReaderFromPlist:s_myInfoString];
    self.myInfo =   [[AppUserInfo alloc] init];
    NSString*   myPlayerId  =   [myInfoFromPlist objectForKey:@"userid"];
    NSString*   myName      =   [myInfoFromPlist objectForKey:@"name"];
    NSString*   myHeadFile  =   [myInfoFromPlist objectForKey:@"headfilename"];
    Boolean     myIsMale    =   [[myInfoFromPlist objectForKey:@"ismale"] boolValue];
    NSString*   myDes       =   [myInfoFromPlist objectForKey:@"des"];
    self.myInfo.userId      =   [myPlayerId copy];
    [self.myInfo setUserName:myName headFileString:myHeadFile isMale:myIsMale des:myDes];
    
    
    //my linkerMenInfos
    NSArray* myLinkerMenFromPlist   =   [AppUtil arrayReaderFromPlist:s_myLinkerMenInfosString];
    self.myArrayLinkerMenInfos      =   [NSMutableArray arrayWithCapacity:[myLinkerMenFromPlist count]];
    self.myDictLinkerMenInfos       =   [NSMutableDictionary dictionaryWithCapacity:[myLinkerMenFromPlist count]];
    for (id curId in myLinkerMenFromPlist)
    {
        NSDictionary*   curDict =   (NSDictionary*)curId;
        if(curDict)
        {
            NSString*   curPlayerId  =   [curDict   objectForKey:@"userid"];
            NSString*   curName      =   [curDict   objectForKey:@"name"];
            NSString*   curHeadFile  =   [curDict   objectForKey:@"headfilename"];
            Boolean     curIsMale    =   [[curDict  objectForKey:@"ismale"] boolValue];
            NSString*   curDes       =   [curDict   objectForKey:@"des"];
            
            AppUserInfo*    curUserInfo =   [[AppUserInfo alloc] init];
            curUserInfo.userId          =   [curPlayerId copy];
            [curUserInfo setUserName:curName headFileString:curHeadFile isMale:curIsMale des:curDes];
            
            [self.myArrayLinkerMenInfos insertObject:curUserInfo atIndex:[self.myArrayLinkerMenInfos count]];
            
            NSString*       curUserId   =   [curPlayerId copy];
            [self.myDictLinkerMenInfos  setObject:curUserInfo forKey:curUserId];
        }
    }
    
    //chat message template
    NSArray*    chatMessageTemples    = [AppUtil arrayReaderFromPlist:@"chatmessagetemple"];
    self.myChatMessagetemple          = [[NSMutableArray alloc]init];
    for (NSDictionary* curDict in chatMessageTemples)
    {
        AppStringChatMessage*   curMessage  =   [[AppStringChatMessage alloc]init];
        NSString*  messageContent   =   (NSString*)[curDict objectForKey:@"messagecontent"];
        
        curMessage.isMyChatMessage  =   NO;
        curMessage.chatMessageType  =   ChatMessageType_String;
        curMessage.senderUserId     =   @"";
        curMessage.receiveUserId    =   @"";
        curMessage.contentString    =   [messageContent copy];
        
        [self.myChatMessagetemple insertObject:curMessage atIndex:self.myChatMessagetemple.count];
    }
    
    self.myChatMessageRecords       =   [[NSMutableDictionary alloc] init];
}

- (id)  init
{
    self    =   [super init];
    if(self)
    {
        [self onInit];
    }
    return self;
}


@end
