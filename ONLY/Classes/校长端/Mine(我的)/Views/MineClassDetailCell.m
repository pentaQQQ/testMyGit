//
//  MineClassDetailCell.m
//  ONLY
//
//  Created by 上海点硕 on 2017/1/19.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineClassDetailCell.h"

@implementation MineClassDetailCell

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
    //cornerRadiusView(view, 3);
    view.sd_layout.leftSpaceToView(self.contentView,16).rightSpaceToView(self.contentView,0).topSpaceToView(self.contentView,0).bottomSpaceToView(self.contentView,0);
    
    UIImageView *imageview = [UIImageView new];
    imageview.image = [UIImage imageNamed:@"clock"];
    [view addSubview:imageview];
    imageview.sd_layout.leftSpaceToView(view,33).topSpaceToView(view,15).widthIs(13).heightIs(13);
    
    self.classType = [UILabel new];
    self.classType.font = font(12);
    [view addSubview:self.classType];
    self.classType.textColor = colorWithRGB(0x333333);
    self.classType.textAlignment = NSTextAlignmentLeft;
    self.classType.text = @"第一讲 大众教育课程概述";
    self.classType.sd_layout.leftSpaceToView(imageview,11).topSpaceToView(view,15).rightSpaceToView(view,10).heightIs(12);
    
    self.tecLabel = [UILabel new];
    self.tecLabel.font = font(12);
    [view addSubview:self.tecLabel];
    self.tecLabel.textColor = colorWithRGB(0x333333);
    self.tecLabel.textAlignment = NSTextAlignmentLeft;
    self.tecLabel.text = @"课程讲师：张老师";
    self.tecLabel.sd_layout.leftSpaceToView(imageview,11).topSpaceToView(self.classType,7).rightSpaceToView(view,10).heightIs(12);
    
    self.timeLabel = [UILabel new];
    self.timeLabel.font = font(12);
    [view addSubview:self.timeLabel];
    self.timeLabel.textColor = colorWithRGB(0x333333);
    self.timeLabel.textAlignment = NSTextAlignmentLeft;
    self.timeLabel.text = @"上课时间：10:00 - 12:00";
    self.timeLabel.sd_layout.leftSpaceToView(imageview,11).topSpaceToView(self.tecLabel,7).rightSpaceToView(view,10).heightIs(12);
    
    self.addLabel = [UILabel new];
    self.addLabel.font = font(12);
    [view addSubview:self.addLabel];
    self.addLabel.textColor = colorWithRGB(0x333333);
    self.addLabel.textAlignment = NSTextAlignmentLeft;
    self.addLabel.text = @"上课地址：徐汇光启城19楼100号大课堂";
    self.addLabel.sd_layout.leftSpaceToView(imageview,11).topSpaceToView(self.timeLabel,7).rightSpaceToView(view,10).heightIs(12);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

@end
