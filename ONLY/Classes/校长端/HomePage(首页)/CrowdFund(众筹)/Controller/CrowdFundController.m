//
//  CrowdFundController.m
//  ONLY
//
//  Created by Dylan on 13/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "CrowdFundController.h"
#import "CrowdFundDetailController.h"
#import "AddViewController.h"

#import "NaviTitleView.h"
#import "NaviTitleSearchView.h"
#import "CrowdFundListCell.h"
#import "FilterView.h"

#import "CrowdFundItem.h"
#import "FilterItem.h"

#import "HMSegmentedControl.h"
#import "Masonry.h"
#import "UIViewController+HUD.h"
#import "CountDown.h"

#import "UITableView+Sure_Placeholder.h"
#import "SearchController.h"

@interface CrowdFundController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)HMSegmentedControl * segmentControl;
@property(nonatomic,assign)CrowdFundSortType sortType;
@property(nonatomic,assign)CrowdFundStatus status;
@property(nonatomic,strong)CountDown *countDown;
@property(nonatomic,strong)NSString *type_id;

@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * filterArray;
@property(nonatomic,strong)UIView * segmentBGView;
@property(nonatomic,strong)UIView * filterBGView;
@property(nonatomic,strong)UIButton * timeFilterBtn;
@property(nonatomic,strong)UIButton * hotFilterBtn;

@end

@implementation CrowdFundController

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
    self.sortType = CrowdFundSortType_Time;
    self.status = CrowdFundStatus_Requset;
    self.pageIndex = 1;
    self.type_id = @"0";
    self.keyword = @"";
    
    self.countDown = [[CountDown alloc] init];
    __weak __typeof(self) weakSelf= self;
//   //每分钟回调一次
    [self.countDown countDownWithPER_SECBlock:^{
//        NSLog(@"6");
        [weakSelf updateTimeInVisibleCells];
    }];
}


-(void)setupNavi{
    self.navigationItem.titleView = [self titleView];
    kWeakSelf(self);
    
    UIButton * searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 44)];
    [searchBtn setImage:[UIImage imageNamed:@"产品众筹_Search"] forState:UIControlStateNormal];
    [searchBtn jk_addActionHandler:^(NSInteger tag) {
        
      [SearchController presentToSearchControllerWithContext:self type:SearchTypeGoods];
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
        [titleView setBtnAction_block:^{
            AddViewController * vc = [AddViewController new];
            [weakself presentViewController:vc animated:YES completion:nil];
        }];
        return titleView;

    }
}


-(void)setupUI{
    self.view.backgroundColor = colorWithRGB(0xf6f7fb);
    
    [self setupSegment];
    [self setupFilterView];
    [self setupTableView];
    
}

