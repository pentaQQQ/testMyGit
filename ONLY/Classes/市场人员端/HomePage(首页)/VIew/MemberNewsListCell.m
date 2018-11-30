//
//  MemberNewsListCell.m
//  ONLY
//
//  Created by zfd on 17/1/14.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MemberNewsListCell.h"

@implementation MemberNewsListCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.time_mask_bg_view.layer.cornerRadius = 10.0f;
    self.content_view.layer.cornerRadius = 9.0f;
}

+(instancetype) memberNewsListCellWithTableview:(UITableView*) tableview
{
    static NSString* cellID = @"MemberNewsListCell";
    MemberNewsListCell* cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    if (!cell)
    {
        cell = (MemberNewsListCell*)[[NSBundle mainBundle] loadNibNamed:@"MemberNewsListCell" owner:nil options:nil][0];
    }
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}




@end
