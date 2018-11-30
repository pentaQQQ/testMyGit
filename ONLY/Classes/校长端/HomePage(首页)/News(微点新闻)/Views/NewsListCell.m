//
//  NewsListCell.m
//  ONLY
//
//  Created by Dylan on 13/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "NewsListCell.h"

@implementation NewsListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

 
    // Configure the view for the selected state
}

-(void)setItem:(OnlyNewsItem *)item{
    _item = item;
    self.titleLabel.text = item.title;
    [self.photoIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,item.cover]]];
    self.timeLabel.text = [self timeWithTimeIntervalString:item.add_date];
    
}

- (NSString *)timeWithTimeIntervalString:(NSString *)aTimeString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[aTimeString doubleValue]];
    NSLog(@"%@",date);// 这个时间是格林尼治时间
    NSString *dat = [formatter stringFromDate:date];
    NSLog(@"%@", dat);// 这个时间是北京时间
    return dat;
}

@end
