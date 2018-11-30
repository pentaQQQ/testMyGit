//
//  IdeaDetailHeadView.h
//  ONLY
//
//  Created by Dylan on 15/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IdeaItem.h"
@interface IdeaDetailHeadView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (nonatomic,strong)IdeaItem * item;
@end
