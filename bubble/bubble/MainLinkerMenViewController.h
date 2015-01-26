//
//  MainLinkerMenViewController.h
//  bubble
//
//  Created by 周田龙 on 15/1/9.
//  Copyright (c) 2015年 blingstorm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainLinkerMenTableViewCell.h"

@interface MainLinkerMenViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic)        NSArray*       linkerMenTabelViewData;
@property (weak, nonatomic) IBOutlet UITableView*   linkerMenTableView;

@end
