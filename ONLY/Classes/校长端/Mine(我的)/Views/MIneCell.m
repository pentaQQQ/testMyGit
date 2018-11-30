//
//  MIneCell.m
//  ONLY
//
//  Created by 上海点硕 on 2017/1/14.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MIneCell.h"

@implementation MIneCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupUI];
        
    }
    return self;
}


- (void)setupUI
{
    self.Imgview = [UIImageView new];
    [self.contentView addSubview:self.Imgview];
    self.Imgview.sd_layout.leftSpaceToView(self.contentView,17).topSpaceToView(self.contentView,17).widthIs(12).heightIs(13);
    
    self.titleLabel = [UILabel new];
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.textColor = colorWithRGB(0x333333);
    self.titleLabel.font = font(14);
    self.titleLabel.text = @"我的人员";
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.sd_layout.leftSpaceToView(self.Imgview,12).topEqualToView(self.Imgview).widthIs(72).heightIs(13);


}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
