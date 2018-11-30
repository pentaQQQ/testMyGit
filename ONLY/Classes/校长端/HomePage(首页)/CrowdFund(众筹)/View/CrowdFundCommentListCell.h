//
//  CrowdFundCommentListCell.h
//  ONLY
//
//  Created by Dylan on 23/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentItem.h"
#import "WQLStarView.h"
@interface CrowdFundCommentListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet WQLStarView *starView;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *photoArray;

@property (nonatomic,strong)CommentItem * item;

@end
