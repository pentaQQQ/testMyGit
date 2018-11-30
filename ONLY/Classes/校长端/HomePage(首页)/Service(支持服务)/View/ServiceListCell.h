//
//  ServiceListCell.h
//  ONLY
//
//  Created by Dylan on 16/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceItem.h"
IB_DESIGNABLE
@interface ServiceListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *applyCountLabel;


@property (nonatomic,strong) ServiceItem * item;
@end
