//
//  IdeaDetailHeadView.m
//  ONLY
//
//  Created by Dylan on 15/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "IdeaDetailHeadView.h"

@implementation IdeaDetailHeadView


-(void)awakeFromNib{
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor whiteColor];
}

-(void)setItem:(IdeaItem *)item{
    _item = item;
    self.titleLabel.text = [NSString stringWithFormat:@"评论（%@）",item.comment_count];
}

@end
