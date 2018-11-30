//
//  IdeaRankingController.m
//  ONLY
//
//  Created by Dylan on 13/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "IdeaRankingController.h"
#import "IdeaDetailController.h"
#import "NaviTitleView.h"
#import "IdeaCell.h"
#import "HMSegmentedControl.h"
#import "Masonry.h"
#import "UIViewController+HUD.h"

@interface IdeaRankingController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)HMSegmentedControl * segmentControl;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSString * sortType;
@property(nonatomic,assign)NSInteger pageIndex;

@end

@implementation IdeaRankingController{
    UIView * _segmentBGView;
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
    [self setupNavi];
    [self setupUI];
    [self getData];
}
-(void)commonInit{
    self.sortType = @"1";
}
-(void)setupNavi{
    self.title = @"排行榜";
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
    
    self.segmentControl.sectionTitles = @[@"月排行榜", @"总排行榜"];
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
            weakSelf.sortType = @"1";
        }else if (index == 1){
            weakSelf.sortType = @"2";
        }
        [weakSelf reloadData];
    }];
    
    [_segmentBGView addSubview:self.segmentControl];
    [self.view addSubview:_segmentBGView];
}


-(void)setupTableView{
    kWeakSelf(self);
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
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
    self.pageIndex = 1;
    [self getData];
}
-(void)getData{
    NSDictionary * param = @{
                             @"date": self.sortType,
                             @"status": USERINFO.status,
                             @"page":@(self.pageIndex)
                             };
    [DataSourceTool ideaRankingListWithParam:param toViewController:self success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"errcode"] integerValue]==0) {
            if (self.pageIndex==1) {
                [self.dataArray removeAllObjects];
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
            }else{
                if (((NSArray*)json[@"data"]).count == 0) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.tableView.mj_footer endRefreshing];
                }
            }
            self.pageIndex++;
            
            for (NSDictionary * dic in json[@"rsp"]) {
                IdeaItem * item = [IdeaItem new];
                [item setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:item];
            }
            [self.tableView reloadData];
        }else{
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IdeaCell * cell = [tableView dequeueReusableCellWithIdentifier:@"IdeaCell"];
    IdeaItem * item = self.dataArray[indexPath.row];
    cell.item = item;
    cell.statusLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    if (indexPath.row == 0) {
        cell.statusIV.backgroundColor = colorWithRGB(0xea5520);
    }else if (indexPath.row == 1){
        cell.statusIV.backgroundColor = colorWithRGB(0xea9720);
    }else if (indexPath.row == 2){
        cell.statusIV.backgroundColor = colorWithRGB(0xc4d700);
    }else{
        cell.statusIV.backgroundColor = colorWithRGB(0x5abcdf);
    }
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
