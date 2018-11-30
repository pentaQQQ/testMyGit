//
//  HomePageCollectionCell_2.m
//  ONLY
//
//  Created by Dylan on 17/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "HomePageCollectionCell_2.h"

@implementation HomePageCollectionCell_2

- (void)awakeFromNib {
    [super awakeFromNib];
    CGAffineTransform transform=CGAffineTransformMakeRotation(0.78);
    self.statusLabel.transform = transform;
}

-(void)setConferenceItem:(ConferenceItem *)conferenceItem{
    _conferenceItem = conferenceItem;
    self.bottomFirstLabel.hidden = NO;
    self.bottomSecondLabel.hidden = NO;
    self.bottomThirdLabel.hidden = NO;
    self.bottomFirstIV.hidden = NO;
    self.bottomSecondIV.hidden = NO;
    self.bottomThirdIV.hidden = NO;

    
    [self.photoIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,conferenceItem.course_img]]];
    self.titleLabel.text = conferenceItem.course_title;
    self.priceTitleLabel.text = @"会务费";
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",conferenceItem.unit_price];
    
    self.bottomFirstIV.image = [UIImage imageNamed:@"会议培训_addr"];
    self.bottomSecondIV.image = [UIImage imageNamed:@"支持服务_人员列表_mine"];
    self.bottomThirdIV.image = [UIImage imageNamed:@"产品众筹_列表_darktime"];
    
    self.bottomFirstLabel.text = conferenceItem.location;
    self.bottomSecondLabel.text = conferenceItem.count;
    self.bottomThirdLabel.text =  [self getNowTimeWithString:conferenceItem.train_end_time];
    
    
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
    if(minutes<10)
        minutesStr = [NSString stringWithFormat:@"0%d",minutes];
    else
        minutesStr = [NSString stringWithFormat:@"%d",minutes];
    //秒
    if(seconds < 10)
        secondsStr = [NSString stringWithFormat:@"0%d", seconds];
    else
        secondsStr = [NSString stringWithFormat:@"%d",seconds];
    if (hours<=0&&minutes<=0&&seconds<=0) {
        return @"活动已经结束！";
    }
    if (days) {
        return [NSString stringWithFormat:@"%@天%@小时%@分", dayStr,hoursStr, minutesStr];
    }
    return [NSString stringWithFormat:@"%@小时 %@分 %@秒",hoursStr , minutesStr,secondsStr];
}


@end
