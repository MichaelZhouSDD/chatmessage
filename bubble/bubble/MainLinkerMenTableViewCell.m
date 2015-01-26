//
//  MainLinkerMenTableViewCell.m
//  bubble
//
//  Created by 周田龙 on 15/1/10.
//  Copyright (c) 2015年 blingstorm. All rights reserved.
//

#import "MainLinkerMenTableViewCell.h"

@implementation MainLinkerMenTableViewCell

+ (NSString*)   getTableViewCellIdentifier
{
    return @"MainLinkerMenTableViewCell";
}
+ (NSUInteger)  getHeight
{
    return 60;
}

- (void)    setHeadImageViewFileString:(NSString *)headImageViewFileString
{
    _headImageViewFileString    =   [headImageViewFileString copy];
    
    self.imageView.image        =   [UIImage imageNamed:_headImageViewFileString];
}
- (void)    setNameLabelString:(NSString *)nameLabelString
{
    _nameLabelString    =   [nameLabelString copy];
    
    self.nameLabel.text =   _nameLabelString;
}
- (void)    setDescriptionLabelString:(NSString *)descriptionLabelString
{
    _descriptionLabelString     =   [descriptionLabelString copy];
    
    self.descriptionLabel.text  =   _descriptionLabelString;
}

//from super

- (void)awakeFromNib
{
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        //customize MainlinkerMenTableViewCell
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
