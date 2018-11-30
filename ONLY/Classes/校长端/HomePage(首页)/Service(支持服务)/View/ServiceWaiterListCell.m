//
//  ServiceWaiterListCell.m
//  ONLY
//
//  Created by Dylan on 08/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "ServiceWaiterListCell.h"

@implementation ServiceWaiterListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)btnClicked:(UIButton *)sender {
    if (self.btnAction_block) {
        self.btnAction_block(sender.tag);
    }
}
-(void)setManItem:(ServiceManItem *)manItem{
    _manItem = manItem;
    self.nameLabel.text = manItem.member_name;
    if ([manItem.sex integerValue] == 0) {
        self.sexIV.image = [UIImage imageNamed:@"支持服务_人员列表_male"];
    }else if ([manItem.sex integerValue] == 1){
        self.sexIV.image = [UIImage imageNamed:@"支持服务_人员列表_female"];
    }
    self.positionLabel.text = manItem.level_name;
    self.serviceCountLabel.text = manItem.service_count;
    self.priceLabel.text = [NSString stringWithFormat:@"%@起",manItem.service_price];
    
}
@end
