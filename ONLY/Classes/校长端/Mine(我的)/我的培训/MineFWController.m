//
//  MineFWController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/2/7.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//
#import "MineFWController.h"
#import "HMSegmentedControl.h"
#import "MineServerDetailController.h"
#import "MineAdviseCell.h"
#import "CrowdFundDetailController.h"
#import "MineZCDetailController.h"
#import "MineServerSecondCell.h"
#import "ServerModel.h"
#import "ZCModel.h"
@interface MineFWController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)HMSegmentedControl * segmentControl;
@end

@implementation MineFWController
{
    UIView * _segmentBGView;
    UITableView * tableview;
    NSMutableArray *dataArray;    //加载网络数据
    NSInteger IsCell;
    NSInteger pageIndex;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = WhiteColor;
    IsCell = 999;
    pageIndex = 1;
    dataArray = [NSMutableArray array];
    [self setNavView];
    [self setupSegment];
    [self loadData];
    
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
    titleLabel.text = @"我的服务";
    
    tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:tableview];
    tableview.sd_layout.topSpaceToView(self.view,108).bottomSpaceToView(self.view,0).rightEqualToView(self.view).leftEqualToView(self.view);
    tableview.rowHeight = 94;
    tableview.delegate = self;
    tableview.dataSource = self;
    [tableview setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    //MineAdviseCell
    [tableview registerNib:[UINib nibWithNibName:@"MineServerSecondCell" bundle:nil] forCellReuseIdentifier:@"MineServerSecondCell"];
    
    [tableview registerNib:[UINib nibWithNibName:@"MineAdviseCell" bundle:nil] forCellReuseIdentifier:@"MineAdviseCell"];
    kWeakSelf(self);
    
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakself reloadData];
        
    }];
    tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [weakself loadData];
        
    }];
}

