//
//  FilterCollectionViewCell.h
//  ONLY
//
//  Created by Dylan on 14/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterItem.h"
@interface FilterCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@property (nonatomic,strong)FilterItem * item;

@end
