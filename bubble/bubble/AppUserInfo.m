//
//  AppUserInfo.m
//  bubble
//
//  Created by 周田龙 on 15/1/11.
//  Copyright (c) 2015年 blingstorm. All rights reserved.
//

#import "AppUserInfo.h"

@implementation AppUserInfo

- (void) setUserName:(NSString*)myName
      headFileString:(NSString*)myHeadFileString
              isMale:(Boolean)myIsMale
                 des:(NSString*)myDes
{
    self.userName           =   [myName copy];
    self.userHeadFileString =   [myHeadFileString copy];
    self.userIsMale         =   myIsMale;
    self.userDes            =   [myDes copy];
}


@end
