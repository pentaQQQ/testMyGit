//
//  ServiceListCell.m
//  ONLY
//
//  Created by Dylan on 16/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "ServiceListCell.h"

@implementation ServiceListCell

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
    [self.photoIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,item.service_img]]];
    self.titleLabel.text = item.service_name;
    self.applyCountLabel.text = [NSString stringWithFormat:@"已申请:%@",item.application_number];
    
}

@end
