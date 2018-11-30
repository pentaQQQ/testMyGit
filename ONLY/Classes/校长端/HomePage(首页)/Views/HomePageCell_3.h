//
//  HomePageCell_3.h
//  ONLY
//
//  Created by Dylan on 11/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomePageCell_1.h"
#import "HomePageCollectionCell.h"
#import "HomePageCollectionCell_2.h"
#import "HomePageCollectionCell_3.h"

@interface HomePageCell_3 : UITableViewCell
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeightConstraint;

@property(nonatomic,copy) void (^btnAction_block)(id item);

@property(nonatomic,strong)NSIndexPath * indexPath;
@property(nonatomic,strong)NSMutableArray * dataArray;

@end
