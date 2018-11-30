//
//  ServiceWaiterListCell.h
//  ONLY
//
//  Created by Dylan on 08/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceManItem.h"
@interface ServiceWaiterListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sexIV;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *serviceCountLabel;

@property (nonatomic,strong) ServiceManItem * manItem;
@property(nonatomic, copy) void (^btnAction_block)(NSInteger index);
@end
