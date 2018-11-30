//
//  NewsListCell.h
//  ONLY
//
//  Created by Dylan on 13/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnlyNewsItem.h"
@interface NewsListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *photoIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (nonatomic,strong)OnlyNewsItem * item;
@end
