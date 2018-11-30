//
//  MemberHomeViewController.m
//  ONLY
//
//  Created by 上海点硕 on 2016/12/20.
//  Copyright © 2016年 cbl－　点硕. All rights reserved.
//

#import "MemberHomeViewController.h"
#import "MemberHomeDetailController.h"
#import "MemberHomeListCell.h"
#import "MemSerModel.h"
@interface MemberHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView* tableView; /*表视图*/
@property (nonatomic,strong) NSMutableArray* dataSource; /*数据模型*/

@end

@implementation MemberHomeViewController
{
    NSInteger pageIndex;
    NSMutableArray *dataArray;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    pageIndex = 1;
    [self.tableView setSectionFooterHeight:0.0f];
    [self loadData];
}

-(UITableView*) tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
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
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MemberHomeListCell" owner:nil options:nil] lastObject];
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
    else if([model.order_status integerValue] == 2)
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

//加载网络数据
- (void)loadData
{
    [DataSourceTool getMarketSupportOrders:[NSString stringWithFormat:@"%ld",pageIndex] type:0 ViewController:self success:^(id json) {
        
        
        if ([json[@"errcode"] integerValue]==0) {
            NSMutableArray *temp = [NSMutableArray array];
            [temp removeAllObjects];
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
                [temp addObject:item];
                dataArray = temp;
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


@end
