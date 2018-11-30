//
//  MemberMineOrderManageController.m
//  ONLY
//
//  Created by zfd on 17/1/14.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//  ‘我的’ -- 订单管理

#import "MemberMineOrderManageController.h"
#import "MemberHomeDetailController.h"
#import "MemberHomeListCell.h"
#import "MemSerModel.h"
static NSInteger const header_height = 45;
static NSInteger const order_tag = 100;

@interface MemberMineOrderManageController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView* tableView; /*表视图*/
@property (nonatomic,strong) NSMutableArray* dataSource; /*数据模型*/
@property (nonatomic,strong) UIButton* pending_order_button; /*进行中*/
@property (nonatomic,strong) UIButton* history_order_button; /*历史订单*/
@property (nonatomic,strong) UILabel* header_line_label; /*头部下划线*/

@end

@implementation MemberMineOrderManageController
{
    NSInteger pageIndex;
    NSMutableArray *dataArray;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    [self.tableView setSectionFooterHeight:0.0f];
    dataArray = [NSMutableArray array];
    pageIndex = 1;
    [self setNavi];
    [self setHeaderView];
    [self loadData];
}

-(UITableView*) tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, header_height + Nav, SCREEN_WIDTH, SCREEN_HEIGHT - (header_height + Nav)) style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = 107;
        kWeakSelf(self);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [weakself reloadData];
            
        }];
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            
            [weakself loadData];
            
        }];
    }
    return _tableView;
}

