//
//  MineServerController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/1/16.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineServerController.h"
#import "BLNewSeleteVIew.h"
#import "MineOrder.h"
#import "MineServerCell.h"
#import "MineServerDetailController.h"
#import "ServerModel.h"
#import "UITableView+Sure_Placeholder.h"
#import "MBProgressHUD+Extension.h"
#import "MineDiscussController.h"
#import "MineSerDiscussController.h"
#import "PayCenterController.h"
@interface MineServerController ()<UITableViewDataSource,UITableViewDelegate,BLSelectViewDelegate>

@end

@implementation MineServerController

{
    UITableView *tableview;
    NSInteger pageIndex;
    NSInteger IsCell;
    NSMutableArray *dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    self.fd_prefersNavigationBarHidden = YES;
    dataArray = [NSMutableArray array];
    [self setNavView];
    pageIndex = 1;
    IsCell = 999;
    [self loadData];
    
}

- (void)btnClickIndex:(NSInteger)index
{
    NSLog(@"---------------%ld",index);
    pageIndex = 1;

    if (index==7) {
        IsCell = 999;
    }
    else if (index==0) {
        IsCell = 0;
    }
    else if (index==1) {
        IsCell = 1;
    }
    
    else
    {
        IsCell = 4;
    }
    
    [self loadData];
    
}
//创建导航栏（自定义）
- (void)setNavView
{
    UIView *view  = [UIView new];
    view.backgroundColor = colorWithRGB(0x00A9EB);
    [self.view addSubview:view];
    view.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(68);
    
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
    titleLabel.text = @"支持服务";
    
    BLNewSeleteVIew *selView = [[BLNewSeleteVIew alloc] initWithTitle:@[@"全部",@"待付款",@"已付款",@"待评价"] setFrame:CGRectMake(0, 68, SCREEN_WIDTH, 48) setIndex:@[@1,@0,@0,@0,@0]];
    selView.delegate = self;
    [self.view addSubview:selView];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.rowHeight = 160;
    tableview.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,116).bottomSpaceToView(self.view,0);
    cornerRadiusView(tableview, 3);
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.showsVerticalScrollIndicator = NO;
    tableview.firstReload = NO;
    kWeakSelf(self);
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakself reloadData];
        
    }];
    tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [weakself loadData];
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return dataArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count > 0 ;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        
        return 0.000001;
    }
    else
    {
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0000001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"MineServerCell";
    
    MineServerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell==nil) {
        
        cell =[[[NSBundle mainBundle] loadNibNamed:@"MineServerCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.serverOne.layer.borderWidth = 1;
        cell.serverOne.layer.borderColor = colorWithRGB(0x999999).CGColor;
        cell.serverOne.layer.cornerRadius = 3;
        cell.serverOne.layer.masksToBounds = YES;
        
        cell.serverTwo.layer.borderWidth = 1;
        cell.serverTwo.layer.borderColor = colorWithRGB(0xEA5520).CGColor;
        cell.serverTwo.layer.cornerRadius = 3;
        cell.serverTwo.layer.masksToBounds = YES;
    }
    ServerModel *model = dataArray[indexPath.section];
    cell.Abc.text = model.member_name;
    cell.serverNum.text = [NSString stringWithFormat:@"订单编号: %@",model.order_sn];
    cell.serNum.text = model.service_count;
    cell.serverStatus.text = model.status;
    cell.range.text = model.level_name;
    cell.serverType.text = [NSString stringWithFormat:@"服务类型：%@ %@",model.service_type_name,model.service_name];
    cell.serverPrice.text = model.order_amount;
    if ([model.sex isEqualToString:@"0"]) {
        cell.sex.image = [UIImage imageNamed:@"member_mine_male"];
    }
    else
    {
        cell.sex.image = [UIImage imageNamed:@"member_mine_female"];
    }

    
    if ([model.order_status isEqualToString:@"0"]) {
        if ([model.is_receive isEqualToString:@"1"]) {
            [cell.serverOne setTitle:@"取消订单" forState:UIControlStateNormal];
            [cell.serverTwo setTitle:@"立即支付" forState:UIControlStateNormal];
        }
        else{
        [cell.serverOne setHidden:YES];
        [cell.serverTwo setTitle:@"取消订单" forState:UIControlStateNormal];
        }
    }
    //只有 这个有尾款
    else if ([model.order_status isEqualToString:@"1"])
    {
        [cell.serverOne setHidden:YES];
        [cell.serverTwo setTitle:@"联系客服" forState:UIControlStateNormal];
    }
    
    else if ([model.order_status isEqualToString:@"2"])
    {
        [cell.serverOne setHidden:YES];
        [cell.serverTwo setTitle:@"联系客服" forState:UIControlStateNormal];
    }
    else if ([model.order_status isEqualToString:@"3"])
    {
        [cell.serverOne setTitle:@"联系客服" forState:UIControlStateNormal];
        [cell.serverTwo setTitle:@"确认结束" forState:UIControlStateNormal];
    }
    else if ([model.order_status isEqualToString:@"4"])
    {
        [cell.serverOne setTitle:@"联系客服" forState:UIControlStateNormal];
        [cell.serverTwo setTitle:@"评价" forState:UIControlStateNormal];
    }
    else if ([model.order_status isEqualToString:@"5"])
    {
        [cell.serverOne setTitle:@"联系客服" forState:UIControlStateNormal];
        [cell.serverTwo setTitle:@"删除订单" forState:UIControlStateNormal];
    }
    else{
        [cell.serverOne setTitle:@"联系客服" forState:UIControlStateNormal];
        [cell.serverTwo setTitle:@"删除订单" forState:UIControlStateNormal];
    }
    
    //最后2个按钮的点击事件
    cell.oneBlock = ^(void)
    {
        if ([model.order_status isEqualToString:@"0"]) {
            if ([model.is_receive isEqualToString:@"1"]) {
                //@"取消订单"
                [DataSourceTool deleteOrder:1 order_sn:model.order_sn order_type:@"2" ViewController:self success:^(id json) {
                    
                    if ([json[@"errcode"] integerValue]==0) {
                        
                        [MBProgressHUD showSuccess:@"取消成功" toView:self.view complete:nil];
                        [tableview reloadData];
                    }
                } failure:^(NSError *error) {
                    
                }];

                
            }
            else{
                
                
            }
        }
        //只有 这个有尾款
        else if ([model.order_status isEqualToString:@"1"])
        {
            
           
        }
        
        else if ([model.order_status isEqualToString:@"2"])
        {
          
        
        }
        else if ([model.order_status isEqualToString:@"3"])
        {
            //联系客服
            NSString *phone = [NSString stringWithFormat:@"tel:%@",model.customer_service_phone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
            
        }
        else if ([model.order_status isEqualToString:@"4"])
        {
            //联系客服
            NSString *phone = [NSString stringWithFormat:@"tel:%@",model.customer_service_phone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
          
        }
        else if ([model.order_status isEqualToString:@"5"])
        {
            //联系客服
            NSString *phone = [NSString stringWithFormat:@"tel:%@",model.customer_service_phone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
        
        }
        else{
            
        }

    
    };
    
    cell.TwoBlock = ^(void)
    {
        if ([model.order_status isEqualToString:@"0"]) {
            if ([model.is_receive isEqualToString:@"1"]) {
               //@"立即支付"
                PayCenterController *vc  = [PayCenterController new];
                vc.price = model.order_amount;
                vc.endTime = model.end_date;
                vc.order_sn = model.order_sn;
                vc.order_type = @"2";
                [self.navigationController pushViewController:vc animated:YES];
              
            }
            else{
               
                //@"取消订单"
                [DataSourceTool deleteOrder:1 order_sn:model.order_sn order_type:@"2" ViewController:self success:^(id json) {
                    
                    if ([json[@"errcode"] integerValue]==0) {
                        
                        [MBProgressHUD showSuccess:@"取消成功" toView:self.view complete:nil];
                        [tableview reloadData];
                    }
                } failure:^(NSError *error) {
                    
                }];
 

            }
        }
        //只有 这个有尾款
        else if ([model.order_status isEqualToString:@"1"])
        {
            
            //联系客服
            NSString *phone = [NSString stringWithFormat:@"tel:%@",model.customer_service_phone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];

        }
        
        else if ([model.order_status isEqualToString:@"2"])
        {
            
            //联系客服
            NSString *phone = [NSString stringWithFormat:@"tel:%@",model.customer_service_phone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];

        }
        else if ([model.order_status isEqualToString:@"3"])
        {
          //@"确认结束"
            [DataSourceTool deleteOrder:2 order_sn:model.order_sn order_type:@"2" ViewController:self success:^(id json) {
                
                if ([json[@"errcode"] integerValue]==0) {
                    
                    [MBProgressHUD showSuccess:@"确认结束" toView:self.view complete:nil];
                    [tableview reloadData];
                }
            } failure:^(NSError *error) {
                
            }];
            

           
        }
        else if ([model.order_status isEqualToString:@"4"])
        {
            //评价
            MineSerDiscussController *vc = [MineSerDiscussController new];
            vc.ser_Num = model.order_sn;
            vc.ser_number = model.service_count;
            vc.range = model.level_name;
            vc.ser_name = [NSString stringWithFormat:@"服务类型：%@ %@",model.service_type_name,model.service_name];
            vc.sex = model.sex;
            vc.ser_price = model.order_amount;
            vc.abc = model.member_name;
            vc.ser_id = model.service_id;
            vc.supportTime = model.support_time;
            vc.address = model.service_address;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([model.order_status isEqualToString:@"5"])
        {
           
            //@"删除订单"
            [DataSourceTool deleteOrder:0 order_sn:model.order_sn order_type:@"2" ViewController:self success:^(id json) {
                
                if ([json[@"errcode"] integerValue]==0) {
                    
                    [MBProgressHUD showSuccess:@"删除成功" toView:self.view complete:nil];
                    [tableview reloadData];
                }
            } failure:^(NSError *error) {
                
            }];
        }
        else{
            
        }

    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ServerModel *model = dataArray[indexPath.section];
    MineServerDetailController *vc  = [MineServerDetailController new];
    vc.order_sn = model.order_sn;
    vc.order_status = model.order_status;
    vc.is_receive = model.is_receive;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)loadData
{
    [DataSourceTool supportOrders:[NSString stringWithFormat:@"%ld",pageIndex] order_status:[NSString stringWithFormat:@"%ld",IsCell]ViewController:self success:^(id json) {
        if ([json[@"errcode"] integerValue]==0) {
//            NSMutableArray *temp = [NSMutableArray array];
//            [temp removeAllObjects];
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
            
            }
           [tableview reloadData]; 
            
        }else {
            [tableview.mj_header endRefreshing];
            [tableview.mj_footer endRefreshing];
        }
        
    } failure:^(NSError *error) {
        
    }];

}
//下拉刷新数据
-(void)reloadData
{
    pageIndex = 1;
    
    [self loadData];
}

@end
