//
//  CrowdFundDetailCell_2.h
//  ONLY
//
//  Created by Dylan on 14/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrowdFundItem.h"
#import "CrowdFundController.h"
@interface CrowdFundDetailCell_2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *percentLabel;
@property (weak, nonatomic) IBOutlet UIProgressView *percentPV;
@property (weak, nonatomic) IBOutlet UILabel *greatCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *targetCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic,assign)CrowdFundStatus status;
@property (nonatomic ,strong) CrowdFundItem * item;
@end