-(void)setupSegment{
    _segmentBGView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, screenWidth(), 44)];
    _segmentBGView.backgroundColor = colorWithRGB(0x00A9EB);
    self.segmentControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH-10, 40)];
    
    self.segmentControl.sectionTitles = @[@"已购买", @"已提议"];
    self.segmentControl.selectedSegmentIndex = 0;
    self.segmentControl.backgroundColor = [UIColor clearColor];
    self.segmentControl.titleTextAttributes = @{NSForegroundColorAttributeName : kRGBColor(191,221,233),NSFontAttributeName:[UIFont systemFontOfSize:14]};
    self.segmentControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.segmentControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.segmentControl.selectionIndicatorColor = [UIColor whiteColor];
    self.segmentControl.selectionIndicatorHeight = 2;
    self.segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentControl.selectionIndicatorBoxOpacity = 1;
    kWeakSelf(self)
    __weak typeof(dataArray)weakArray = dataArray;
    [self.segmentControl setIndexChangeBlock:^(NSInteger index) {
        
        [weakArray removeAllObjects];
         pageIndex = 1;
        if (index == 1) {
            IsCell = 0;
   
        }else{
            IsCell=999;
        }
        [weakself loadData];
    }];
    
    [_segmentBGView addSubview:self.segmentControl];
    [self.view addSubview:_segmentBGView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IsCell==999) {
        return 94;
    }
    else
    {
        return 120;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return dataArray.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MineServerSecondCell * cell = [tableView dequeueReusableCellWithIdentifier:@"MineServerSecondCell"];
    MineAdviseCell * cell1 = [tableView dequeueReusableCellWithIdentifier:@"MineAdviseCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (IsCell==999) {
        ServerModel *model = dataArray[indexPath.row];
        cell.abc.text = model.member_name;
        cell.serverNumber.text = model.service_count;
        cell.range.text = model.level_name;
        cell.serverType.text = [NSString stringWithFormat:@"服务类型：%@ %@",model.service_type_name,model.service_name];
        cell.serverPrice.text = [NSString stringWithFormat:@"¥%@",model.order_amount];
        
        if ([model.sex isEqualToString:@"0"]) {
            cell.sexImg.image = [UIImage imageNamed:@"member_mine_male"];
        }
        else
        {
            cell.sexImg.image = [UIImage imageNamed:@"member_mine_female"];
        }
        
        return cell;
    }
    else
    {
        ZCModel *model = dataArray[indexPath.row];
        cell1.adviseTitle.text = model.apply_name;
        cell1.adviseTime.text = [self becomeTime:model.add_time];
        [cell1.adviseImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,model.portrait]]];
        if ([model.status isEqualToString:@"0"]) {
            //审核状态 0未审核1审核通过2审核未通过
            cell1.adviseStatus.text = @"未审核";
        }
        else if ([model.status isEqualToString:@"1"])
        {
            cell1.adviseStatus.text = @"审核通过";
        }
        else
        {
            cell1.adviseStatus.text = @"审核失败";
        }
        
        return cell1;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IsCell==999) {
        ServerModel *model = dataArray[indexPath.section];
        MineServerDetailController *vc  = [MineServerDetailController new];
        vc.order_sn = model.order_sn;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        ZCModel *model = dataArray[indexPath.row];
        MineZCDetailController *vc  =[MineZCDetailController new];
        vc.apply_id = model.apply_id;
        vc.apply_time = [self becomeTime:model.add_time];
        vc.apply_name = model.apply_name;
        
        if ([model.status isEqualToString:@"0"]) {
            //审核状态 0未审核1审核通过2审核未通过
            vc.apply_status = @"未审核";
        }
        else if ([model.status isEqualToString:@"1"])
        {
            vc.apply_status = @"审核通过";
        }
        else
        {
            vc.apply_status = @"审核失败";
        }
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

- (void)loadData
{
    if (IsCell==999) {
        
        [DataSourceTool supportOrders:[NSString stringWithFormat:@"%ld",pageIndex] order_status:[NSString stringWithFormat:@"%ld",IsCell]ViewController:self success:^(id json) {
            if ([json[@"errcode"] integerValue]==0) {
//                NSMutableArray *temp = [NSMutableArray array];
//                [temp removeAllObjects];
                if (pageIndex==1)
                {
                    [dataArray removeAllObjects];
                    [tableview.mj_header endRefreshing ];
                    [tableview.mj_footer endRefreshing];
                }
                else {
                    if (((NSArray*)json[@"rsp"]).count == 0) {
                        [tableview.mj_footer endRefreshingWithNoMoreData];
                        
                    }else{
                        [tableview.mj_footer endRefreshing];
                    }
                }
                
                pageIndex++;
                
                for (NSDictionary * dic in json[@"rsp"]) {
                    
                    ServerModel * item = [ServerModel new];
                    [item setValuesForKeysWithDictionary:dic];
                    [dataArray addObject:item];
                    //dataArray = temp;
                    
                }
                [tableview reloadData];
                
            }else {
                [tableview.mj_header endRefreshing];
                [tableview.mj_footer endRefreshing];
            }
            
        } failure:^(NSError *error) {
            
        }];
    }
    else
    {
        [DataSourceTool addList:[NSString stringWithFormat:@"%ld",pageIndex] ViewController:self success:^(id json) {
            if ([json[@"errcode"] integerValue]==0) {
                NSMutableArray *temp = [NSMutableArray array];
                [temp removeAllObjects];
                if (pageIndex==1)
                {
                    [dataArray removeAllObjects];
                    [tableview.mj_header endRefreshing ];
                    [tableview.mj_footer endRefreshing];
                }
                else {
                    if (((NSArray*)json[@"list"]).count == 0) {
                        [tableview.mj_footer endRefreshingWithNoMoreData];
                        
                    }else{
                        [tableview.mj_footer endRefreshing];
                    }
                }
                
                pageIndex++;
                
                for (NSDictionary * dic in json[@"list"]) {
                    
                    ZCModel * item = [ZCModel new];
                    [item setValuesForKeysWithDictionary:dic];
                    [temp addObject:item];
                    dataArray = temp;
                    
                }
                [tableview reloadData];
                
            }else {
                [tableview.mj_header endRefreshing];
                [tableview.mj_footer endRefreshing];
            }
     
        } failure:^(NSError *error) {
            
        }];
    }
}
//下拉刷新数据
-(void)reloadData
{
    pageIndex = 1;
    [self loadData];
}

- (NSString *)becomeTime:(NSString *)time
{
    NSDateFormatter* formatter = [NSDateFormatter new];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *dt = [NSDate dateWithTimeIntervalSince1970:[time integerValue]];
    
    NSString *nowtimeStr = [formatter stringFromDate:dt];
    
    return nowtimeStr;
    
}

@end
