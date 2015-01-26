//
//  AppContext.h
//  bubble
//
//  Created by 周田龙 on 15/1/11.
//  Copyright (c) 2015年 blingstorm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppUserInfo.h"
#import "AppBaseChatMessage.h"

@interface AppContext : NSObject

+ (AppContext*)     getInstance;

@property(nonatomic, strong)    AppUserInfo*            myInfo;
@property(nonatomic, strong)    NSMutableArray*         myArrayLinkerMenInfos;
@property(nonatomic, strong)    NSMutableDictionary*    myDictLinkerMenInfos;

@property(nonatomic, strong)    NSMutableArray*         myChatMessagetemple;
@property(nonatomic, strong)    NSMutableDictionary*    myChatMessageRecords;

@end
