//
//  AppUserInfo.h
//  bubble
//
//  Created by 周田龙 on 15/1/11.
//  Copyright (c) 2015年 blingstorm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUserInfo : NSObject

@property (nonatomic, strong)   NSString*   userId;
@property (nonatomic, strong)   NSString*   userName;
@property (nonatomic, strong)   NSString*   userHeadFileString;
@property                       Boolean     userIsMale;
@property (nonatomic, strong)   NSString*   userDes;

- (void) setUserName:(NSString*)myName
      headFileString:(NSString*)myHeadFileString
              isMale:(Boolean)myIsMale
                 des:(NSString*)myDes;

@end
