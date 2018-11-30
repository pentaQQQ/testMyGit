//
//  MineClassCell.m
//  ONLY
//
//  Created by 上海点硕 on 2017/1/18.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineClassCell.h"

@implementation MineClassCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        [self makeUI];
    }
    return self;
}

- (void)makeUI
{
    
    UIView *view  = [UIView new];
    [self.contentView addSubview:view];
    view.backgroundColor = WhiteColor;
    cornerRadiusView(view, 3);
    view.sd_layout.leftSpaceToView(self.contentView,16).rightSpaceToView(self.contentView,0).topSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0);
    
    self.Imgview = [UIImageView new];
    
    [self.contentView addSubview:self.Imgview];
    self.Imgview.sd_layout.leftSpaceToView(self.contentView,0).topSpaceToView(self.contentView,16).widthIs(33).heightIs(34);
    self.Imgview.image = [UIImage imageNamed:@"class"];
    
    self.dayLabel = [UILabel new];
    self.dayLabel.font = font(16);
    self.dayLabel.textColor = colorWithRGB(0x333333);
    [view addSubview:self.dayLabel];
    self.dayLabel.text = @"第 2 天";
    self.dayLabel.sd_layout.leftSpaceToView(self.Imgview,17).topSpaceToView(view,24).widthIs(54).heightIs(16);
    
    self.downImg =[UIImageView new];
    [view addSubview:self.downImg];
    self.downImg.sd_layout.rightSpaceToView(view,16).topSpaceToView(view,29).widthIs(14).heightIs(7);
    self.downImg.image = [UIImage imageNamed:@"down"];
    
    self.timeLabel = [UILabel new];
    self.timeLabel.font = font(14);
    self.timeLabel.textColor = colorWithRGB(0x999999);
    [view addSubview:self.timeLabel];
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    self.timeLabel.text = @"2017-01-03";
    self.timeLabel.sd_layout.leftSpaceToView(self.dayLabel,7).topSpaceToView(view,24).rightSpaceToView(_downImg,15).heightIs(14);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
