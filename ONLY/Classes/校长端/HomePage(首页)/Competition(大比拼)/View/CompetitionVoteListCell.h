//
//  CompetitionVoteListCell.h
//  ONLY
//
//  Created by Dylan on 15/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CandidateItem.h"
@interface CompetitionVoteListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *portraitIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *greatCountLabel;

@property(nonatomic,strong)CandidateItem * item;
@property(nonatomic,copy)void (^vote_block)(CandidateItem*item);
@end
