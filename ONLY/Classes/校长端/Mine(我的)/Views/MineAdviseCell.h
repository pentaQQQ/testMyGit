//
//  MineAdviseCell.h
//  ONLY
//
//  Created by 上海点硕 on 2017/2/6.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineAdviseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *adviseTitle;
@property (weak, nonatomic) IBOutlet UILabel *adviseTime;
@property (weak, nonatomic) IBOutlet UILabel *adviseStatus;
@property (weak, nonatomic) IBOutlet UIImageView *adviseImg;

@end
