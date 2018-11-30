//
//  NewsListCell_1.m
//  ONLY
//
//  Created by Dylan on 16/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "NewsListCell_1.h"

@implementation NewsListCell_1

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)setItem:(NewsItem *)item{
    _item = item;
    self.titleLabel.text = item.tiding_name;
    [self.thumbnailIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,item.tiding_img]]];
    self.nameLabel.text = item.title;
    self.detailLabel.text = [NSString stringWithFormat:@"运单编号:%@",item.gd_sn];
}

- (NSString *)timeWithTimeIntervalString:(NSString *)aTimeString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[aTimeString doubleValue]];
    NSLog(@"%@",date);// 这个时间是格林尼治时间
    NSString *dat = [formatter stringFromDate:date];
    NSLog(@"%@", dat);// 这个时间是北京时间
    return dat;
    
}

@end
