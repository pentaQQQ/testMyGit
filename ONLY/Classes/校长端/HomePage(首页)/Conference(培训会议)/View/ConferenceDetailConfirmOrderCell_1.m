//
//  ConferenceDetailConfirmOrderCell_1.m
//  ONLY
//
//  Created by Dylan on 06/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "ConferenceDetailConfirmOrderCell_1.h"

@implementation ConferenceDetailConfirmOrderCell_1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//-(void)setFrame:(CGRect)frame{
//    CGRect rect = CGRectMake(frame.origin.x+5 , frame.origin.y, frame.size.width-10, frame.size.height);
//    
//    [super setFrame:rect];
//}

-(void)setItem:(ConferenceItem *)item{
    _item = item;
    self.titleLabel.text = item.course_title;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@/人",item.unit_price];
}

@end
