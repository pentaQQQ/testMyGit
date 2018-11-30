//
//  NewsListCell_4.h
//  ONLY
//
//  Created by Dylan on 16/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsItem.h"
@interface NewsListCell_4 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (nonatomic,strong)NewsItem * item;
@end