-(UIButton*) pending_order_button
{
    if (!_pending_order_button)
    {
        _pending_order_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_pending_order_button setTitle:@"进行中" forState:UIControlStateNormal];
        _pending_order_button.tag = order_tag;
        [_pending_order_button setTitleColor:colorWithRGB(0xBFDDE9) forState:UIControlStateNormal];
        [_pending_order_button setTitleColor:WhiteColor forState:UIControlStateSelected];
        _pending_order_button.titleLabel.font = font(14.0f);
        _pending_order_button.contentHorizontalAlignment =UIControlContentHorizontalAlignmentRight;
        [_pending_order_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _pending_order_button;
}

-(UIButton*) history_order_button
{
    if (!_history_order_button)
    {
        _history_order_button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_history_order_button setTitle:@"历史订单" forState:UIControlStateNormal];
        _history_order_button.tag = order_tag + 1;
        [_history_order_button setTitleColor:colorWithRGB(0xBFDDE9) forState:UIControlStateNormal];
        [_history_order_button setTitleColor:WhiteColor forState:UIControlStateSelected];
        _history_order_button.titleLabel.font = font(14.0f);
        _history_order_button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_history_order_button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _history_order_button;
}

-(UILabel*) header_line_label
{
    if (!_header_line_label)
    {
        _header_line_label = [[UILabel alloc] init];
        _header_line_label.backgroundColor = WhiteColor;
    }
    return _header_line_label;
}

-(void) setNavi
{
    UIView* navi_view = [[UIView alloc] init];
    [self.view addSubview:navi_view];
    navi_view.backgroundColor = BlueColor;
    navi_view.sd_layout
    .topSpaceToView(self.view,0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(Nav);
    
    UILabel* navi_label = [MyControl titleLabelWithText:@"我的" textColor:WhiteColor bgColor:ClearColor Font:18.0f TextAlignmentType:textAlignmentTypeCenter];
    [navi_view addSubview:navi_label];
    navi_label.sd_layout
    .topSpaceToView(navi_view,20)
    .leftSpaceToView(navi_view,0)
    .rightSpaceToView(navi_view,0)
    .heightIs(header_height - 1);
    
    UIButton* back_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [navi_view addSubview:back_button];
    back_button.sd_layout
    .topSpaceToView(navi_view,20)
    .leftSpaceToView(navi_view,-10)
    .widthIs(60)
    .heightIs(header_height - 1);
    [back_button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back_button addTarget:self action:@selector(backItemAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void) setHeaderView
{
    UIView* header_view = [[UIView alloc] init];
    [self.view addSubview:header_view];
    header_view.sd_layout
    .topSpaceToView(self.view,Nav)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(header_height);
    header_view.backgroundColor = BlueColor;
    
    [header_view addSubview:self.pending_order_button];
    [header_view addSubview:self.history_order_button];
    [header_view addSubview:self.header_line_label];
    
    _pending_order_button.sd_layout
    .topSpaceToView(header_view,0)
    .leftSpaceToView(header_view,SCREEN_WIDTH / 2 - 140)
    .widthIs(100)
    .heightIs(header_height);
    
    _history_order_button.sd_layout
    .topSpaceToView(header_view,0)
    .leftSpaceToView(header_view,SCREEN_WIDTH / 2 + 40)
    .widthIs(100)
    .heightIs(header_height);
    
    switch (_select_index) {
        case 1:
        {
            [_pending_order_button setSelected:YES];
            [_history_order_button setSelected:NO];
            _header_line_label.sd_layout
            .bottomSpaceToView(header_view,9)
            .leftSpaceToView(header_view,SCREEN_WIDTH / 2 - 82)
            .widthIs(40)
            .heightIs(2);
        }
            break;
        case 2:
        {
            [_pending_order_button setSelected:NO];
            [_history_order_button setSelected:YES];
            _header_line_label.sd_layout
            .bottomSpaceToView(header_view,9)
            .leftSpaceToView(header_view,SCREEN_WIDTH / 2 + 48)
            .widthIs(40)
            .heightIs(2);
        }
            break;
            
        default:
            break;
    }
}

-(void) setSelect_index:(NSInteger)select_index
{
    _select_index = select_index;
}

#pragma mark - UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataArray.count;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0.001f;
    }
    else
    {
        return 10.0f;
    }
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellId = @"MemberHomeListCell";
    MemberHomeListCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell)
    {
        cell = (MemberHomeListCell*)[[[NSBundle mainBundle] loadNibNamed:@"MemberHomeListCell" owner:nil options:nil] lastObject];
    }
    
    MemSerModel *model = dataArray[indexPath.section];
    cell.orderNum.text = model.order_sn;
    cell.orderState.text = model.status;
    cell.orderName.text = model.service_name;
    cell.orderPhone.text = [NSString stringWithFormat:@"%@ %@",model.member_name , model.contact_phone];
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MemSerModel *model = dataArray[indexPath.section];
    MemberHomeDetailController* vc = [[MemberHomeDetailController alloc] init];
    vc.order_sn = model.order_sn;
    if( [model.order_status integerValue] == 0)
    {
        vc.type = 1;
    }
    else if([model.order_status integerValue] == 1)
    {
        vc.type = 0;
    }
    else if([model.order_status integerValue] == 3)
    {
        vc.type = 2;
    }
    else
    {
        vc.type = 3;
    }
    [self.navigationController pushViewController:vc animated:YES];
    
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
}

-(void) buttonAction:(UIButton*) sender
{
    switch (sender.tag) {
        case order_tag:
        {
            [_pending_order_button setSelected:YES];
            [_history_order_button setSelected:NO];
             _header_line_label.x = SCREEN_WIDTH / 2 - 82;
            _select_index = 1;
            pageIndex = 1;
            [self loadData];
            
        }
            break;
        case order_tag + 1:
        {
            [_pending_order_button setSelected:NO];
            [_history_order_button setSelected:YES];
             _header_line_label.x = SCREEN_WIDTH / 2 + 48;
            _select_index = 2;
            pageIndex = 1;
            [self loadData];
            
        }
            break;
            
        default:
            break;
    }
}

//加载网络数据
- (void)loadData
{
    [DataSourceTool getMarketSupportOrders:[NSString stringWithFormat:@"%ld",pageIndex] type:_select_index ViewController:self success:^(id json) {
        
        
        if ([json[@"errcode"] integerValue]==0) {

            if (pageIndex==1)
            {
                [dataArray removeAllObjects];
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
            }
            else {
                if (((NSArray*)json[@"rsp"]).count == 0) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.tableView.mj_footer endRefreshing];
                }
            }
            
            pageIndex++;
            
            for (NSDictionary * dic in json[@"rsp"]) {
                
                MemSerModel * item = [MemSerModel new];
                [item setValuesForKeysWithDictionary:dic];
                [dataArray addObject:item];
            }
            
            [self.tableView reloadData];
            
        }else {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

//刷新数据
- (void)reloadData
{
    pageIndex = 1;
    
    [self loadData];
    
}


-(void) backItemAction:(UIButton*) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}







@end
