//
//  DropMenuView.m
//  DorpMenuView
//
//  Created by George on 16/11/18.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import "DropMenuView.h"
#import "DropMenuHeaderReusableView.h"
#import "DropMenuCollectionViewCell.h"

#define menuHeight 44
#define lineHeight 2

@interface DropMenuView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    CGFloat itemWidth;
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionView *dropCollectionView;
@property (nonatomic, strong) UIView *downLine; //红色下滑线
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIView *displayView;
@property (nonatomic, strong) UIButton *dropButton;
//@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, assign) NSInteger selectedIndex;
@end

@implementation DropMenuView

-(instancetype)init {
    self = [super init];
    if (self) {
        
//        self.dataSource = @[@"全部", @"护肤", @"彩妆", @"时尚", @"家居", @"母婴", @"个人护理", @"家庭清洁"];
//        self.dataSource = @[@"全部", @"护肤", @"彩妆"];
        self.selectedIndex = 0;
        
        itemWidth = [UIScreen mainScreen].bounds.size.width/5.0;
        self.backgroundColor = colorWithRGB(0xe6e6e6);
        
        [self.collectionView registerClass:[DropMenuCollectionViewCell class] forCellWithReuseIdentifier:@"cellId1"];
        [self.dropCollectionView registerClass:[DropMenuCollectionViewCell class] forCellWithReuseIdentifier:@"cellId2"];
        [self.dropCollectionView registerClass:[DropMenuHeaderReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView"];
        
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
        self.dropCollectionView.delegate = self;
        self.dropCollectionView.dataSource = self;
        
        [self addSubview:self.collectionView];
        [self.collectionView addSubview:self.downLine];
        [self insertSubview:self.dropButton atIndex:3];
    }
    return self;
}


-(void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = CGRectMake(0, 0, self.frame.size.width-40, self.frame.size.height-0.5);
    self.downLine.frame = CGRectMake(0, menuHeight-lineHeight, itemWidth, lineHeight);
    self.dropButton.frame = CGRectMake(self.frame.size.width-40, 0, 40, self.frame.size.height-0.5);
    self.maskView.frame = self.superview.bounds;
    self.displayView.frame = CGRectMake(0, menuHeight*(ceilf(self.dataSource.count/4.0)+1)+10, self.frame.size.width, self.superview.bounds.size.height);
    self.dropCollectionView.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 44*(ceilf(self.dataSource.count)+1));
}


-(void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    [self.collectionView reloadData];
    [self.dropCollectionView reloadData];
}

-(UIView *)maskView {
    if (_maskView == nil) {
        _maskView = [UIView new];
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        self.displayView = ({
            UIView *view = [UIView new];
//            view.backgroundColor = [UIColor yellowColor];
            [view jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
                [self shrinkageCollectionViewWithAnimation:YES complete:nil];
            }];
            [_maskView addSubview:view];
            
            view;
        });
    }
    return _maskView;
}

-(UIView *)downLine {
    if (_downLine == nil) {
        _downLine = [UIView new];
        _downLine.backgroundColor = [UIColor redColor];
    }
    return _downLine;
}

-(UIButton *)dropButton {
    if (_dropButton == nil) {
        _dropButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dropButton setImage:[UIImage imageNamed:@"market_down_arrow"] forState:UIControlStateNormal];
        [_dropButton jk_setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _dropButton.tag = 10;
        [_dropButton addTarget:self action:@selector(dropButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dropButton;
}

-(void)dropButtonClicked:(UIButton *)button {
    
    if (button.tag == 10) {
        
        [self.superview insertSubview:self.maskView atIndex:3];
        [self.maskView addSubview:self.dropCollectionView];
        [self expandWithCollectionView:self.frame.size.height*(ceilf(self.dataSource.count/4.0)+1)];
        
    }
    else {
        [self shrinkageCollectionViewWithAnimation:YES complete:nil];
    }
}

-(UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

-(UICollectionView *)dropCollectionView {
    if (_dropCollectionView == nil) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _dropCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _dropCollectionView.delegate = self;
        _dropCollectionView.dataSource = self;
        _dropCollectionView.backgroundColor = [UIColor whiteColor];
    }
    return _dropCollectionView;
}



#pragma mark - collectionView 的代理方法
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if ([collectionView isEqual:self.dropCollectionView]) {
        return CGSizeMake(self.frame.size.width, 44);
    }
    else {
        return CGSizeZero;
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:self.dropCollectionView]) {
        DropMenuHeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
        headerView.DropMenuHeaderButtonClickedBlock = ^() {
            [self shrinkageCollectionViewWithAnimation:YES complete:^{
                if (self.dataSource.count>0) {
                    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
                }
                
            }];
        };
        return headerView;
    }
    else {
        return nil;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([collectionView isEqual:self.collectionView]) {
        return CGSizeMake(itemWidth, self.frame.size.height);
    } else {
        return CGSizeMake(self.frame.size.width*0.25, self.frame.size.height);
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if ([collectionView isEqual:self.collectionView]) {
        
        static NSString *identifier = @"cellId1";
        DropMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        cell.textLabel.text = self.dataSource[indexPath.row]; //@"全部";
        cell.underLine.hidden = indexPath.row == self.selectedIndex ? NO : YES;
        
        cell.underLine.hidden = [collectionView isEqual:self.collectionView] ? YES : NO;
        
        return cell;
        
    }
    else {
        
        static NSString *identifier = @"cellId2";
        DropMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];

        cell.textLabel.text = self.dataSource[indexPath.row];
        cell.underLine.hidden = indexPath.row == self.selectedIndex ? NO : YES;
        [cell displaySeparator];
        
        return cell;
    }
    
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedIndex = indexPath.row;
    if ([collectionView isEqual:self.collectionView]) {
        NSLog(@"点击了横向滚动的第%ld", indexPath.row);

        [UIView animateWithDuration:0.5 animations:^{
            self.downLine.frame = CGRectMake(indexPath.row*itemWidth, menuHeight-lineHeight, itemWidth, lineHeight);
        }];
        
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    } else {
        NSLog(@"点击了纵向滚动的第%ld", indexPath.row);

        [self shrinkageCollectionViewWithAnimation:NO complete:^{
            [UIView animateWithDuration:0.5 animations:^{
                self.downLine.frame = CGRectMake(indexPath.row*itemWidth, menuHeight-lineHeight, itemWidth, lineHeight);
            }];
            [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }];
    }
}


//扩展
-(void)expandWithCollectionView:(CGFloat)collectionViewHeight {
    
    self.dropCollectionView.frame = CGRectMake(self.dropCollectionView.frame.origin.x, self.dropCollectionView.frame.origin.y, self.dropCollectionView.frame.size.width, self.frame.size.height);
    self.maskView.alpha = 0;
    [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.dropCollectionView.frame = CGRectMake(self.dropCollectionView.frame.origin.x, self.dropCollectionView.frame.origin.y, self.dropCollectionView.frame.size.width, collectionViewHeight);
        self.maskView.alpha = 1;
        
    } completion:^(BOOL finished) {
        
    }];
}

//收缩
-(void)shrinkageCollectionViewWithAnimation:(BOOL)animation complete:(void(^)())completeBlock {
    CGFloat duration = animation ? 0.5 : 0;
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.dropCollectionView.frame = CGRectMake(self.dropCollectionView.frame.origin.x, self.dropCollectionView.frame.origin.y, self.dropCollectionView.frame.size.width, self.frame.size.height);
        self.maskView.alpha = 0;
        
    } completion:^(BOOL finished) {
        [self.maskView removeFromSuperview];
        if (completeBlock) {
            completeBlock();
        }
    }];
}

@end
























