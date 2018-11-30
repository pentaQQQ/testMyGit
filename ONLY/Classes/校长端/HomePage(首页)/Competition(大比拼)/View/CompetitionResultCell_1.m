//
//  CompetitionResultCell_1.m
//  ONLY
//
//  Created by Dylan on 23/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "CompetitionResultCell_1.h"

@implementation CompetitionResultCell_1

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setItem:(CandidateItem *)item{
    _item = item;
    [self.portraitIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,item.member_portrait]]];
    self.nameLabel.text = item.name;
    self.greatCountLabel.text = item.vote_count;
    self.briefLabel.text = item.brief;
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
