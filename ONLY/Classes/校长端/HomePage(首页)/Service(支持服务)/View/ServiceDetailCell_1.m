//
//  ServiceDetailCell_1.m
//  ONLY
//
//  Created by Dylan on 08/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "ServiceDetailCell_1.h"

@implementation ServiceDetailCell_1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setItem:(ServiceItem *)item{
    _item = item;
    self.titleLabel.text = item.service_name;
    self.descriptionLabel.text = [NSString stringWithFormat:@"%@",item.service_desc];
    
}

@end
