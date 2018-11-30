//
//  MemberMineTwoCell.m
//  ONLY
//
//  Created by zfd on 17/1/13.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MemberMineTwoCell.h"

@implementation MemberMineTwoCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    _line_label.backgroundColor = TableviewLineColor;
    _icon_name_label.textColor = darkGray_Color();
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}





@end
