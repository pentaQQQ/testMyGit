//
//  IdeaController.m
//  ONLY
//
//  Created by Dylan on 21/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "IdeaController.h"
#import "IdeaDetailController.h"
#import "IdeaRankingController.h"
#import "GoodIdeaController.h"
#import "NaviTitleView.h"
#import "NaviTitleSearchView.h"
#import "FilterView.h"
#import "IdeaCell.h"
#import "HMSegmentedControl.h"
#import "Masonry.h"
#import "IdeaItem.h"
#import "UIViewController+HUD.h"
#import "SearchController.h"
@interface IdeaController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)HMSegmentedControl * segmentControl;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * filterArray;
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,strong)NSString * type_id;
@property(nonatomic,strong)NSString * support_id;
@property(nonatomic,strong)NSString * sortType;

@end

@implementation IdeaController{
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
    [self setupNavi];
    [self setupUI];
    [self getData];
    [self getFilterData];
}

-(void)commonInit{
    self.sortType = @"comment";
    self.type_id = @"";
    self.support_id = @"";
    self.pageIndex = 1;
    self.keyword = @"";
}

-(void)setupNavi{
    self.navigationItem.titleView = [self titleView];
    kWeakSelf(self);
    
    UIButton * searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 44)];
    [searchBtn setImage:[UIImage imageNamed:@"产品众筹_Search"] forState:UIControlStateNormal];
    [searchBtn jk_addActionHandler:^(NSInteger tag) {
        [SearchController presentToSearchControllerWithContext:self type:SearchTypeIdea];
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
    
    self.navigationItem.rightBarButtonItems = @[searchItem,filterItem];
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
        titleView.titleLabel.text = @"金点子";
        [titleView setBtnAction_block:^{
            GoodIdeaController * vc = [GoodIdeaController new];
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
    __weak typeof(self) weakSelf = self;
    _segmentBGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth(), 60)];
    _segmentBGView.backgroundColor = AppNaviBackColor;
    
    UIButton * rankBtn = [UIButton new];
    [_segmentBGView addSubview:rankBtn];
    [rankBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(_segmentBGView).insets(UIEdgeInsetsMake(0, 5, 13, 20));
//        make.width.mas_equalTo(50);
    }];
    [rankBtn setTitle:@"排行榜" forState:UIControlStateNormal];
    rankBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [rankBtn setTitleColor:kRGBColor(191,221,233) forState:UIControlStateNormal];
    [rankBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [rankBtn jk_addActionHandler:^(NSInteger tag) {
        IdeaRankingController * vc = [IdeaRankingController new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    self.segmentControl = [[HMSegmentedControl alloc] initWithFrame:CGRectZero];
    [_segmentBGView addSubview:self.segmentControl];
    [self.segmentControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(_segmentBGView).insets(UIEdgeInsetsMake(0, 0, 10, 5));
        make.right.equalTo(rankBtn.mas_left);
    }];
    
    self.segmentControl.sectionTitles = @[@"评论最多", @"点赞最多", @"最新上线"];
    self.segmentControl.selectedSegmentIndex = 0;
    self.segmentControl.backgroundColor = [UIColor clearColor];
    self.segmentControl.titleTextAttributes = @{NSForegroundColorAttributeName : kRGBColor(191,221,233),NSFontAttributeName:[UIFont systemFontOfSize:16]};
    self.segmentControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.segmentControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.segmentControl.selectionIndicatorColor = [UIColor whiteColor];
    self.segmentControl.selectionIndicatorHeight = 1;
    self.segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentControl.selectionIndicatorBoxOpacity = 1;
    
    [self.segmentControl setIndexChangeBlock:^(NSInteger index) {
        if (index == 0) {
            weakSelf.sortType = @"comment";
            [weakSelf reloadData];
        }else if (index == 1){
            weakSelf.sortType = @"goods";
            [weakSelf reloadData];
        }else if (index == 2){
            weakSelf.sortType = @"time";
            [weakSelf reloadData];
        }else if (index == 3){
            IdeaRankingController * vc = [IdeaRankingController new];
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }
    }];
    
    
    [self.view addSubview:_segmentBGView];
}


-(void)setupTableView{
    kWeakSelf(self);
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 500;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.tableView setSeparatorColor:colorWithRGB(0xE3ECF0)];
    [self.view addSubview:self.tableView];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself reloadData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakself getData];
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_segmentBGView.mas_bottom);
        make.left.bottom.right.equalTo(self.view);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"IdeaCell" bundle:nil] forCellReuseIdentifier:@"IdeaCell"];
}

-(void)reloadData{
    kWeakSelf(self);
    weakself.pageIndex = 1;
    [weakself getData];
}

-(void)getData{
    kWeakSelf(self);
    NSDictionary * param = @{
                             @"sort":self.sortType,
                             @"inside":USERINFO.status,
                             @"support_id":self.support_id,
                             @"type_id":self.type_id,
                             @"page":@(self.pageIndex),
                             @"keywords": self.keyword
                             };
    [DataSourceTool ideaListWithParam:param toViewController:self success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"errcode"] integerValue]==0) {
            if (weakself.pageIndex==1) {
                [weakself.dataArray removeAllObjects];
                [weakself.tableView.mj_header endRefreshing];
                [weakself.tableView.mj_footer endRefreshing];
            }else{
                if (((NSArray*)json[@"rsp"]).count == 0) {
                    [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [weakself.tableView.mj_footer endRefreshing];
                }
            }
            weakself.pageIndex++;
            
            for (NSDictionary * dic in json[@"rsp"]) {
                IdeaItem * item = [IdeaItem new];
                [item setValuesForKeysWithDictionary:dic];
                [weakself.dataArray addObject:item];
            }
            [weakself.tableView reloadData];
        }else{
            [weakself.tableView.mj_header endRefreshing];
            [weakself.tableView.mj_footer endRefreshing];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
        [weakself.tableView.mj_header endRefreshing];
        [weakself.tableView.mj_footer endRefreshing];
    }];
}

-(void)getFilterData{
    kWeakSelf(self);
    NSDictionary * param = @{
                             @"type":@"3"
                             };
    
    [DataSourceTool filterListWithParam:param toViewController:weakself success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"errcode"]integerValue]==0) {
            for (NSDictionary * dic in json[@"data"]) {
                FilterItem * item = [FilterItem itemWithDic:dic];
                [weakself.filterArray addObject:item];
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
    IdeaCell * cell = [tableView dequeueReusableCellWithIdentifier:@"IdeaCell"];
    cell.statusBgView.hidden = YES;
    IdeaItem* item = self.dataArray[indexPath.row];
    cell.item = item;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    IdeaItem * item = self.dataArray[indexPath.row];
    IdeaDetailController * vc = [IdeaDetailController new];
    vc.item = item;
    [self.navigationController pushViewController:vc animated:YES];
}


@end
