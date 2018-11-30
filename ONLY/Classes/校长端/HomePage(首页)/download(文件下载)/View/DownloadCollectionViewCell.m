//
//  DownloadCollectionViewCell.m
//  ONLY
//
//  Created by Dylan on 21/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "DownloadCollectionViewCell.h"

@implementation DownloadCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setItem:(DownLoadItem *)item{
    _item = item;
    self.titleLabel.text = item.name;
    self.timeLabel.text = [self timeWithTimeIntervalString:item.add_time];
    if (item.iconUrl.length>0) {
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,item.iconUrl]]];
    }
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
