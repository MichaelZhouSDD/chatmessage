//
//  ChatMessageTableViewCell.h
//  bubble
//
//  Created by 周田龙 on 15/1/14.
//  Copyright (c) 2015年 blingstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChatMessageTableViewCell : UITableViewCell

+ (CGSize)      getVideoThurmbSize;
+ (CGSize)      getAudioImageSize;

+ (NSString*)   reuseIdentityString;
+ (NSString*)   fontName;
+ (NSInteger)   fontSize;
+ (CGFloat)     getTableCellHeight:(NSIndexPath*)cellIndexPath
                          withUser:(NSString*)userId;

@property (nonatomic, strong)   NSString*         userId;
@property (weak, nonatomic) NSIndexPath*          chatMessageIndexPath;

@property (weak, nonatomic) IBOutlet UIView *       mycontentView;
@property (weak, nonatomic) IBOutlet UIImageView*   headImageView;
@property (weak, nonatomic) IBOutlet UIImageView*   contentBackGround;
@property (weak, nonatomic) IBOutlet UILabel*       contentString;

@end
