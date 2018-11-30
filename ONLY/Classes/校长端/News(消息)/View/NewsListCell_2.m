//
//  NewsListCell_2.m
//  ONLY
//
//  Created by Dylan on 16/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "NewsListCell_2.h"

@implementation NewsListCell_2

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
    self.titleLabel.text = item.tiding_name;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",item.price];
    
    if ([item.difference integerValue]==0) {
        self.detailTitleLabel_1.text = @"退款方式:";
        self.detailTitleLabel_2.text = @"退款到:";
        self.detailTitleLabel_3.text = @"退款说明:";
    }else{
        self.detailTitleLabel_1.text = @"交易方式:";
        self.detailTitleLabel_2.text = @"交易账号:";
        self.detailTitleLabel_3.text = @"交易说明:";
    }
    
    
    self.detailLabel_1.text = item.method;
    self.detailLabel_2.text = item.account;
    self.detailLabel_3.text = item.explain;
}

@end