-(void)setupSegment{
    _segmentBGView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenHeight(), 71)];
    _segmentBGView.backgroundColor = AppNaviBackColor ;
    self.segmentControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH-10, 37)];
    //    self.segmentControl.layer.cornerRadius = 3.f;
    //    self.segmentControl.layer.borderColor = AppWhiteColor.CGColor;
    //    self.segmentControl.layer.borderWidth = 1.f;
    //    self.segmentControl.borderWidth = 1.f;
    //    self.segmentControl.borderColor = [UIColor whiteColor];
    //    self.segmentControl.borderType = HMSegmentedControlBorderTypeTop|
    //    HMSegmentedControlBorderTypeLeft|
    //    HMSegmentedControlBorderTypeBottom|
    //    HMSegmentedControlBorderTypeRight;
    
    self.segmentControl.sectionTitles = @[@"征询中", @"众筹中", @"已结束"];
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
            weakSelf.status = CrowdFundStatus_Requset;
        }
        else if (index == 1){
            weakSelf.status = CrowdFundStatus_Progressing;
        }
        else{
            weakSelf.status = CrowdFundStatus_Finish;
        }
        [weakSelf reloadData];
    }];
    
    [_segmentBGView addSubview:self.segmentControl];
    [self.view addSubview:_segmentBGView];
}
-(void)setupFilterView{
    _filterBGView = [[UIView alloc]init];
    _filterBGView.backgroundColor = [UIColor whiteColor];
    _filterBGView.layer.cornerRadius = 5.f;
    _filterBGView.layer.shadowOpacity = 0.1;
    _filterBGView.layer.shadowColor = [UIColor blackColor].CGColor;
    _filterBGView.layer.shadowOffset = CGSizeMake(1, 1);
    
    [self.view addSubview:_filterBGView];
    [_filterBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 10, 0, 10));
        make.centerY.equalTo(_segmentBGView.mas_bottom);
        make.height.mas_equalTo(44);
    }];
    
    _timeFilterBtn = [[UIButton alloc]init];
    _timeFilterBtn.selected = YES;
    [_timeFilterBtn setTitle:@"时间排序" forState:UIControlStateNormal];
    [_timeFilterBtn setImage:[UIImage imageNamed:@"产品众筹_列表_time"] forState:UIControlStateNormal];
    [_timeFilterBtn setImage:[UIImage imageNamed:@"产品众筹_列表_time-activity"] forState:UIControlStateSelected];
    _timeFilterBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_timeFilterBtn setTitleColor:colorWithRGB(0xACACAD) forState:UIControlStateNormal];
    [_timeFilterBtn setTitleColor:colorWithRGB(0x008CCF) forState:UIControlStateSelected];
    kWeakSelf(self);
    [_timeFilterBtn jk_addActionHandler:^(NSInteger tag) {
        NSLog(@"时间排序");
        weakself.timeFilterBtn.selected = YES;
        weakself.hotFilterBtn.selected = NO;
        weakself.sortType = CrowdFundSortType_Time;
        [weakself reloadData];
        
    }];
    [_filterBGView addSubview:_timeFilterBtn];
    
    [_timeFilterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.equalTo(_filterBGView);
        make.width.equalTo(_filterBGView).multipliedBy(0.5);
    }];
    
    _hotFilterBtn = [[UIButton alloc]init];
    _hotFilterBtn.selected = NO;
    [_hotFilterBtn setTitle:@"热门排序" forState:UIControlStateNormal];
    [_hotFilterBtn setImage:[UIImage imageNamed:@"产品众筹_列表_hot"] forState:UIControlStateNormal];
    [_hotFilterBtn setImage:[UIImage imageNamed:@"产品众筹_列表_hot-activity"] forState:UIControlStateSelected];
    
    _hotFilterBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [_hotFilterBtn setTitleColor:colorWithRGB(0xACACAD) forState:UIControlStateNormal];
    [_hotFilterBtn setTitleColor:colorWithRGB(0x008CCF) forState:UIControlStateSelected];
    [_hotFilterBtn jk_addActionHandler:^(NSInteger tag) {
        NSLog(@"热门排序");
        weakself.timeFilterBtn.selected = NO;
        weakself.hotFilterBtn.selected = YES;
        weakself.sortType = CrowdFundSortType_Hot;
        [weakself reloadData];
    }];
    [_filterBGView addSubview:_hotFilterBtn];
    
    [_hotFilterBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.equalTo(_filterBGView);
        make.width.equalTo(_filterBGView).multipliedBy(0.5);
    }];
}

