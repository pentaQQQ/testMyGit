//
//  NewsListCell_4.m
//  ONLY
//
//  Created by Dylan on 16/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "NewsListCell_4.h"

@implementation NewsListCell_4

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setItem:(NewsItem *)item{
    _item = item;
    self.statusLabel.text = item.tiding_name;
    self.contentLabel.text = item.explain;
}
@end
