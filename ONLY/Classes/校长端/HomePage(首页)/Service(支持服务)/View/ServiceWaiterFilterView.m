//
//  ServiceWaiterFilterView.m
//  ONLY
//
//  Created by Dylan on 27/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "ServiceWaiterFilterView.h"
#import "FilterCollectionViewCell.h"
#import "FilterHeaderCollectionReusableView.h"


@interface ServiceWaiterFilterView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong)FilterItem * choosedItem;

@end

@implementation ServiceWaiterFilterView
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
            self.choosedItem.isSelected = NO;
            self.btnAction_block(sender.tag,@"0");
        }
    }else if (sender.tag == 4){//确定
        if (self.btnAction_block) {
            self.btnAction_block(sender.tag,self.choosedItem.type_id);
        }
    }
}

#pragma mark - UICollectionViewDelegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FilterCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FilterCollectionViewCell" forIndexPath:indexPath];
    
    FilterItem * item = self.dataArray[indexPath.row];
    
    cell.item = item;
    
    if (item.isSelected) {
        self.choosedItem = item;
    }
    
    return cell;
    
}


//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    
//    FilterHeaderCollectionReusableView * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"FilterHeaderCollectionReusableView" forIndexPath:indexPath];
//    
//    return view;
//    
//}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    FilterItem * item = self.dataArray[indexPath.row];
    self.choosedItem.isSelected = NO;
    item.isSelected = YES;
    self.choosedItem = item;
    
    [collectionView reloadData];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end

