//
//  CrowdFundDetailCell_2.m
//  ONLY
//
//  Created by Dylan on 14/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "CrowdFundDetailCell_2.h"

@implementation CrowdFundDetailCell_2

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
    self.greatCountLabel.text = item.goods_count;
//    self.targetCountLabel.text = item.start_num;
    self.targetCountLabel.text = [NSString stringWithFormat:@"%@",count.firstObject];
    self.timeLabel.text = item.endTime;
    
}

@end
