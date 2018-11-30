//
//  MemberHomeDetailController.m
//  ONLY
//
//  Created by zfd on 17/1/15.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MemberHomeDetailController.h"
#import "MemberHomeDetailCell.h"
#import "MemberOneCell.h"
#import "MemberTwoCell.h"
#import "MemberThreeCell.h"
#import "MBProgressHUD+Extension.h"

static NSInteger const botton_button_tag = 100;

@interface MemberHomeDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView* tableView; /*表视图*/
@property (nonatomic,strong) NSMutableArray* dataSource; /*数据模型*/
@property (nonatomic,strong) UIView* bottom_view; /*地部的view*/
@property (nonatomic,strong) UIButton* start_serve_button; /*开始服务*/
@property (nonatomic,strong) UIButton* order_receiving_button; /*我要接单*/
@property (nonatomic,strong) UIButton* reject_order_button; /*拒绝接单*/

@end

@implementation MemberHomeDetailController
{
    NSMutableArray *dataArray;
    NSArray *titlArray;
    NSString *beginTime;
    NSString *endtime;
    NSString *status;
    NSString *orderTime;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    [self createNavi];
    [self.tableView setSectionFooterHeight:0.0f];
    
    titlArray = @[@[[NSString stringWithFormat:@"订单编号:%@",self.order_sn]],@[@"市场 淡季活动",@"联系人",@"联系电话",@"服务时间",@"服务地址",@"详细地址"],@[@"支付方式",@"发票信息",@"抬头",@"备注"]];
    
    dataArray = [NSMutableArray arrayWithObjects:@[self.order_sn],@[@"",@"",@"",@"",@"",@""],@[@"",@"",@"",@""], nil];
    
    if(self.type == 3)
    {
        [_bottom_view  removeFromSuperview];
    }
    
    [self loadData];
    
}

-(UITableView*) tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(15, Nav, SCREEN_WIDTH - 30, SCREEN_HEIGHT - Nav-60) style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = ClearColor;
        _tableView.layer.masksToBounds = YES;
        _tableView.layer.cornerRadius = 3.0f;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        [self bottom_view];
    }
    return _tableView;
}

-(UIView*) bottom_view
{
    if (!_bottom_view)
    {
        _bottom_view = [[UIView alloc] init];
        [self.view addSubview:_bottom_view];
        _bottom_view.sd_layout
        .bottomSpaceToView(self.view, 0)
        .leftSpaceToView(self.view,0)
        .rightSpaceToView(self.view,0)
        .heightIs(Nav);
        _bottom_view.backgroundColor = WhiteColor;
        
        switch (_type) {
            case 0:
            {
                [_bottom_view addSubview:self.start_serve_button];
                _start_serve_button.sd_layout
                .topSpaceToView(_bottom_view,9)
                .leftSpaceToView(_bottom_view,15)
                .rightSpaceToView(_bottom_view,15)
                .heightIs(45);
            }
                break;
                
            case 1:
            {
                [_bottom_view addSubview:self.order_receiving_button];
                 [_bottom_view addSubview:self.reject_order_button];
                
                _order_receiving_button.sd_layout
                .topSpaceToView(_bottom_view,9)
                .leftSpaceToView(_bottom_view,15)
                .widthIs(SCREEN_WIDTH / 2 - 7 - 15)
                .heightIs(45);
                
                _reject_order_button.sd_layout
                .topSpaceToView(_bottom_view,9)
                .rightSpaceToView(_bottom_view,15)
                .widthIs(_order_receiving_button.width)
                .heightIs(45);
            }
                break;
            case 2:
            {
                [_bottom_view addSubview:self.start_serve_button];
                _start_serve_button.sd_layout
                .topSpaceToView(_bottom_view,9)
                .leftSpaceToView(_bottom_view,15)
                .rightSpaceToView(_bottom_view,15)
                .heightIs(45);
            }
                break;
            default:
                break;
        }
    }
    return _bottom_view;
}

