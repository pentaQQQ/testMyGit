//
//  CompetitionVoteListCell.m
//  ONLY
//
//  Created by Dylan on 15/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "CompetitionVoteListCell.h"

@implementation CompetitionVoteListCell

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
    self.descriptionLabel.text = item.brief;
    self.greatCountLabel.text = item.vote_count;
}


- (IBAction)btnClicked:(UIButton *)sender {
    if (self.vote_block) {
        self.vote_block(self.item);
    }
}

@end
