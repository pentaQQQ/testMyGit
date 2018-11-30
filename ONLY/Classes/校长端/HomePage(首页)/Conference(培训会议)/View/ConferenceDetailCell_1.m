//
//  ConferenceDetailCell_1.m
//  ONLY
//
//  Created by Dylan on 16/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "ConferenceDetailCell_1.h"

@implementation ConferenceDetailCell_1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setItem:(ConferenceItem *)item{
    _item = item;
    self.titleLabel.text = item.course_title;
    self.priceLabel.text = item.unit_price;
    self.enrollTimeLabel.text = [NSString stringWithFormat:@"%@-%@",item.enter_start_time,item.enter_end_time];
    self.checkInTimeLabel.text = [NSString stringWithFormat:@"%@-%@",item.sign_time,item.sign_end_time];
    self.trainingTimeLabel.text = [NSString stringWithFormat:@"%@-%@",item.train_start_time,item.train_end_time];
    self.addressLabel.text = item.address;
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
