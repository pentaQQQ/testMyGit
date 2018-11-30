//
//  NewsListCell_2.h
//  ONLY
//
//  Created by Dylan on 16/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsItem.h"
@interface NewsListCell_2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailTitleLabel_1;
@property (weak, nonatomic) IBOutlet UILabel *detailTitleLabel_2;
@property (weak, nonatomic) IBOutlet UILabel *detailTitleLabel_3;
@property (weak, nonatomic)IBOutlet UILabel * detailLabel_1;
@property (weak, nonatomic)IBOutlet UILabel * detailLabel_2;
@property (weak, nonatomic)IBOutlet UILabel * detailLabel_3;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (nonatomic,strong)NewsItem * item;
@end
