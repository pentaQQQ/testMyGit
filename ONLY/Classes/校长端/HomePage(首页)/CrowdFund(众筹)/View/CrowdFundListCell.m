//
//  CrowdFundListCell.m
//  ONLY
//
//  Created by Dylan on 16/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "CrowdFundListCell.h"

@implementation CrowdFundListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    CGAffineTransform transform=CGAffineTransformMakeRotation(0.78);
    self.statusLabel.transform = transform;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)setItem:(CrowdFundItem *)item{
    _item = item;
    
    self.titleLabel.text = item.good_name;
    
    [self.photoIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,item.picture]] placeholderImage:[UIImage imageNamed:@"图层59"]];
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@/%@",item.unit_price,item.good_unit];
    self.countLabel.text = item.goods_count;
    if (self.status == CrowdFundStatus_Requset) {
        self.statusLabel.text = @"征询中";
        self.priceTitleLabel.text = @"市场参考价:";
    }else if (self.status == CrowdFundStatus_Progressing){
        self.statusLabel.text = @"众筹中";
        self.priceTitleLabel.text = @"预订价:";
    }else if (self.status == CrowdFundStatus_Finish){
        self.statusLabel.text = @"已结束";
        self.priceTitleLabel.text = @"实际支付:";
    }
    
    CGFloat percent;
    NSArray * count = self.item.crowd_price[@"count"];
    
    
    if (count.count > 0) {
        if (self.status == CrowdFundStatus_Requset) {
            percent = [item.goods_count floatValue]/[item.expect_count floatValue];
        }else if (self.status == CrowdFundStatus_Progressing){
            percent = [item.crowd_num floatValue]/[count[0] floatValue];
        }else{
            percent = [item.crowd_num floatValue]/[count[0] floatValue];
        }
    }
    self.percentLabel.text = [NSString stringWithFormat:@"%.0f%%",percent*100];
    self.percentPV.progress = percent;
    
}

@end
