//
//  MineMeetingController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/1/16.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineMeetingController.h"
#import "BLNewSeleteVIew.h"
#import "MineOrder.h"
#import "MineMeetOrderDetailController.h"
#import "ManyOrderModel.h"
#import "MineDiscussController.h"
#import "MBProgressHUD+Extension.h"
#import "MineClassController.h"
#import "CourseModel.h"
#import "PayCenterController.h"
@interface MineMeetingController ()<UITableViewDataSource,UITableViewDelegate,BLSelectViewDelegate>

@end

@implementation MineMeetingController
{
    UITableView *tableview;
    NSMutableArray *dataArray;
    NSInteger  pageIndex;
    NSInteger  IsCell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    dataArray = [NSMutableArray array];
    self.fd_prefersNavigationBarHidden = YES;
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
        IsCell = 3;
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
    titleLabel.text = @"会议培训";
    
    BLNewSeleteVIew *selView = [[BLNewSeleteVIew alloc] initWithTitle:@[@"全部",@"待付款",@"已付款",@"待评价"] setFrame:CGRectMake(0, 68, SCREEN_WIDTH, 48) setIndex:@[@1,@0,@0,@0,@0]];
    selView.delegate = self;
    [self.view addSubview:selView];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.rowHeight = 216;
    tableview.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,116).bottomSpaceToView(self.view,0);
    cornerRadiusView(tableview, 3);
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.showsVerticalScrollIndicator = NO;
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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        
        return 0.00000001;
    }
    else {
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0000001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"MineOrder";
    MineOrder *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell==nil) {
        
        cell =[[[NSBundle mainBundle] loadNibNamed:@"MineOrder" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    CourseModel *model = dataArray[indexPath.section];
    cell.OrderNum.text = [NSString stringWithFormat:@"x%@",@"1"];
    cell.OrderNumCode.text = model.order_sn;
    cell.OrderPrice.text = [NSString stringWithFormat:@"¥%@",model.unit_price];
    cell.OrderName.text = model.course_title;
    cell.OrderPayPrice.text = [NSString stringWithFormat:@"总计%@件",model.person_num];
    cell.OrderPay.text = [NSString stringWithFormat:@"合计: %@",model.order_amount];
    [cell.OrderImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,model.course_img]] placeholderImage:[UIImage imageNamed:@"图层59"]];
    cell.OrderState.text = model.status;
    
    if ([model.order_status isEqualToString:@"0"])
    {
        
        [cell.OrderBtnOne setTitle:@"取消订单" forState:UIControlStateNormal];
        [cell.OrderBtnTwo setTitle:@"立即支付" forState:UIControlStateNormal];
    }
    //这个有尾款
    else if ([model.order_status isEqualToString:@"1"])
    {
        [cell.OrderBtnOne setHidden:YES];
        [cell.OrderBtnTwo setTitle:@"联系客服" forState:UIControlStateNormal];
    }
    
    else if ([model.order_status isEqualToString:@"2"])
    {
        [cell.OrderBtnOne setTitle:@"联系客服" forState:UIControlStateNormal];
        [cell.OrderBtnTwo setTitle:@"查看课表" forState:UIControlStateNormal];
    }
    else if ([model.order_status isEqualToString:@"3"])
    {
        [cell.OrderBtnOne setTitle:@"查看课表" forState:UIControlStateNormal];
        [cell.OrderBtnTwo setTitle:@"评价" forState:UIControlStateNormal];
    }
    else if ([model.order_status isEqualToString:@"4"])
    {
        [cell.OrderBtnOne setTitle:@"查看课表" forState:UIControlStateNormal];
        [cell.OrderBtnTwo setTitle:@"删除订单" forState:UIControlStateNormal];
        
    }
    else if ([model.order_status isEqualToString:@"5"])
    {
        [cell.OrderBtnOne setHidden:YES];
        [cell.OrderBtnTwo setTitle:@"联系客服" forState:UIControlStateNormal];
    }
    else if ([model.order_status isEqualToString:@"6"])
    {
        [cell.OrderBtnOne setHidden:YES];
        [cell.OrderBtnTwo setTitle:@"联系客服" forState:UIControlStateNormal];
    }
    else if ([model.order_status isEqualToString:@"7"])
    {
        [cell.OrderBtnOne setTitle:@"联系客服" forState:UIControlStateNormal];
        [cell.OrderBtnTwo setTitle:@"删除订单" forState:UIControlStateNormal];
    }
    else
    {
        [cell.OrderBtnOne setTitle:@"联系客服" forState:UIControlStateNormal];
        [cell.OrderBtnTwo setTitle:@"删除订单" forState:UIControlStateNormal];
    }
    
    //最后2个按钮的点击事件
    cell.oneBlock = ^(void)
    {
        if ([model.order_status isEqualToString:@"0"]) {
            
            [DataSourceTool deleteOrder:1 order_sn:model.order_sn order_type:@"1" ViewController:self success:^(id json) {
                
                if ([json[@"errcode"] integerValue]==0) {
                    
                    [MBProgressHUD showSuccess:@"取消成功" toView:self.view complete:nil];
                    [tableview reloadData];
                }
            } failure:^(NSError *error) {
                
            }];
        }
        
        else if ([model.order_status isEqualToString:@"3"]||[model.order_status isEqualToString:@"4"])
        {
            //查看课表
            MineClassController *vc  = [MineClassController new];
            vc.course_id = model.course_id;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
        else if ([model.order_status isEqualToString:@"6"]||[model.order_status isEqualToString:@"1"]||[model.order_status isEqualToString:@"5"])
        {
            //不做处理
        }
        else
        {
            //联系客服
            NSString *phone = [NSString stringWithFormat:@"tel:%@",model.customer_service_phone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
        }
        
        
    };
    
    cell.TwoBlock = ^(void)
    {
        if ([model.order_status isEqualToString:@"0"]) {
            //立即支付
            //立即支付
            PayCenterController *vc  = [PayCenterController new];
            vc.price = model.order_amount;
            vc.endTime = model.expire_time;
            vc.order_sn = model.order_sn;
            vc.order_type = @"1";
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else if ([model.order_status isEqualToString:@"1"]||[model.order_status isEqualToString:@"5"] ||[model.order_status isEqualToString:@"6"])
        {
          //联系客服
            NSString *phone = [NSString stringWithFormat:@"tel:%@",model.customer_service_phone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
            
        }
        
        else if ([model.order_status isEqualToString:@"2"])
        {
            //查看课表
            MineClassController *vc  = [MineClassController new];
             vc.course_id = model.course_id;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else if ([model.order_status isEqualToString:@"3"])
        {
            //评价
            MineDiscussController *vc = [MineDiscussController new];
            vc.goods_img = model.course_img;
            vc.goods_name = model.course_title;
            vc.goods_price = model.unit_price;
            vc.goods_number = @"1";
            vc.goods_id = model.course_id;
            vc.isType = @"1";
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            //删除订单
            [DataSourceTool deleteOrder:0 order_sn:model.order_sn order_type:@"1" ViewController:self success:^(id json) {
                
                if ([json[@"errcode"] integerValue]==0) {
                    
                    [MBProgressHUD showSuccess:@"删除成功" toView:self.view complete:nil];
                    [tableview reloadData];
                }
            } failure:^(NSError *error) {
                
            }];
            
        }
    };


    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseModel *model = dataArray[indexPath.section];
    MineMeetOrderDetailController *vc  = [MineMeetOrderDetailController new];
    vc.order_num = model.order_sn;
    vc.course_id = model.course_id;
    [self.navigationController pushViewController:vc animated:YES];
    
}


- (void)loadData
{
    [DataSourceTool trainOrders:[NSString stringWithFormat:@"%ld",pageIndex] order_status:[NSString stringWithFormat:@"%ld",IsCell]ViewController:self success:^(id json) {
        if ([json[@"errcode"] integerValue]==0) {
            
          
            if (pageIndex==1)
            {
                [dataArray removeAllObjects];
                [tableview.mj_header endRefreshing];
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
                
                CourseModel * item = [CourseModel new];
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
