//
//  ConferenceCell.m
//  ONLY
//
//  Created by Dylan on 14/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "ConferenceCell.h"

@implementation ConferenceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    CGAffineTransform transform=CGAffineTransformMakeRotation(0.78);
    self.statusLabel.transform = transform;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setItem:(ConferenceItem *)item{
    _item = item;
    [self.photoIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,item.course_img]]];
    self.titleLabel.text = item.course_title;
    self.priceLabel.text = [NSString stringWithFormat:@"%@",item.unit_price];
    self.locationLabel.text = item.location;
    self.countLabel.text = item.enter_count;
    self.timeLabel.text = [self getNowTimeWithString:item.enter_end_time];
}


-(NSString *)getNowTimeWithString:(NSString *)aTimeString{
    
    
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 截止时间date格式
    NSDate  *expireDate = [NSDate dateWithTimeIntervalSince1970:[aTimeString doubleValue]];
    NSDate  *nowDate = [NSDate date];
    
    NSTimeInterval timeInterval =[expireDate timeIntervalSinceDate:nowDate];
    
    int days = (int)(timeInterval/(3600*24));
    int hours = (int)((timeInterval-days*24*3600)/3600);
    int minutes = (int)(timeInterval-days*24*3600-hours*3600)/60;
    int seconds = timeInterval-days*24*3600-hours*3600-minutes*60;
    
    NSString *dayStr;NSString *hoursStr;NSString *minutesStr;NSString *secondsStr;
    //天
    dayStr = [NSString stringWithFormat:@"%d",days];
    //小时
    hoursStr = [NSString stringWithFormat:@"%d",hours];
    //分钟

    if (hours<=0&&minutes<=0&&seconds<=0) {
        return @"活动已经结束！";
    }
    if (days) {
        return [NSString stringWithFormat:@"%@天后截止", dayStr];
    }
    return [NSString stringWithFormat:@"%@小时后截止",hoursStr];
}

@end
