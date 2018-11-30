//
//  HomePageCollectionCell.m
//  ONLY
//
//  Created by Dylan on 11/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "HomePageCollectionCell.h"
@interface HomePageCollectionCell()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *priceTitleLabelConstraint;
@end
@implementation HomePageCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    CGAffineTransformRotate(self.statusLabel.transform, 0.78);
    CGAffineTransform transform=CGAffineTransformMakeRotation(0.78);
    self.statusLabel.transform = transform;
}

-(void)setCrowdFundItem:(CrowdFundItem *)crowdFundItem{
    _crowdFundItem = crowdFundItem;
    
    self.bottomFirstLabel.hidden = NO;
    self.bottomSecondLabel.hidden = NO;
    self.bottomThirdLabel.hidden = NO;
    self.bottomFirstIV.hidden = NO;
    self.bottomSecondIV.hidden = NO;
    self.bottomThirdIV.hidden = NO;
    self.percentPV.hidden = NO;
    self.percentLabel.hidden = NO;
    


    self.titleLabel.text = crowdFundItem.good_name;
    
    [self.photoIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,crowdFundItem.picture]] placeholderImage:[UIImage imageNamed:@"图层59"]];
    self.priceLabel.text = [NSString stringWithFormat:@"%@/%@",crowdFundItem.unit_price,crowdFundItem.good_unit];
    
    self.bottomFirstIV.image = [UIImage imageNamed:@"HomePage_time"];
    self.bottomFirstLabel.text = [self getNowTimeWithString:crowdFundItem.endTime];
    
    self.bottomSecondIV.image = [UIImage imageNamed:@"HomePage_great"];
    self.bottomSecondLabel.text = crowdFundItem.goods_count;
    
    self.bottomSecondIV.hidden = NO;
    self.bottomSecondLabel.hidden = NO;
    self.bottomThirdIV.hidden = YES;
    self.bottomThirdLabel.hidden = YES;
    
    CGFloat percent = 0.0;
    NSArray * count = self.crowdFundItem.crowd_price[@"count"];
    if ([self.crowdFundItem.status integerValue] == 0) {
        self.statusLabel.text = @"征询中";
    }
    else if ([self.crowdFundItem.status integerValue] == 1) {
        percent = [crowdFundItem.goods_count floatValue]/[crowdFundItem.expect_count floatValue];
        self.priceTitleLabel.text = @"市场参考价:";
        self.statusLabel.text = @"进行中";
    }
    else if ([self.crowdFundItem.status integerValue] == 3){
        percent = [crowdFundItem.crowd_num floatValue]/[count[0] floatValue];
        self.priceTitleLabel.text = @"预订价:";
        self.statusLabel.text = @"已结束";
    }
    
    
    self.percentLabel.text = [NSString stringWithFormat:@"%.0f%%",percent*100];
    self.percentPV.progress = percent;
    
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
