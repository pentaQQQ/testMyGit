//
//  CompetitionResultController.m
//  ONLY
//
//  Created by Dylan on 23/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "CompetitionResultController.h"

#import "CompetitionResultCell_1.h"

#import "CandidateItem.h"

#import "UIViewController+HUD.h"
@interface CompetitionResultController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic ,strong)UITableView * tableView;
@property(nonatomic ,strong)NSMutableArray * dataArray;
@property(nonatomic ,assign)NSInteger pageIndex;
@end

@implementation CompetitionResultController
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
    self.pageIndex = 1;
}
-(void)setupNavi{
    self.title = @"投票结果";
    self.view.backgroundColor = AppBackColor;
}

-(void)setupUI{
    kWeakSelf(self);
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 200;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.tableView setSeparatorColor:AppBackColor];
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself reloadData];
    }];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakself getData];
    }];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(40, 16, 0, 16));
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CompetitionResultCell_1" bundle:nil] forCellReuseIdentifier:@"CompetitionResultCell_1"];
    
}

-(void)reloadData{
    kWeakSelf(self);
    weakself.pageIndex = 1;
    [weakself getData];
}

-(void)getData{
    NSDictionary * param = @{
                             @"match_id": self.item.match_id,
                             @"type": @"0",
                             @"page": @(self.pageIndex),
                             @"pageSize": @"10"
                             };
    [DataSourceTool competitionVoteListWithParam:param toViewController:self success:^(id json) {
        NSLog(@"%@",json);
        //        [json[@"rsp"][0] createPropertyCode];
        if ([json[@"errcode"] integerValue]==0) {
            if (self.pageIndex==1) {
                [self.dataArray removeAllObjects];
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
            }else{
                if (((NSArray*)json[@"rsp"]).count == 0) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.tableView.mj_footer endRefreshing];
                }
            }
            self.pageIndex++;
            
            for (NSDictionary * dic in json[@"rsp"]) {
                CandidateItem * item = [CandidateItem new];
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
    }];
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CompetitionResultCell_1 * cell = [tableView dequeueReusableCellWithIdentifier:@"CompetitionResultCell_1"];
    CandidateItem * item = self.dataArray[indexPath.row];
    cell.item = item;
    cell.rankLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    if (indexPath.row == 0) {
        cell.rankIV.backgroundColor = colorWithRGB(0xEA5520);
    }else if (indexPath.row == 1){
        cell.rankIV.backgroundColor = colorWithRGB(0xEA9720);
    }else if (indexPath.row == 2){
        cell.rankIV.backgroundColor = colorWithRGB(0xC4D700);
    }else {
        cell.rankIV.backgroundColor = colorWithRGB(0x008CCF);
    }
    return cell;
}

@end
