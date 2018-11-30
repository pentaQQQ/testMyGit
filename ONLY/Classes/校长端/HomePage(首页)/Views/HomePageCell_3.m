//
//  HomePageCell_3.m
//  ONLY
//
//  Created by Dylan on 11/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "HomePageCell_3.h"

@interface HomePageCell_3()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation HomePageCell_3

@synthesize dataArray = _dataArray;

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
-(void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    [self.collectionView reloadData];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomePageCollectionCell" bundle:nil] forCellWithReuseIdentifier:@"HomePageCollectionCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomePageCollectionCell_2" bundle:nil] forCellWithReuseIdentifier:@"HomePageCollectionCell_2"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"HomePageCollectionCell_3" bundle:nil] forCellWithReuseIdentifier:@"HomePageCollectionCell_3"];
//    self.collectionViewHeightConstraint.constant = 280*SCREEN_PRESENT;
//    [self layoutIfNeeded];
    
    
    UICollectionViewFlowLayout * layout =(UICollectionViewFlowLayout*) self.collectionView.collectionViewLayout;
    if (self.indexPath.section == 2) {
        layout.itemSize = CGSizeMake(275, 280);
        self.collectionViewHeightConstraint.constant = 280;
    }else if (self.indexPath.section == 3){
        layout.itemSize = CGSizeMake(275, 250);
        self.collectionViewHeightConstraint.constant = 250;
    }else{
        layout.itemSize = CGSizeMake(275, 220);
        self.collectionViewHeightConstraint.constant = 220;
    }
    
    
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    UICollectionViewFlowLayout * layout =(UICollectionViewFlowLayout*) self.collectionView.collectionViewLayout;
    if (self.indexPath.section == 2) {
        layout.itemSize = CGSizeMake(275, 280);
        self.collectionViewHeightConstraint.constant = 280;
    }else if (self.indexPath.section == 3){
        layout.itemSize = CGSizeMake(275, 250);
        self.collectionViewHeightConstraint.constant = 250;
    }else{
        layout.itemSize = CGSizeMake(275, 220);
        self.collectionViewHeightConstraint.constant = 220;
    }

    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.indexPath.section == 2) {
        HomePageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomePageCollectionCell" forIndexPath:indexPath];
        CrowdFundItem * item = self.dataArray[indexPath.row];
        cell.crowdFundItem = item;
        return cell;
    }
    else if (self.indexPath.section == 3) {
        HomePageCollectionCell_2 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomePageCollectionCell_2" forIndexPath:indexPath];
        ConferenceItem * item = self.dataArray[indexPath.row];
        cell.conferenceItem = item;
        return cell;
    }
    else if (self.indexPath.section == 4) {
        HomePageCollectionCell_3 *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomePageCollectionCell_3" forIndexPath:indexPath];
        ServiceItem * item = self.dataArray[indexPath.row];
        cell.serviceItem = item;
        return cell;
    }
    else{
        return nil;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    TSOOProductItem * item = self.allSimilarProducts[indexPath.row];
//    [self.delegate similarItemClicked:item];
    if (self.indexPath.section == 2) {
        CrowdFundItem * item = self.dataArray[indexPath.row];

        if (self.btnAction_block) {
            self.btnAction_block(item);
        }
    }
    
    if (self.indexPath.section == 3) {
        ConferenceItem * item = self.dataArray[indexPath.row];
        if (self.btnAction_block) {
            self.btnAction_block(item);
        }

    }
    if (self.indexPath.section == 4) {
        ServiceItem * item = self.dataArray[indexPath.row];
        if (self.btnAction_block) {
            self.btnAction_block(item);
        }
    }
}


@end
