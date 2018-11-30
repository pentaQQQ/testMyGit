//
//  HomePageCollectionCell_3.h
//  ONLY
//
//  Created by Dylan on 17/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ServiceItem.h"
@interface HomePageCollectionCell_3 : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoIV;
@property (weak, nonatomic) IBOutlet UIImageView *statusIV;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomFirstLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomSecondLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomThirdLabel;
@property (weak, nonatomic) IBOutlet UIImageView *bottomFirstIV;
@property (weak, nonatomic) IBOutlet UIImageView *bottomSecondIV;
@property (weak, nonatomic) IBOutlet UIImageView *bottomThirdIV;

@property(nonatomic,strong)ServiceItem * serviceItem;

@end
