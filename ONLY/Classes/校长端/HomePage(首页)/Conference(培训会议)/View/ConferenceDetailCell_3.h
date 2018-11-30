//
//  ConferenceDetailCell_3.h
//  ONLY
//
//  Created by Dylan on 07/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeacherItem.h"
@interface ConferenceDetailCell_3 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (nonatomic,strong)TeacherItem * item;
@end
