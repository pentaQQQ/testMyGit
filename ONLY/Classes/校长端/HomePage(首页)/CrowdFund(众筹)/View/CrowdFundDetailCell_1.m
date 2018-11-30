//
//  CrowdFundDetailCell_1.m
//  ONLY
//
//  Created by Dylan on 14/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "CrowdFundDetailCell_1.h"

@implementation CrowdFundDetailCell_1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setItem:(CrowdFundItem *)item{
    _item = item;
    self.titleLabel.text = item.good_name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@/%@",item.unit_price,item.good_unit];
    self.startCountLabel.text = [NSString stringWithFormat:@"%@%@/人",item.start_num,item.good_unit];
    self.descriptionLabel.text = item.good_explain;
    if (self.status == CrowdFundStatus_Requset){
        self.priceTitleLabel.text = @"市场参考价:";
        [self.startCountLabel removeFromSuperview];
        [self.startCountTitleLabel removeFromSuperview];
    }else if (self.status == CrowdFundStatus_Progressing){
        self.priceTitleLabel.text = @"预订价:";
    }else{
        self.priceTitleLabel.text = @"实际支付:";
    }

}

@end
