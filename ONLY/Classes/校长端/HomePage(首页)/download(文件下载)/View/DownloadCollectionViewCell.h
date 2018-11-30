//
//  DownloadCollectionViewCell.h
//  ONLY
//
//  Created by Dylan on 21/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownLoadItem.h"
@interface DownloadCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property(nonatomic,strong)DownLoadItem * item;
@end
