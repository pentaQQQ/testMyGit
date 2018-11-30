//
//  ServiceController.m
//  ONLY
//
//  Created by Dylan on 16/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "ServiceController.h"
#import "ServiceDetailController.h"
#import "ServerViewController.h"
#import "NaviTitleView.h"
#import "NaviTitleSearchView.h"
#import "FilterView.h"
#import "ServiceListCell.h"
#import "HMSegmentedControl.h"
#import "Masonry.h"
#import "UIViewController+HUD.h"
#import "ServiceItem.h"
#import "UITableView+Sure_Placeholder.h"
#import "SearchController.h"
@interface ServiceController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)HMSegmentedControl * segmentControl;
@property(nonatomic,assign)ServiceType serviceType;
@property(nonatomic,strong)NSString * type_id;
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * filterArray;
@end

@implementation ServiceController{
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
-(id)init{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self commonInit];
    [self setupNavi];
    [self setupUI];
    [self getData];
    [self getFilterData];
}

-(void)commonInit{
    self.serviceType = ServiceType_Market;
    self.type_id = @"0";
    self.pageIndex = 1;
    self.keyword = @"";
}

-(void)setupNavi{
    self.navigationItem.titleView = [self titleView];
    kWeakSelf(self);
    
    UIButton * searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 44)];
    [searchBtn setImage:[UIImage imageNamed:@"产品众筹_Search"] forState:UIControlStateNormal];
    [searchBtn jk_addActionHandler:^(NSInteger tag) {
        [SearchController presentToSearchControllerWithContext:self type:SearchTypeRecruit];
    }];
    UIBarButtonItem * searchItem = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];
    
    
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
    
    
    if (self.isSearch) {
        self.navigationItem.rightBarButtonItems = @[filterItem];
    }else{
        self.navigationItem.rightBarButtonItems = @[searchItem,filterItem];
    }

    
}

-(UIView*)titleView{
    kWeakSelf(self);
    if (self.isSearch) {
        NaviTitleSearchView * titleView = [[[NSBundle mainBundle]loadNibNamed:@"NaviTitleSearchView" owner:nil options:nil]lastObject];
        [titleView.searchBtn setTitle:self.keyword forState:UIControlStateNormal];
        
        [titleView setBtnAction_block:^{
            [weakself.navigationController popViewControllerAnimated:YES]; 
        }];
        return titleView;
    }else{
        NaviTitleView * titleView = [[[NSBundle mainBundle]loadNibNamed:@"NaviTitleView" owner:nil options:nil]firstObject];
        titleView.titleLabel.text = @"服务支持";
        [titleView setBtnAction_block:^{
            ServerViewController * vc = [ServerViewController new];
            vc.idx = 0;
            [weakself presentViewController:vc animated:YES completion:nil];
        }];
        return titleView;

    }
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
    
    self.segmentControl.sectionTitles = @[@"市场", @"教学", @"培训", @"运营"];
    self.segmentControl.selectedSegmentIndex = self.serviceType;
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
            weakSelf.serviceType = ServiceType_Market;
        }else if (index == 1){
            weakSelf.serviceType = ServiceType_Education;
        }else if (index == 2){
            weakSelf.serviceType = ServiceType_Training;
        }else if (index == 3){
            weakSelf.serviceType = ServiceType_Operation;
        }
        [weakSelf reloadData];
    }];
    
    [_segmentBGView addSubview:self.segmentControl];
    [self.view addSubview:_segmentBGView];
}


-(void)setupTableView{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.firstReload = YES;
    kWeakSelf(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself reloadData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakself getData];
    }];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_segmentBGView.mas_bottom);
        make.left.bottom.right.equalTo(self.view);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ServiceListCell" bundle:nil] forCellReuseIdentifier:@"ServiceListCell"];
}

-(void)reloadData{
    kWeakSelf(self);
    weakself.pageIndex = 1;
    [weakself getData];
}

-(void)getData{
    
    NSDictionary * param = @{
                             @"type_id": self.type_id,
                             @"service_type": @(self.serviceType),
                             @"page": @(self.pageIndex),
                             @"pageSize": @"6",
                             @"keywords": self.keyword
                             };
    [DataSourceTool serviceListWithParam:param toViewController:self success:^(id json) {
        NSLog(@"%@",json);
//        [json[@"list"][0] createPropertyCode];
        if ([json[@"errcode"] integerValue]==0) {
            if (self.pageIndex==1) {
                [self.dataArray removeAllObjects];
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
            }else{
                if (((NSArray*)json[@"list"]).count == 0) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.tableView.mj_footer endRefreshing];
                }
            }
            self.pageIndex++;
            
            for (NSDictionary * dic in json[@"list"]) {
                ServiceItem * item = [ServiceItem new];
                [item setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:item];
            }
            [self.tableView reloadData];
        }else{
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];

        }

    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

-(void)getFilterData{
    
    NSDictionary * param = @{
                             @"type":@"2"
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


#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ServiceListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ServiceListCell"];
    ServiceItem * item = self.dataArray[indexPath.row];
    cell.item = item;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ServiceItem * item = self.dataArray[indexPath.row];
    ServiceDetailController * vc = [ServiceDetailController new];
    vc.item = item;
    [self.navigationController pushViewController:vc animated:YES];
}

@end

