//
//  CompetitionDetailCell_1.m
//  ONLY
//
//  Created by Dylan on 14/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "CompetitionDetailCell_1.h"

@implementation CompetitionDetailCell_1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setItem:(CompetitionItem *)item{
    _item = item;
    self.descriptionLabel.text = item.match_brief;
    self.activityBeginTimeLabel.text = [self timeWithTimeIntervalString:item.start_time];
    self.enrollEndTimeLabel.text = [self timeWithTimeIntervalString:item.enter_end_time];
    self.voteEndTimeLabel.text = [self timeWithTimeIntervalString:item.vote_end_time];
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
