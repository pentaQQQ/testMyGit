//
//  CrowdFundDetailCell_1.h
//  ONLY
//
//  Created by Dylan on 14/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrowdFundItem.h"
#import "CrowdFundController.h"
@interface CrowdFundDetailCell_1 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *startCountTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *startCountLabel;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;


@property (nonatomic ,assign) CrowdFundStatus status;
@property (nonatomic ,strong) CrowdFundItem * item;
@end
