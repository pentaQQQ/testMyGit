//
//  IdeaCell.h
//  ONLY
//
//  Created by Dylan on 21/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IdeaItem.h"
@interface IdeaCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnailIV;
@property (weak, nonatomic) IBOutlet UIView *statusBgView;
@property (weak, nonatomic) IBOutlet UIImageView *statusIV;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *greatCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@property(nonatomic,strong)IdeaItem * item;
@end