-(void)setupTableView{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
    kWeakSelf(self);
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself reloadData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakself getData];
    }];
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_filterBGView.mas_bottom).mas_equalTo(20);
        make.left.bottom.right.equalTo(self.view);
    }];
    self.tableView.firstReload = YES;
    [self.tableView registerNib:[UINib nibWithNibName:@"CrowdFundListCell" bundle:nil] forCellReuseIdentifier:@"CrowdFundListCell"];
}
-(void)reloadData{
    kWeakSelf(self);
    weakself.pageIndex = 1;
    [weakself getData];
}
-(void)getData{
    kWeakSelf(self);
    NSDictionary * param = @{
                             @"status":@(self.status),
                             @"good_hot":@(self.sortType),
                             @"type_id":self.type_id,
                             @"page":@(self.pageIndex),
                             @"member_id":USERINFO.memberId,
                             @"keywords":self.keyword
                             };
    [DataSourceTool listWithParam:param toViewController:self success:^(id json) {
        NSLog(@"%@",json);
//        [json[@"data"][0]createPropertyCode];
        if ([json[@"errcode"] integerValue]==0) {
            if (weakself.pageIndex==1) {
                [weakself.dataArray removeAllObjects];
                [weakself.tableView.mj_header endRefreshing];
                [weakself.tableView.mj_footer endRefreshing];
            }else{
                if (((NSArray*)json[@"data"]).count == 0) {
                    [weakself.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [weakself.tableView.mj_footer endRefreshing];
                }
            }
            weakself.pageIndex++;
            
            for (NSDictionary * dic in json[@"data"]) {
                CrowdFundItem * item = [CrowdFundItem new];
                [item setValuesForKeysWithDictionary:dic];
                [weakself.dataArray addObject:item];
            }
            [weakself.tableView reloadData];
        }else{
            [weakself.tableView.mj_header endRefreshing];
            [weakself.tableView.mj_footer endRefreshing];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [weakself.tableView.mj_header endRefreshing];
        [weakself.tableView.mj_footer endRefreshing];

    }];
}

-(void)getFilterData{
    kWeakSelf(self);
    NSDictionary * param = @{
                             @"type":@"0"
                             };
    
    [DataSourceTool filterListWithParam:param toViewController:self success:^(id json) {
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
    CrowdFundListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CrowdFundListCell"];
    CrowdFundItem * item = self.dataArray[indexPath.row];
    cell.status = self.status;
    cell.item = item;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CrowdFundItem * item = self.dataArray[indexPath.row];
    CrowdFundDetailController * vc = [CrowdFundDetailController new];
    vc.status = self.status;
    vc.item = item;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark -倒计时相关方法
-(void)updateTimeInVisibleCells{
    kWeakSelf(self);
    NSArray  *cells = weakself.tableView.visibleCells; //取出屏幕可见ceLl
    for (CrowdFundListCell *cell in cells) {
        NSIndexPath * indexPath = [weakself.tableView indexPathForCell:cell];
        CrowdFundItem * item = weakself.dataArray[indexPath.row];
        cell.timeLabel.text = [weakself getNowTimeWithString:item.endTime];
        if ([cell.timeLabel.text isEqualToString:@"该众筹已结束"]) {
            cell.timeLabel.textColor = [UIColor redColor];
        }else{
            cell.timeLabel.textColor = [UIColor lightGrayColor];
        }
    }
}
-(NSString *)getNowTimeWithString:(NSString *)aTimeString{

    
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 截止时间date格式
    NSDate  *expireDate = [NSDate dateWithTimeIntervalSince1970:[aTimeString doubleValue]];
    NSDate  *nowDate = [NSDate date];
    
    NSTimeInterval timeInterval =[expireDate timeIntervalSinceDate:nowDate];
    
    int days = (int)(timeInterval/(3600*24));
    int hours = (int)((timeInterval-days*24*3600)/3600);
    int minutes = (int)(timeInterval-days*24*3600-hours*3600)/60;
    int seconds = timeInterval-days*24*3600-hours*3600-minutes*60;
    
    NSString *dayStr;NSString *hoursStr;NSString *minutesStr;NSString *secondsStr;
    //天
    dayStr = [NSString stringWithFormat:@"%d",days];
    //小时
    hoursStr = [NSString stringWithFormat:@"%d",hours];
    //分钟
    if(minutes<10)
        minutesStr = [NSString stringWithFormat:@"0%d",minutes];
    else
        minutesStr = [NSString stringWithFormat:@"%d",minutes];
    //秒
    if(seconds < 10)
        secondsStr = [NSString stringWithFormat:@"0%d", seconds];
    else
        secondsStr = [NSString stringWithFormat:@"%d",seconds];
    if (hours<=0&&minutes<=0&&seconds<=0) {
        return @"00天00时00分";
    }
    if (days) {
        return [NSString stringWithFormat:@"%@天 %@小时 %@分", dayStr,hoursStr, minutesStr];
    }
    return [NSString stringWithFormat:@"%@小时 %@分",hoursStr , minutesStr];
}

-(void)dealloc{
    NSLog(@"%s dealloc",object_getClassName(self));
}

@end
