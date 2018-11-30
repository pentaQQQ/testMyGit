//
//  CrowdFundDetailCell_3.h
//  ONLY
//
//  Created by Dylan on 16/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrowdFundItem.h"
@interface CrowdFundDetailCell_3 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIProgressView *progress;
@property (weak, nonatomic) IBOutlet UILabel *greatCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *targetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@property (nonatomic ,strong) CrowdFundItem * item;
@end
