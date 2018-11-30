//
//  FilterView.h
//  ONLY
//
//  Created by Dylan on 14/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterItem.h"
@interface FilterView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *bgBtn;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewTrailingConstraints;

@property (nonatomic,strong) NSMutableArray * dataArray;

@property (nonatomic, copy) void (^dataBlock)(FilterView * filterView);

@property (nonatomic, copy) void (^btnAction_block)(NSInteger index,NSString * type_id,NSString * support_id);


-(void)show;
-(void)dismiss;
@end
