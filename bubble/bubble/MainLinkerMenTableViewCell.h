//
//  MainLinkerMenTableViewCell.h
//  bubble
//
//  Created by 周田龙 on 15/1/10.
//  Copyright (c) 2015年 blingstorm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainLinkerMenTableViewCell : UITableViewCell



+ (NSString*)   getTableViewCellIdentifier;
+ (NSUInteger)  getHeight;

@property (nonatomic, retain)   NSString*   headImageViewFileString;
@property (nonatomic, retain)   NSString*   nameLabelString;
@property (nonatomic, retain)   NSString*   descriptionLabelString;

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
