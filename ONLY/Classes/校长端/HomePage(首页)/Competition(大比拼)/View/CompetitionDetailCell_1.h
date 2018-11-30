//
//  CompetitionDetailCell_1.h
//  ONLY
//
//  Created by Dylan on 14/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CompetitionItem.h"
@interface CompetitionDetailCell_1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityBeginTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *enrollEndTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *voteEndTimeLabel;


@property (nonatomic,strong)CompetitionItem * item;
@end
