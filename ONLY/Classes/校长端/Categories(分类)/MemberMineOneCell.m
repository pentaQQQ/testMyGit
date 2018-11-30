//
//  MemberMineOneCell.m
//  ONLY
//
//  Created by zfd on 17/1/13.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MemberMineOneCell.h"

@implementation MemberMineOneCell

- (void)awakeFromNib
{
    [super awakeFromNib];
   _shuxian_label.backgroundColor = TableviewLineColor;
    
}

- (IBAction)order_button:(UIButton*)sender {
    
    if ([self.delegate respondsToSelector:@selector(clickWithTag:)]) {
        
        [self.delegate clickWithTag:sender.tag];
    }
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

   
}




@end