-(UIButton*) start_serve_button
{
    if (!_start_serve_button)
    {
        _start_serve_button = [UIButton buttonWithType:UIButtonTypeCustom];
        _start_serve_button.backgroundColor = BlueColor;
        _start_serve_button.layer.cornerRadius = 4.0f;
        
        if (self.type == 2) {
            _start_serve_button.tag = botton_button_tag+3;
          [_start_serve_button setTitle:@"结束服务" forState:UIControlStateNormal];
        }else {
            _start_serve_button.tag = botton_button_tag;
          [_start_serve_button setTitle:@"开始服务" forState:UIControlStateNormal];
        }
        [_start_serve_button setTitleColor:WhiteColor forState:UIControlStateNormal];
        _start_serve_button.titleLabel.font = font(14.0f);
        _start_serve_button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_start_serve_button addTarget:self action:@selector(startServeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _start_serve_button;
}

-(UIButton*) order_receiving_button
{
    if (!_order_receiving_button)
    {
        _order_receiving_button = [UIButton buttonWithType:UIButtonTypeCustom];
        _order_receiving_button.backgroundColor = colorWithRGB(0xF77142);
        _order_receiving_button.layer.cornerRadius = 4.0f;
        _order_receiving_button.tag = botton_button_tag + 1;
        [_order_receiving_button setTitle:@"我要接单" forState:UIControlStateNormal];
        [_order_receiving_button setTitleColor:WhiteColor forState:UIControlStateNormal];
        _order_receiving_button.titleLabel.font = font(14.0f);
        _order_receiving_button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_order_receiving_button addTarget:self action:@selector(startServeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _order_receiving_button;
}

-(UIButton*) reject_order_button
{
    if (!_reject_order_button)
    {
        _reject_order_button = [UIButton buttonWithType:UIButtonTypeCustom];
        _reject_order_button.backgroundColor = BlueColor;
        _reject_order_button.layer.cornerRadius = 4.0f;
        _reject_order_button.tag = botton_button_tag + 2;
        [_reject_order_button setTitle:@"拒绝接单" forState:UIControlStateNormal];
        [_reject_order_button setTitleColor:WhiteColor forState:UIControlStateNormal];
        _reject_order_button.titleLabel.font = font(14.0f);
        _reject_order_button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [_reject_order_button addTarget:self action:@selector(startServeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _reject_order_button;
}

-(void) createNavi
{
    /*类似于波浪线的图片*/
    UIImageView* ripple_image = [[UIImageView alloc] init];
    [self.view addSubview:ripple_image];
    ripple_image.sd_layout
    .topSpaceToView(self.view,-20)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(176);
    ripple_image.image = [UIImage imageNamed:@"member_mine_bg"];
    
    self.view.backgroundColor = TableviewGroupColor;
    UIView* navi_view = [[UIView alloc] init];
    [self.view addSubview:navi_view];
    navi_view.backgroundColor = BlueColor;
    navi_view.sd_layout
    .topSpaceToView(self.view,0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(Nav);
    
    UILabel* navi_label = [MyControl titleLabelWithText:@"订单详情" textColor:WhiteColor bgColor:ClearColor Font:18.0f TextAlignmentType:textAlignmentTypeCenter];
    [navi_view addSubview:navi_label];
    navi_label.sd_layout
    .topSpaceToView(navi_view,20)
    .leftSpaceToView(navi_view,0)
    .rightSpaceToView(navi_view,0)
    .heightIs(44);
    
    UIButton* back_button = [UIButton buttonWithType:UIButtonTypeCustom];
    [navi_view addSubview:back_button];
    back_button.sd_layout
    .topSpaceToView(navi_view,20)
    .leftSpaceToView(navi_view,-10)
    .widthIs(60)
    .heightIs(44);
    [back_button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [back_button addTarget:self action:@selector(backItemAction:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark - UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 1;
    }
    else if (section == 1)
    {
        return 6;
    }
    else
    {
        return 4;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        if (_type == 1)
        {
            return 109;
        }
        else
        {
            return 85;
        }
    }
    else
    {
        if ((indexPath.section == 2 && indexPath.row == 2) || (indexPath.section == 1 && indexPath.row == 5))
        {
            return UITableViewAutomaticDimension;
        }
        else
        {
            return 47;
        }
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 20.0f;
    }
    else
    {
        return 10.0f;
    }
}

-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* header_view = [[UIView alloc] init];
    if (section == 0)
    {
        header_view.backgroundColor = ClearColor;
    }
    else
    {
        header_view.backgroundColor = TableviewGroupColor;
    }
    return header_view;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MemberHomeDetailCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"MemberHomeDetailCell"];
    MemberOneCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"MemberOneCell"];
    MemberTwoCell *cell3 = [tableView dequeueReusableCellWithIdentifier:@"MemberTwoCell"];
    MemberThreeCell *cell4 = [tableView dequeueReusableCellWithIdentifier:@"MemberThreeCell"];
    
    if (cell1 == nil) {
        
        cell1 = [[[NSBundle mainBundle] loadNibNamed:@"MemberHomeDetailCell" owner:nil options:nil] firstObject];
    }
    
    if (cell2 == nil) {
        
        cell2 = [[[NSBundle mainBundle] loadNibNamed:@"MemberOneCell" owner:nil options:nil] firstObject];
    }
    
    if (cell3 == nil) {
        
        cell3 = [[[NSBundle mainBundle] loadNibNamed:@"MemberTwoCell" owner:nil options:nil] firstObject];
    }
    
    if (cell4 == nil) {
        
        cell4 = [[[NSBundle mainBundle] loadNibNamed:@"MemberThreeCell" owner:nil options:nil] firstObject];
    }
    
    if (indexPath.section==0) {
        if (self.type==1) {
            cell1.order_sn.text = titlArray[0][0];
            cell1.order_begin.text = [NSString stringWithFormat:@"开始时间:%@",beginTime];
            cell1.order_end.text = [NSString stringWithFormat:@"结束时间:%@",endtime];
            cell1.order_status.text = status;
            return cell1;
        }
        else
        {   cell4.order_sn.text = titlArray[0][0];
            cell4.order_status.text = status;
            cell4.order_time.text =  [NSString stringWithFormat:@"下单时间:%@",orderTime];
            return cell4;
        }
    }
    else if(indexPath.section == 1)
    {
        if (indexPath.row==0) {
            cell2.order_name.text  = titlArray[indexPath.section][indexPath.row];
            cell2.order_price.text = dataArray[indexPath.section][indexPath.row];
            return cell2;
        }
        else{
            cell3.order_title.text  = titlArray[indexPath.section][indexPath.row];
            cell3.order_detail.text = dataArray[indexPath.section][indexPath.row];
            return cell3;
        }
    }
    else
    {
            cell3.order_title.text = titlArray[indexPath.section][indexPath.row];
            cell3.order_detail.text = dataArray[indexPath.section][indexPath.row];
            return cell3;
    }
    
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
}

-(void) startServeAction:(UIButton*) sender
{
    switch (sender.tag) {
        case botton_button_tag:
        {
             NSLog(@"开始服务");
            [self beginService];
        }
            break;
        case botton_button_tag + 1:
        {
             NSLog(@"我要接单");
            [self receiveOrder:@"1"];
            
        }
            break;
        case botton_button_tag + 2:
        {
             NSLog(@"拒绝接单");
            [self receiveOrder:@"0"];
        }
            break;
        case botton_button_tag + 3:
        {
            NSLog(@"拒绝接单");
            [self endService];
        }
            break;
        default:
            break;
    }
}

-(void) backItemAction:(UIButton*) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


//加载详情数据
- (void)loadData
{
   [DataSourceTool getMarketSupportDetail:self.order_sn ViewController:self success:^(id json) {
       dataArray  = [NSMutableArray array];
       if ([json[@"errcode"] integerValue]==0) {
           
//               service_type = 0,
//               member_name = 午餐会,
//               support_time = 2017-02-01 - 2017-02-28,
//               invoice_title = ,
//               add_time_str = 2017-03-02 16:08:14,
//               status = 交易关闭,
//               service_time = 1490670772,
//               service_name = 淡季活动,
//               order_status = 0,
//               end_date = 2017-02-28,
//               pay_type = 未支付,
//               contact_phone = 嘎嘎嘎,
//               expire_time = ,
//               order_amount = 88.00,
//               has_invoice = 0,
//               invoice_type = 不开发票,
//               order_sn = 1703024209417176,
//               add_time = 1488442094,
//               expire_time_str = ,
//               service_type_name = 市场,
//               start_date = 2017-02-01,
//               service_address = 湖南省 湘潭市 雨湖区,
//               remark = 无,
//               address = 滚滚滚,
//               is_receive = 0
           
        beginTime = json[@"rsp"][0][@"start_date"];
        endtime = json[@"rsp"][0][@"end_date"];
        status = json[@"rsp"][0][@"status"];
        orderTime = json[@"rsp"][0][@"add_time_str"];
           
        dataArray = [NSMutableArray arrayWithObjects:@[self.order_sn],@[json[@"rsp"][0][@"order_amount"],json[@"rsp"][0][@"member_name"],json[@"rsp"][0][@"contact_phone"],json[@"rsp"][0][@"support_time"],json[@"rsp"][0][@"service_address"],json[@"rsp"][0][@"address"]],@[json[@"rsp"][0][@"pay_type"],json[@"rsp"][0][@"invoice_type"],json[@"rsp"][0][@"has_invoice"],json[@"rsp"][0][@"remark"]], nil];
           
    [self.tableView  reloadData];
           
       }
   } failure:^(NSError *error) {
       
   }];

}

- (void)receiveOrder:(NSString *)type
{
    [DataSourceTool acceptSupportOrder: self.order_sn is_receive:type ViewController:self success:^(id json) {
        if ([json[@"errcode"] integerValue]==0) {
            NSString *str = @"";
            if ([type isEqualToString:@"0"]) {
                str = @"拒绝成功";
            }
            else
            {
                str = @"接单成功";
            }
            [MBProgressHUD showSuccess:str toView:self.view complete:^{
                
               // [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        
    } failure:^(NSError *error) {
        
    }];

}

//市场人员开始服务
- (void)beginService
{
  [DataSourceTool beginSupportOrder:self.order_sn ViewController:self success:^(id json) {
      
       if ([json[@"errcode"] integerValue]==0) {
           [MBProgressHUD showSuccess:@"开始服务成功" toView:self.view complete:^{
               
               //[self.navigationController popViewControllerAnimated:YES];
           }];
       }
  } failure:^(NSError *error) {
      
  }];

}

//市场人员结束服务
- (void)endService
{
    [DataSourceTool endSupportOrder:self.order_sn ViewController:self success:^(id json) {
        
        if ([json[@"errcode"] integerValue]==0) {
            
            [MBProgressHUD showSuccess:@"结束成功" toView:self.view complete:^{
                
               // [self.navigationController popViewControllerAnimated:YES];
            }];
        }
    } failure:^(NSError *error) {
        
    }];
    
}

@end
