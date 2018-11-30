//
//  FilterView.m
//  ONLY
//
//  Created by Dylan on 14/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "FilterView.h"
#import "FilterCollectionViewCell.h"
#import "FilterHeaderCollectionReusableView.h"


@interface FilterView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)FilterItem * choosedItem_typeID;
@property(nonatomic,strong)FilterItem * choosedItem_supportID;


@end

@implementation FilterView
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self.collectionView registerNib:[UINib nibWithNibName:@"FilterCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"FilterCollectionViewCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"FilterHeaderCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FilterHeaderCollectionReusableView"];
    
    self.flowLayout.minimumInteritemSpacing = 10;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    CGFloat width = (self.collectionView.width-62)/3;
    self.flowLayout.itemSize = CGSizeMake(width, 30);
}

-(void)loadData{
    if (self.dataBlock) {
        self.dataBlock(self);
    }
}

- (void)show{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    
    self.contentViewTrailingConstraints.constant = -self.contentView.width;
    [self layoutIfNeeded];
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bgBtn.backgroundColor = colorWithRGBA(0x000000, 0.67);
        self.contentViewTrailingConstraints.constant = 0;
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        [self loadData];
    }];
}

-(void)dismiss{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        self.bgBtn.backgroundColor = colorWithRGBA(0x000000, 0.0);
        self.contentViewTrailingConstraints.constant = -self.contentView.width;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [weakSelf removeFromSuperview];
    }];
}

- (IBAction)btnClicked:(UIButton *)sender {
    [self dismiss];
    if (sender.tag == 3) {//重置
        if (self.btnAction_block) {
            self.choosedItem_typeID.isSelected = NO;
            self.choosedItem_supportID.isSelected = NO;
            self.btnAction_block(sender.tag,@"0",@"0");
        }
    }else if (sender.tag == 4){//确定
        if (self.btnAction_block) {
            if (self.choosedItem_typeID&&self.choosedItem_supportID) {
                self.btnAction_block(sender.tag,self.choosedItem_typeID.type_id,self.choosedItem_supportID.type_id);
            }else if (self.choosedItem_typeID){
                self.btnAction_block(sender.tag,self.choosedItem_typeID.type_id,@"0");
            }else if (self.choosedItem_supportID){
                self.btnAction_block(sender.tag,@"0",self.choosedItem_supportID.type_id);
            }else{
                self.btnAction_block(sender.tag,@"0",@"0");
            }
        }
    }
}

#pragma mark - UICollectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.dataArray.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    FilterItem * filterItem = self.dataArray[section];
    
    return filterItem.list.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FilterCollectionViewCell" forIndexPath:indexPath];

    FilterItem * filterItem = self.dataArray[indexPath.section];
    FilterItem * item = filterItem.list[indexPath.row];
    cell.item = item;
    
    if ([filterItem.name isEqualToString:@"学科类型"]) {
        if (item.isSelected) {
            self.choosedItem_typeID = item;
        }
    }
    if ([filterItem.name isEqualToString:@"培训类型"]) {
        if (item.isSelected) {
            self.choosedItem_supportID = item;
        }
    }

    
    return cell;
    
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    FilterHeaderCollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FilterHeaderCollectionReusableView" forIndexPath:indexPath];
    FilterItem * filterItem = self.dataArray[indexPath.section];
    view.titleLabel.text = filterItem.name;
    return view;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FilterItem * filterItem = self.dataArray[indexPath.section];
    FilterItem * item = filterItem.list[indexPath.row];
    if ([filterItem.name isEqualToString:@"学科类型"]) {
        self.choosedItem_typeID.isSelected = NO;
        item.isSelected = YES;
        self.choosedItem_typeID = item;
    }
    if ([filterItem.name isEqualToString:@"培训类型"]) {
        self.choosedItem_supportID.isSelected = NO;
        item.isSelected = YES;
        self.choosedItem_supportID = item;
    }
    
    [collectionView reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}

@end






