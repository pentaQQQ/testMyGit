//
//  ConferenceDetailConfirmOrderCell_1.h
//  ONLY
//
//  Created by Dylan on 06/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConferenceItem.h"
@interface ConferenceDetailConfirmOrderCell_1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;


@property(nonatomic,strong)ConferenceItem * item;
@end
