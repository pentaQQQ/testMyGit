//
//  MineDBPController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/2/14.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineDBPController.h"
#import "HMSegmentedControl.h"
#import "MineDBPCell.h"
#import "CompetitionItem.h"
#import "CompetitionDetailController.h"
@interface MineDBPController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)HMSegmentedControl * segmentControl;
@end

@implementation MineDBPController
{
    UITableView *tableview;
    UIView * _segmentBGView;
    NSInteger IsCell;
    NSInteger pageIndex;
    NSMutableArray *dataArray;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    IsCell = 0;
    pageIndex= 1;
    
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = WhiteColor;
    dataArray  = [NSMutableArray array];
    [self setNavView];
    [self setupSegment];
    
    [self getData];
}
//创建导航栏（自定义）
- (void)setNavView
{
    UIView *view  = [UIView new];
    view.backgroundColor = colorWithRGB(0x00A9EB);
    [self.view addSubview:view];
    view.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(64);
    
    UIButton *backBtn = [UIButton new];
    [view addSubview:backBtn];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backBtn.sd_layout.leftSpaceToView(view,8).topSpaceToView(view,25).heightIs(30).widthIs(30);
    [backBtn jk_addActionHandler:^(NSInteger tag) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    UILabel *titleLabel = [UILabel new];
    [view addSubview:titleLabel];
    titleLabel.textColor= WhiteColor;
    titleLabel.font = font(18);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.sd_layout.leftSpaceToView(view,50).rightSpaceToView(view,50).heightIs(17).topSpaceToView(view,35);
    titleLabel.text = @"我的大比拼";
    
    tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:tableview];
    tableview.sd_layout.topSpaceToView(self.view,108).bottomSpaceToView(self.view,0).rightEqualToView(self.view).leftEqualToView(self.view);
    tableview.delegate = self;
    tableview.dataSource = self;
    [tableview setTableFooterView:[UIView new]];
    kWeakSelf(self);
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself reloadData];
    }];
    tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakself getData];
    }];
     [tableview registerNib:[UINib nibWithNibName:@"MineDBPCell" bundle:nil] forCellReuseIdentifier:@"MineDBPCell"];
    
    
}

-(void)setupSegment{
    _segmentBGView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, screenWidth(), 44)];
    _segmentBGView.backgroundColor = colorWithRGB(0x00A9EB);;
    self.segmentControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH-10, 40)];
    
    self.segmentControl.sectionTitles = @[@"已投票", @"已报名"];
    self.segmentControl.selectedSegmentIndex = 0;
    self.segmentControl.backgroundColor = [UIColor clearColor];
    self.segmentControl.titleTextAttributes = @{NSForegroundColorAttributeName : kRGBColor(191,221,233),NSFontAttributeName:[UIFont systemFontOfSize:14]};
    self.segmentControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.segmentControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.segmentControl.selectionIndicatorColor = [UIColor whiteColor];
    self.segmentControl.selectionIndicatorHeight = 2;
    self.segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentControl.selectionIndicatorBoxOpacity = 1;
    kWeakSelf(self);
    [self.segmentControl setIndexChangeBlock:^(NSInteger index) {
        pageIndex = 1;
        if (index == 0) {
            IsCell = 0;
            
        }else{
            IsCell=1;
        }
        [weakself getData];
    }];
    
    [_segmentBGView addSubview:self.segmentControl];
    [self.view addSubview:_segmentBGView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  return 282;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MineDBPCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MineDBPCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    CompetitionItem * item = dataArray[indexPath.row];
    cell.title.text = item.match_name;
    cell.time.text = [self becomeTime:item.add_time];
    [cell.img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,item.match_img]]];
    
    return cell;
    
}

//点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CompetitionDetailController * vc = [CompetitionDetailController new];
    CompetitionItem * item = dataArray[indexPath.row];
    vc.item = item;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)reloadData{
    kWeakSelf(self);
     pageIndex = 1;
    [weakself getData];
}

- (NSString *)becomeTime:(NSString *)time
{
    NSDateFormatter* formatter = [NSDateFormatter new];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *dt = [NSDate dateWithTimeIntervalSince1970:[time integerValue]];
    
    NSString *nowtimeStr = [formatter stringFromDate:dt];
    
    return nowtimeStr;
    
}

-(void)getData{
  
    [DataSourceTool findMyDBPList:[NSString stringWithFormat:@"%ld",pageIndex] type:IsCell ViewController:self success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"errcode"] integerValue]==0) {
            if (pageIndex==1) {
                [dataArray removeAllObjects];
                [tableview.mj_header endRefreshing];
                [tableview.mj_footer endRefreshing];
            }else{
                if (((NSArray*)json[@"data"]).count == 0) {
                    [tableview.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [tableview.mj_footer endRefreshing];
                }
            }
            pageIndex++;
            for (NSDictionary * dic in json[@"data"][@"list"]) {
                CompetitionItem * item = [CompetitionItem new];
                [item setValuesForKeysWithDictionary:dic];
                [dataArray addObject:item];
            }
            
            [tableview reloadData];
        }else{
            [tableview.mj_header endRefreshing];
            [tableview.mj_footer endRefreshing];
            
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}


@end
