//
//  DownloadController.m
//  ONLY
//
//  Created by Dylan on 21/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "DownloadController.h"
#import "HMSegmentedControl.h"
#import "DownloadDetailController.h"
#import "DownloadCollectionViewCell.h"

#import "FilterView.h"

#import "DownLoadItem.h"
#import "FilterItem.h"

#import "UIViewController+HUD.h"

@interface DownloadController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic, strong)UICollectionView * collectionView;
@property(nonatomic, strong)HMSegmentedControl * segmentControl;
@property(nonatomic, strong)NSMutableArray * dataArray;
@property(nonatomic, strong)NSMutableArray * filterArray;
@property(nonatomic, assign)NSInteger pageIndex;
@property(nonatomic, strong)NSString * sortType;
@property(nonatomic, strong)NSString * type_id;
@end

@implementation DownloadController{
    UIView * _segmentBGView;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
-(NSMutableArray *)filterArray{
    if (!_filterArray) {
        _filterArray = [NSMutableArray new];
    }
    return _filterArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
    [self setupNavi];
    [self setupUI];
    [self getData];
}
-(void)commonInit{
    self.pageIndex = 1;
    self.sortType = @"0";
    self.type_id = @"0";
}
-(void)setupNavi{
    self.title = @"文件下载";
    kWeakSelf(self);
    UIButton * filterBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 44)];
    [filterBtn setImage:[UIImage imageNamed:@"产品众筹_filter"] forState:UIControlStateNormal];
    [filterBtn jk_addActionHandler:^(NSInteger tag) {
        NSLog(@"filterItem");
        FilterView * filterView = [[[NSBundle mainBundle]loadNibNamed:@"FilterView" owner:nil options:nil]firstObject];
        [filterView setDataBlock:^(FilterView * filterView) {
            filterView.dataArray = weakself.filterArray;
            [filterView.collectionView reloadData];
        }];
        [filterView setBtnAction_block:^(NSInteger index,NSString * type_id,NSString * support_id) {
            weakself.type_id = type_id;
            [weakself reloadData];
        }];
        [filterView show];
    }];
    UIBarButtonItem * filterItem = [[UIBarButtonItem alloc]initWithCustomView:filterBtn];
    
    self.navigationItem.rightBarButtonItems = @[filterItem];

    
    
}

-(void)setupUI{
    self.view.backgroundColor = colorWithRGB(0xf6f7fb);
    
    [self setupSegment];
    [self setupTableView];
}

-(void)setupSegment{
    _segmentBGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenHeight(), 60)];
    _segmentBGView.backgroundColor = AppNaviBackColor;
    self.segmentControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH-10, 50)];
    
    self.segmentControl.sectionTitles = @[@"总部文件下载区", @"分校文件共享区"];
    self.segmentControl.selectedSegmentIndex = 0;
    self.segmentControl.backgroundColor = [UIColor clearColor];
    self.segmentControl.titleTextAttributes = @{NSForegroundColorAttributeName : kRGBColor(191,221,233),NSFontAttributeName:[UIFont systemFontOfSize:16]};
    self.segmentControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.segmentControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.segmentControl.selectionIndicatorColor = [UIColor whiteColor];
    self.segmentControl.selectionIndicatorHeight = 1;
    self.segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentControl.selectionIndicatorBoxOpacity = 1;
    __weak typeof(self) weakSelf = self;
    [self.segmentControl setIndexChangeBlock:^(NSInteger index) {
        if (index == 0) {
            weakSelf.sortType = @"0";
        }else{
            weakSelf.sortType = @"1";
        }
        [weakSelf reloadData];
    }];
    
    [_segmentBGView addSubview:self.segmentControl];
    [self.view addSubview:_segmentBGView];
}


-(void)setupTableView{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = CGSizeMake((screenWidth()-50)/2, (screenWidth()-40)/2);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(16, 16, 16, 16);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    kWeakSelf(self);
    self.collectionView.backgroundColor = AppBackColor;
    
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself reloadData];
    }];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakself getData];
    }];
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_segmentBGView.mas_bottom).mas_equalTo(0);
        make.left.bottom.right.equalTo(self.view);
    }];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"DownloadCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"DownloadCollectionViewCell"];
}

-(void)reloadData{
    self.pageIndex = 1;
//    [self.collectionView reloadData];
    [self getData];
}

-(void)getData{
    NSDictionary * param = @{
                             @"type_id": self.type_id,
                             @"is_head": self.sortType,
                             @"page": @(self.pageIndex),
                             @"pageSize": @"10"
                             };
    [DataSourceTool downLoadTypeListWithParam:param toViewController:self success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"errcode"]integerValue]==0) {
            
            if (self.pageIndex==1) {
                [self.dataArray removeAllObjects];
                [self.collectionView.mj_header endRefreshing];
                [self.collectionView.mj_footer endRefreshing];
            }else{
                if (((NSArray*)json[@"data"]).count == 0) {
                    [self.collectionView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.collectionView.mj_footer endRefreshing];
                }
            }
            self.pageIndex++;
            
            
            for (NSDictionary * dic in json[@"list"]) {
                DownLoadItem * item = [DownLoadItem itemWithDic:dic];
                [self.dataArray addObject:item];
            }
            [self.collectionView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}

-(void)getFilterData{
    
    NSDictionary * param = @{
                             @"type":@"5"
                             };
    
    [DataSourceTool filterListWithParam:param toViewController:self success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"errcode"]integerValue]==0) {
            //            [json[@"data"][0]createPropertyCode];
            for (NSDictionary * dic in json[@"data"]) {
                FilterItem * item = [FilterItem itemWithDic:dic];
                [self.filterArray addObject:item];
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    DownloadCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"DownloadCollectionViewCell" forIndexPath:indexPath];
    DownLoadItem * item = self.dataArray[indexPath.row];
    cell.item = item;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    DownloadDetailController * vc = [DownloadDetailController new];
    DownLoadItem * item = self.dataArray[indexPath.row];
    vc.item = item;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
