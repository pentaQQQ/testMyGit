//
//  ConferenceDetailCell_1.h
//  ONLY
//
//  Created by Dylan on 16/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConferenceItem.h"
@interface ConferenceDetailCell_1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *enrollTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *checkInTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *trainingTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;


@property(nonatomic,strong)ConferenceItem * item;
@end
