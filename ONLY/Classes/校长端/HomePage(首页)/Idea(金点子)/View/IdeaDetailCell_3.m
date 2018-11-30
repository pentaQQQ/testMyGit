//
//  IdeaDetailCell_3.m
//  ONLY
//
//  Created by Dylan on 13/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "IdeaDetailCell_3.h"

@implementation IdeaDetailCell_3

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

-(void)setItem:(IdeaReplyItem *)item{
    _item = item;
    [self.portraitIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,item.portrait]]];
    self.nameLabel.text = item.member_name;
    self.timeLabel.text = item.comment_time;
    self.commentLabel.text = item.comment_content;
    
}

@end
