//
//  MineManyOrderController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/1/16.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineManyOrderController.h"
#import "MineOrder.h"
#import "MineOrderDetailController.h"
#import "ManyOrderModel.h"
#import "MBProgressHUD+Extension.h"
#import "MineDiscussController.h"
#import "PayCenterController.h"
@interface MineManyOrderController ()<CBLSelectViewDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation MineManyOrderController
{
    UITableView *tableview;
    NSMutableArray *dataArray;
    NSInteger  pageIndex;
    NSInteger  IsCell;
    NSInteger  status;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    self.fd_prefersNavigationBarHidden = YES;
    pageIndex = 1;
    IsCell = 999;
    dataArray = [NSMutableArray array];
    [self setNavView];
    
    [self loadPhurseData];
   
    
}

- (void)btnClickIndex:(NSInteger)index
{
    pageIndex = 1;
    NSLog(@"++++++++++++++%ld",index);
    if (index==7) {
        IsCell = 999;
    }
    else if (index==0) {
        IsCell = 0;
    }
    else if (index==1) {
        IsCell = 4;
    }
    else if (index==2) {
        IsCell = 5;
    }
    else if (index==3) {
        IsCell = 6;
    }
    else
    {
    }
    [self loadPhurseData];
  
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
    titleLabel.text = @"众筹订单";
    
    CBLSelectView *selView = [[CBLSelectView alloc] initWithTitle:@[@"全部",@"待付款",@"待发货",@"待收货",@"待评价"] setFrame:CGRectMake(0, 68, SCREEN_WIDTH, 48) setIndex:@[@1,@0,@0,@0,@0]];
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
        
        [weakself loadPhurseData];
        
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
       
        return 0.0000001;
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
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.OrderBtnOne.layer.borderWidth = 1;
    cell.OrderBtnOne.layer.borderColor = colorWithRGB(0x999999).CGColor;
    cell.OrderBtnOne.layer.cornerRadius = 3;
    cell.OrderBtnOne.layer.masksToBounds = YES;
    
    cell.OrderBtnTwo.layer.borderWidth = 1;
    cell.OrderBtnTwo.layer.borderColor = colorWithRGB(0xEA5520).CGColor;
    cell.OrderBtnTwo.layer.cornerRadius = 3;
    cell.OrderBtnTwo.layer.masksToBounds = YES;
    
    if (cell==nil) {
        
        cell =[[[NSBundle mainBundle] loadNibNamed:@"MineOrder" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    ManyOrderModel *model = dataArray[indexPath.section];
    cell.OrderNum.text = [NSString stringWithFormat:@"x%@",model.goods_number];
    cell.OrderNumCode.text = model.order_sn;
    cell.OrderPrice.text = [NSString stringWithFormat:@"¥%@",model.goods_price];
    cell.OrderName.text = model.goods_name;
    if ([model.order_type isEqualToString:@"0"]) {
        cell.OrderPayPrice.text = [NSString stringWithFormat:@"总计%@件商品",model.goods_number];
        cell.OrderPay.text = [NSString stringWithFormat:@"合计: %@(运费到付)",model.goods_amount];
    }
    else {

        cell.OrderPayPrice.text = [NSString stringWithFormat:@"已付%@",model.has_pay_amount];
        cell.OrderPay.text = [NSString stringWithFormat:@"需补费用 %@（运费到付）",model.goods_amount];
    }
    
    [cell.OrderImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,model.good_img]] placeholderImage:[UIImage imageNamed:@"图层59"]];
    
    cell.OrderState.text = model.status;
    
    if ([model.order_status isEqualToString:@"0"]) {
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
        [cell.OrderBtnOne setHidden:YES];
        [cell.OrderBtnTwo setTitle:@"联系客服" forState:UIControlStateNormal];
    }
    else if ([model.order_status isEqualToString:@"3"])
    {
        [cell.OrderBtnOne setHidden:YES];
        [cell.OrderBtnTwo setTitle:@"联系客服" forState:UIControlStateNormal];
    }
    else if ([model.order_status isEqualToString:@"4"])
    {
        [cell.OrderBtnOne setHidden:YES];
        [cell.OrderBtnTwo setTitle:@"联系客服" forState:UIControlStateNormal];
        
    }
    else if ([model.order_status isEqualToString:@"5"])
    {
        [cell.OrderBtnOne setTitle:@"查看物流" forState:UIControlStateNormal];
        [cell.OrderBtnTwo setTitle:@"确认收货" forState:UIControlStateNormal];
    }
    else if ([model.order_status isEqualToString:@"6"])
    {
        [cell.OrderBtnOne setTitle:@"联系客服" forState:UIControlStateNormal];
        [cell.OrderBtnTwo setTitle:@"评价" forState:UIControlStateNormal];
    }
    else if ([model.order_status isEqualToString:@"7"])
    {
        [cell.OrderBtnOne setTitle:@"查看物流" forState:UIControlStateNormal];
        [cell.OrderBtnTwo setTitle:@"删除订单" forState:UIControlStateNormal];
    }
    else if ([model.order_status isEqualToString:@"8"])
    {
        [cell.OrderBtnOne setHidden:YES];
        [cell.OrderBtnTwo setTitle:@"联系客服" forState:UIControlStateNormal];
        
    }
    else if ([model.order_status isEqualToString:@"9"])
    {
        [cell.OrderBtnOne setHidden:YES];
        [cell.OrderBtnTwo setTitle:@"联系客服" forState:UIControlStateNormal];
        
    }
    else if ([model.order_status isEqualToString:@"10"])
    {
        [cell.OrderBtnOne setTitle:@"删除订单" forState:UIControlStateNormal];
        [cell.OrderBtnTwo setTitle:@"联系客服" forState:UIControlStateNormal];
    }
    else
    {
        [cell.OrderBtnOne setTitle:@"删除订单" forState:UIControlStateNormal];
        [cell.OrderBtnTwo setTitle:@"联系客服" forState:UIControlStateNormal];
    }
    
    //最后2个按钮的点击事件
    cell.oneBlock = ^(void)
    {
        if ([model.order_status isEqualToString:@"0"]) {
            //立即支付
            
            [DataSourceTool deleteOrder:1 order_sn:model.order_sn order_type:@"0" ViewController:self success:^(id json) {
                
                if ([json[@"errcode"] integerValue]==0) {
                    
                    [MBProgressHUD showSuccess:@"取消成功" toView:self.view complete:nil];
                    [tableview reloadData];
                }
            } failure:^(NSError *error) {
                
            }];
        }
        
        else if ([model.order_status isEqualToString:@"5"])
        {
            //查看物流
        }
        
        else if ([model.order_status isEqualToString:@"6"])
        {
            //联系客服
            NSString *phone = [NSString stringWithFormat:@"tel:%@",model.customer_service_phone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
            
        }
        else if ([model.order_status isEqualToString:@"7"])
        {
            //查看物流
        }
        else if ([model.order_status isEqualToString:@"10"]||[model.order_status isEqualToString:@"-1"])
        {
            //删除订单
            [DataSourceTool deleteOrder:0 order_sn:model.order_sn order_type:@"0" ViewController:self success:^(id json) {
                
                if ([json[@"errcode"] integerValue]==0) {
                    
                    [MBProgressHUD showSuccess:@"删除成功" toView:self.view complete:nil];
                    [tableview reloadData];
                }
            } failure:^(NSError *error) {
                
            }];
        }
        else
        {
          //没点击事件
            
        }
    };
    
    cell.TwoBlock = ^(void)
    {
        if ([model.order_status isEqualToString:@"0"]) {
            //立即支付
            PayCenterController *vc  = [PayCenterController new];
            vc.price = model.goods_amount;
            vc.endTime = model.expire_time;
            vc.order_sn = model.order_sn;
            vc.order_type = @"0";
            [self.navigationController pushViewController:vc animated:YES];

        }
        //只有 这个有尾款
        else if ([model.order_status isEqualToString:@"5"])
        {
            //确认收货
            [DataSourceTool deleteOrder:2 order_sn:model.order_sn order_type:@"0" ViewController:self success:^(id json) {
                
                if ([json[@"errcode"] integerValue]==0) {
                    
                    [MBProgressHUD showSuccess:@"确认收货" toView:self.view complete:nil];
                    [tableview reloadData];
                }
            } failure:^(NSError *error) {
                
            }];
            
        }
        
        else if ([model.order_status isEqualToString:@"7"])
        {
            //删除订单
            [DataSourceTool deleteOrder:0 order_sn:model.order_sn order_type:@"0" ViewController:self success:^(id json) {
                
                if ([json[@"errcode"] integerValue]==0) {
                    
                    [MBProgressHUD showSuccess:@"删除成功" toView:self.view complete:nil];
                    [tableview reloadData];
                }
            } failure:^(NSError *error) {
                
            }];
            
        }
        else if ([model.order_status isEqualToString:@"6"])
        {
            //评价
            MineDiscussController *vc = [MineDiscussController new];
            vc.goods_img = model.goods_img;
            vc.goods_name = model.goods_name;
            vc.goods_price = model.goods_price;
            vc.goods_number = model.goods_number;
            vc.goods_id = model.goods_id;
            vc.isType = @"0";
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else
        {
            //联系客服
            NSString *phone = [NSString stringWithFormat:@"tel:%@",model.customer_service_phone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
            
        }
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ManyOrderModel *model = dataArray[indexPath.section];
    MineOrderDetailController *vc  = [MineOrderDetailController new];
    vc.order_num = model.order_sn;
    [self.navigationController pushViewController:vc animated:YES];

}

//加载已购买数据
- (void)loadPhurseData
{
    [DataSourceTool crowOrderInfoPage:[NSString stringWithFormat:@"%ld",pageIndex] order_status:[NSString stringWithFormat:@"%ld",IsCell]ViewController:self success:^(id json) {
        if ([json[@"errcode"] integerValue]==0) {
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
                
                ManyOrderModel * item = [ManyOrderModel new];
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
    
    [self loadPhurseData];
}


@end
