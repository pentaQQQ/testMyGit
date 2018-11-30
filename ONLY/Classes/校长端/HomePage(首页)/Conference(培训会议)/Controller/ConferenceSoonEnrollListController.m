//
//  ConferenceSoonEnrollListController.m
//  ONLY
//
//  Created by Dylan on 29/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "ConferenceSoonEnrollListController.h"
#import "ConferenceDetailController.h"
#import "SearchController.h"
#import "ConferenceCell.h"
#import "ConferenceItem.h"
#import "UIViewController+HUD.h"
@interface ConferenceSoonEnrollListController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,assign)NSInteger pageIndex;

@end

@implementation ConferenceSoonEnrollListController
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
    self.title = @"即将报名";
    self.view.backgroundColor = AppBackColor;
    
    UIButton * searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 25, 44)];
    [searchBtn setImage:[UIImage imageNamed:@"产品众筹_Search"] forState:UIControlStateNormal];
    [searchBtn jk_addActionHandler:^(NSInteger tag) {
        [SearchController presentToSearchControllerWithContext:self type:SearchTypeVideo];
    }];
    UIBarButtonItem * searchItem = [[UIBarButtonItem alloc]initWithCustomView:searchBtn];

    self.navigationItem.rightBarButtonItems = @[searchItem];
}
-(void)setupUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 300;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ConferenceCell" bundle:nil] forCellReuseIdentifier:@"ConferenceCell"];
}

-(void)getData{
    NSDictionary * param = @{
                             @"member_id": USERINFO.memberId,
                             @"page": @(self.pageIndex),
                             @"pageSize": @"10"
                             };
    [DataSourceTool conferenceSoonEnrollListWithParam:param toViewController:self success:^(id json) {
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
            
            for (NSDictionary * dic in json[@"list"]) {
                ConferenceItem * item = [ConferenceItem new];
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


#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ConferenceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ConferenceCell"];
    ConferenceItem * item = self.dataArray[indexPath.row];
    cell.item = item;
    cell.statusLabel.text = @"即将报名";
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ConferenceItem * item = self.dataArray[indexPath.row];
    ConferenceDetailController * vc = [ConferenceDetailController new];
    vc.item = item;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
