//
//  NewsListCollectionViewCell.h
//  ONLY
//
//  Created by Dylan on 01/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsListCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconIV;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIView *badgeBG;
@property (weak, nonatomic) IBOutlet UILabel *badgeLabel;


@end
