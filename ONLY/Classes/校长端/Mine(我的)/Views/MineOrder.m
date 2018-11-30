//
//  MineOrder.m
//  ONLY
//
//  Created by 上海点硕 on 2017/1/16.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineOrder.h"

@implementation MineOrder

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.OrderBtnOne.layer.borderWidth = 1;
    self.OrderBtnOne.layer.borderColor = colorWithRGB(0x999999).CGColor;
    self.OrderBtnOne.layer.cornerRadius = 3;
    self.OrderBtnOne.layer.masksToBounds = YES;
    
    self.OrderBtnTwo.layer.borderWidth = 1;
    self.OrderBtnTwo.layer.borderColor = colorWithRGB(0xEA5520).CGColor;
    self.OrderBtnTwo.layer.cornerRadius = 3;
    self.OrderBtnTwo.layer.masksToBounds = YES;
  
}

- (IBAction)oneClick:(id)sender {
    
    if (self.oneBlock) {
        self.oneBlock();
    }
}
- (IBAction)twoClick:(id)sender {
    
    if (self.TwoBlock) {
        self.TwoBlock();
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
