//
//  CompetitionVoteListController.m
//  ONLY
//
//  Created by Dylan on 15/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "CompetitionVoteListController.h"
#import "CompetitionVoteDetailController.h"
#import "HMSegmentedControl.h"
#import "CompetitionVoteListCell.h"
#import "CandidateItem.h"
#import "UIViewController+HUD.h"
@interface CompetitionVoteListController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)HMSegmentedControl * segmentControl;
@property(nonatomic, strong)NSMutableArray * dataArray;
@property(nonatomic, strong)NSString * sortType;
@property(nonatomic, assign)NSInteger pageIndex;

@end

@implementation CompetitionVoteListController{
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
    self.sortType = @"0";
    self.pageIndex = 1;
}
-(void)setupNavi{
    self.title = self.item.match_name;
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
    
    self.segmentControl.sectionTitles = @[@"点赞数", @"发布时间"];
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
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    [self.tableView setSeparatorColor:AppBackColor];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_segmentBGView.mas_bottom).mas_equalTo(0);
        make.left.bottom.right.equalTo(self.view);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CompetitionVoteListCell" bundle:nil] forCellReuseIdentifier:@"CompetitionVoteListCell"];
}


-(void)reloadData{
    kWeakSelf(self);
    weakself.pageIndex = 1;
    [weakself getData];
}


-(void)getData{
    NSDictionary * param = @{
                             @"match_id": self.item.match_id,
                             @"type": self.sortType
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
                    // [self.tableView.mj_footer endRefreshingWithNoMoreData];
                    [self.tableView.mj_footer endRefreshing];
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

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    kWeakSelf(self);
    CompetitionVoteListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CompetitionVoteListCell"];
    [cell setVote_block:^(CandidateItem * item){
        [weakself vote:item];
    }];
    CandidateItem * item = self.dataArray[indexPath.row];
    cell.item = item;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CompetitionVoteDetailController * vc = [CompetitionVoteDetailController new];
    CandidateItem * item = self.dataArray[indexPath.row];
    vc.item = item;
    [self.navigationController pushViewController:vc animated:YES];
    
}

#pragma mark - 网络请求
-(void)vote:(CandidateItem*)item{
    NSDictionary * param = @{
                             @"member_id": USERINFO.memberId,
                             @"match_id": item.match_id,
                             @"match_member_id": item.match_member_id
                             };
    [DataSourceTool competitionVoteWithParam:param toViewController:self success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"errcode"]integerValue]==0) {
//            [self showHint:@"投票成功"];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}
@end
