//
//  CrowdFundCommentListCell.m
//  ONLY
//
//  Created by Dylan on 23/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "CrowdFundCommentListCell.h"

@implementation CrowdFundCommentListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setItem:(CommentItem *)item{
    _item = item;
    
    self.nameLabel.text = item.member_name;
    self.timeLabel.text = [self timeWithTimeIntervalString:item.comment_time];
    self.contentLabel.text = item.comment_content;
    self.starView.commentPoint = item.comment_star;
    
    [self.headIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,item.portrait]]];
    
    for (int i = 0; i<item.comment_img.count; i++) {
        __weak UIImageView * imageView = self.photoArray[i];
        [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,item.comment_img[i]]]];
    }
    
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
