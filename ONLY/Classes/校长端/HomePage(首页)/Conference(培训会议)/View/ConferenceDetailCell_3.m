//
//  ConferenceDetailCell_3.m
//  ONLY
//
//  Created by Dylan on 07/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "ConferenceDetailCell_3.h"

@implementation ConferenceDetailCell_3

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headIV.layer.cornerRadius = self.headIV.height/2;
    self.headIV.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setItem:(TeacherItem *)item{
    _item = item;
    [self.headIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,item.teacher_img]]];
    self.titleLabel.text = item.teacher_name;
    self.descriptionLabel.text = item.teacher_desc;
}

@end
