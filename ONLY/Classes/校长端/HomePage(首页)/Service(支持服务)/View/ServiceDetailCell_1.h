//
//  ServiceDetailCell_1.h
//  ONLY
//
//  Created by Dylan on 08/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceItem.h"
@interface ServiceDetailCell_1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property(nonatomic,strong)ServiceItem * item;
@end
