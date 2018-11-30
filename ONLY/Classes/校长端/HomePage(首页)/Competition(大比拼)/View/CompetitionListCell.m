//
//  CompetitionListCell.m
//  ONLY
//
//  Created by Dylan on 14/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "CompetitionListCell.h"

@implementation CompetitionListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    CGAffineTransform transform=CGAffineTransformMakeRotation(0.78);
    self.statusLabel.transform = transform;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)setItem:(CompetitionItem *)item{
    _item = item;
    [self.photoIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,item.match_img]]];
    self.titleLabel.text = item.match_name;
    self.statusLabel.text = item.status;
    self.timeLabel.text = [NSString stringWithFormat:@"活动结束时间:%@",[self timeWithTimeIntervalString:item.enter_end_time]];
}

- (NSString *)timeWithTimeIntervalString:(NSString *)aTimeString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[aTimeString doubleValue]];
    NSLog(@"%@",date);// 这个时间是格林尼治时间
    NSString *dat = [formatter stringFromDate:date];
    NSLog(@"%@", dat);// 这个时间是北京时间
    return dat;
}
@end
