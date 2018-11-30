//
//  MineServerCell.m
//  ONLY
//
//  Created by 上海点硕 on 2017/1/19.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineServerCell.h"

@implementation MineServerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
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
