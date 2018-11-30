//
//  MineCoinCell.m
//  ONLY
//
//  Created by 上海点硕 on 2017/1/14.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineCoinCell.h"

@implementation MineCoinCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupUI];
        
    }
    return self;
   

}

- (void)setupUI
{
    self.titleLabel = [UILabel new];
    [self.contentView addSubview:self.titleLabel];
    self.titleLabel.textColor= colorWithRGB(0x333333);
    self.titleLabel.font = font(14);
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.sd_layout.leftSpaceToView(self.contentView,16).widthIs(SCREEN_WIDTH-16).heightIs(13).topSpaceToView(self.contentView,17);
    self.titleLabel.text = @"金点子被采用";
    
    self.timeLabel = [UILabel new];
    [self.contentView addSubview:self.timeLabel];
    self.timeLabel.textColor= colorWithRGB(0x999999);
    self.timeLabel.font = font(14);
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    self.timeLabel.sd_layout.leftSpaceToView(self.contentView,16).widthIs(SCREEN_WIDTH/2).heightIs(13).topSpaceToView(self.titleLabel,7);
    self.timeLabel.text = @"2016-12-26";
    
    
    self.numLabel = [UILabel new];
    [self.contentView addSubview:self.numLabel];
    self.numLabel.textColor= colorWithRGB(0xEA5520);
    self.numLabel.font = font(14);
    self.numLabel.textAlignment = NSTextAlignmentRight;
    self.numLabel.sd_layout.rightSpaceToView(self.contentView,16).widthIs(SCREEN_WIDTH/2).heightIs(13).topSpaceToView(self.contentView,27);
    self.numLabel.text = @"+5";
    
    UIView *lineView = [UIView new];
    [self.contentView addSubview:lineView];
    lineView.sd_layout.leftEqualToView(self.contentView).rightEqualToView(self.contentView).bottomEqualToView(self.contentView).heightIs(1);
    lineView.backgroundColor = colorWithRGB(0x999999);
    lineView.alpha = 0.27;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end
