//
//  CompetitionResultCell_1.h
//  ONLY
//
//  Created by Dylan on 23/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CandidateItem.h"
@interface CompetitionResultCell_1 : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *portraitIV;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *greatCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *briefLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rankIV;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;

@property (nonatomic,strong)CandidateItem * item;
@end
