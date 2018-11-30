//
//  NewsListController.m
//  ONLY
//
//  Created by Dylan on 13/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "OnlyNewsListController.h"
#import "OnlyNewsDetailController.h"

#import "NewsListCell.h"
#import "XRCarouselView.h"

#import "OnlyNewsItem.h"
@interface OnlyNewsListController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)XRCarouselView * bannerView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * bannerImageArray;
@property(nonatomic,assign)NSInteger pageIndex;

@end

@implementation OnlyNewsListController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
-(NSMutableArray *)bannerImageArray{
    if (!_bannerImageArray) {
        _bannerImageArray = [NSMutableArray new];
    }
    return _bannerImageArray;
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
    self.view.backgroundColor = WhiteColor;
    self.title = @"微点资讯";
}

-(void)setupUI{
    kWeakSelf(self);
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth(), screenHeight()-Nav) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.tableHeaderView = [self setupBannerView];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself reloadData];
    }];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakself getData];
    }];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsListCell" bundle:nil] forCellReuseIdentifier:@"NewsListCell"];

}

-(UIView *)setupBannerView{
    self.bannerView = [[XRCarouselView alloc]initWithFrame:CGRectMake(0, 0, screenWidth(), 213*SCREEN_PRESENT)];
    UIImage * image = [UIImage imageNamed:@"HomePage_service"];
    [self.bannerView setImageArray:@[image,image]];
    [self.bannerView setPageImage:[UIImage imageNamed:@"empty_oval"] andCurrentPageImage:[UIImage imageNamed:@"solid_oval"]];
    return self.bannerView;
}

-(void)reloadData{
    kWeakSelf(self);
    weakself.pageIndex = 1;
    [weakself getData];
}


-(void)getData{
    NSDictionary * param = @{
                             @"page": @(self.pageIndex),
                             @"pageSize": @"10"

                             };
    [DataSourceTool onlyNewsListWithParam:param toViewController:self success:^(id json) {
        NSLog(@"%@",json);
        
        if ([json[@"errcode"]integerValue ]==0) {
            
            if (self.pageIndex==1) {
                [self.dataArray removeAllObjects];
                [self.bannerImageArray removeAllObjects];
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
                OnlyNewsItem * item = [OnlyNewsItem new];
                [item setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:item];
            }
            
            for (NSDictionary * dic in json[@"banners"]) {
                NSString * urlStr = [NSString stringWithFormat:@"%@%@",Choose_Base_URL,dic[@"ad_img"]];
                [self.bannerImageArray addObject:urlStr];
            }
            
            [self.tableView reloadData];
            [self.bannerView setImageArray:self.bannerImageArray];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"NewsListCell"];
    OnlyNewsItem * item = self.dataArray[indexPath.row];
    cell.item = item;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OnlyNewsDetailController * vc = [OnlyNewsDetailController new];
    OnlyNewsItem * item = self.dataArray[indexPath.row];
    vc.item = item;
    [self.navigationController pushViewController:vc animated:YES];
}
@end
