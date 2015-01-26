//
//  AppUtil.h
//  bubble
//
//  Created by 周田龙 on 15/1/11.
//  Copyright (c) 2015年 blingstorm. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface AppUtil : NSObject

+ (NSDictionary*)    dictionaryReaderFromPlist:(NSString*)plistFileName;
+ (NSArray*)         arrayReaderFromPlist:(NSString*)pListFileName;

+ (CGSize)           getDrawingSizeString:(NSString*)srcString
                                    width:(NSInteger)width
                                 fontname:(NSString*)fontName
                                 fontsize:(NSInteger)fontSize;

+ (BOOL)             recordMessageString:(NSString*)messageString
                           ForSenderUser:(NSString*)userId
                                  ToUser:(NSString*)toUserId
                          InMessageArray:(NSMutableArray*)messageArray;

+ (BOOL)             recordMessageVideoFileString:(NSString *)videoString
                          videoThumbImageFileName:(NSString* )videoThumbImageString
                                    ForSenderUser:(NSString *)userId
                                           ToUser:(NSString *)toUserId
                                   InMessageArray:(NSMutableArray *)messageArray;

+ (BOOL)             recordMessageAudioFileString:(NSString*)audioFileName
                                    ForSenderUser:(NSString*)userId
                                           ToUser:(NSString*)toUserId
                                   InMessageArray:(NSMutableArray*)messageArray;

@end
