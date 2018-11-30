//
//  MineOrderDetailController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/1/16.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//  众筹的订单详情

#import "MineOrderDetailController.h"
#import "MineDiscussController.h"
#import "manyDetailModel.h"
#import "MBProgressHUD+Extension.h"
#import "CountDown.h"
#import "PayCenterController.h"
@interface MineOrderDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) CountDown * countDown;
@end

@implementation MineOrderDetailController
{
    UITableView *tableview;
    NSInteger state;
    UILabel *timeLabel;
    NSMutableArray *dataArray;
    NSArray *tempArray;
    NSArray *tempArray1;
    NSString *myStatus;
    NSString *myPhone;
    NSString *goods_img ;
    NSString *goods_name;
    NSString *goods_price;
    NSString *goods_number ;
    NSString *goods_id ;
    NSString *beginTime;
    NSString *endTime;
    UILabel *retainLabel;
    
  
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = colorWithRGB(0xEFEFF4);
    self.fd_prefersNavigationBarHidden = YES;
    
    tempArray = @[@[],@[],@[@"",@"支付方式",@"",@"备注"],@[@"商品金额总计",@"已付款",@"运费",@"实付款"]];
    tempArray1 = @[@[],@[],@[@"",@"",@"",@""],@[@"",@"",@"",@""]];
    [self commonInit];
    [self beginArray];
    [self setNavView];
    [self makeBottobView];
    [self loadData];
    
}

//创建导航栏（自定义）
- (void)setNavView
{
    UIView *view  = [UIView new];
    view.backgroundColor = colorWithRGB(0x00A9EB);
    [self.view addSubview:view];
    view.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(64);
    
    UIImageView *imageview = [UIImageView new];
    imageview.image = [UIImage imageNamed:@"member_mine_bg"];
    [self.view addSubview:imageview];
    imageview.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(view,0).heightIs(174);
    
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
    titleLabel.text = @"订单详情";
    
    tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,16).topSpaceToView(view,0).bottomSpaceToView(self.view,64);
    cornerRadiusView(tableview, 3);
    tableview.showsVerticalScrollIndicator = NO;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0||section==1) {
        
        return 1;
    }
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        
        return 40;
    }
    else
    {
        return 0.00000001;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0||indexPath.section==1) {
        return 85;
    }
    else if (indexPath.section==2)
    {
        if      (indexPath.row==0)      {return 42 ;}
        else if (indexPath.row==2)      {return 70 ;}
        else if (indexPath.row==1)      {return 76 ;}
        else                            {return 48 ;}
    }
    else
    {
        return 48;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID1 = @"MineOrderDetail1";
    static NSString *cellID2 = @"MineOrderDetail2";
    static NSString *cellID3 = @"MineOrderDetail3";
    static NSString *cellID4 = @"MineOrderDetail4";
    static NSString *cellID5 = @"MineOrderDetail5";
    
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellID1];
    UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellID2];
    UITableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:cellID3];
    UITableViewCell *cell4 = [tableView dequeueReusableCellWithIdentifier:cellID4];
    UITableViewCell *cell5 = [tableView dequeueReusableCellWithIdentifier:cellID5];
    
    if (cell1==nil) {
        cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *label1 = [UILabel new];
        label1.tag = 100;
        [cell1.contentView addSubview:label1];
        [self makeLabel:label1 font:14 color:colorWithRGB(0x333333) text:@"订单号：10000545484"];
        label1.sd_layout.leftSpaceToView(cell1.contentView,18).topSpaceToView(cell1.contentView,25).heightIs(14).widthIs(SCREEN_WIDTH/2);
        
        UILabel *label3 = [UILabel new];
        label3.tag = 101;
        [cell1.contentView addSubview:label3];
        label3.textAlignment = NSTextAlignmentRight;
        [self makeLabel:label3 font:14 color:colorWithRGB(0xEA5520)text:@"已付款"];
        label3.sd_layout.rightSpaceToView(cell1.contentView,16).topSpaceToView(cell1.contentView,25).heightIs(14).widthIs(SCREEN_WIDTH/2-18);
        
        UILabel *label2 = [UILabel new];
        label2.tag = 102;
        [cell1.contentView addSubview:label2];
        [self makeLabel:label2 font:14 color:colorWithRGB(0x999999) text:@"下单时间：2016-12-25 10:51:15"];
        label2.sd_layout.leftSpaceToView(cell1.contentView,18).topSpaceToView(label1,17).heightIs(14).rightSpaceToView(cell1.contentView,16);
        
    }
    
    if (cell2==nil) {
        
        cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *imageview = [UIImageView new];
        imageview.tag = 104;
        [cell2.contentView addSubview:imageview];
        imageview.image = [UIImage imageNamed:@"图层59"];
        cornerRadiusView(imageview, 3);
        imageview.sd_layout.leftSpaceToView(cell2.contentView,17).topSpaceToView(cell2.contentView,1).widthIs(107*SCREEN_PRESENT).heightIs(61);
        
        UILabel *label2 = [UILabel new];
        label2.tag = 105;
        [cell2.contentView addSubview:label2];
        [self makeLabel:label2 font:14 color:colorWithRGB(0x333333) text:@"庆祝昂立微点平台成立纪念台历"];
        label2.sd_layout.leftSpaceToView(imageview,12).topSpaceToView(cell2.contentView,10).heightIs(14).rightSpaceToView(cell2.contentView,5);
        
        UILabel *label4 = [UILabel new];
        label4.tag = 106;
        [cell2.contentView addSubview:label4];
        [self makeLabel:label4 font:14 color:colorWithRGB(0x999999) text:@"x12"];
        label4.textAlignment = NSTextAlignmentRight;
        label4.sd_layout.rightSpaceToView(cell2.contentView,17).topSpaceToView(label2,17).heightIs(12).widthIs(48);
        
        UILabel *label3 = [UILabel new];
        label3.tag = 107;
        [cell2.contentView addSubview:label3];
        [self makeLabel:label3 font:14 color:colorWithRGB(0x999999) text:@"￥200.00"];
        label3.sd_layout.leftSpaceToView(imageview,12).topSpaceToView(label2,17).heightIs(12).rightSpaceToView(label4,13);
        
    }
    if (cell5==nil) {
        
        cell5 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
        cell5.selectionStyle = UITableViewCellSelectionStyleNone;
        cell5.separatorInset = UIEdgeInsetsMake(0, SCREEN_HEIGHT, 0, 0);
        
        UILabel *label2 = [UILabel new];
        [cell5.contentView addSubview:label2];
        [self makeLabel:label2 font:14 color:colorWithRGB(0x333333) text:@"微点平台"];
        label2.sd_layout.leftSpaceToView(cell5.contentView,18).topSpaceToView(cell5.contentView,17).heightIs(14).rightSpaceToView(cell5.contentView,5);
        
    }
    
    if (cell3==nil) {
        
        cell3 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID3];
        cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *label1 = [UILabel new];
        label1.tag= 112;
        [cell3.contentView addSubview:label1];
        [self makeLabel:label1 font:14 color:colorWithRGB(0x333333) text:@"支付方式"];
        label1.sd_layout.leftSpaceToView(cell3.contentView,17).topSpaceToView(cell3.contentView,18).heightIs(14).widthIs(SCREEN_WIDTH/2);
        
        UILabel *label2 = [UILabel new];
        label2.tag = 113;
        [cell3.contentView addSubview:label2];
        [self makeLabel:label2 font:14 color:colorWithRGB(0x999999) text:@"￥4800.00"];
        label2.textAlignment = NSTextAlignmentRight;
        label2.sd_layout.rightSpaceToView(cell3.contentView,17).topSpaceToView(cell3.contentView,18).heightIs(14).widthIs(SCREEN_WIDTH/2);
    }
    
    if (cell4==nil) {
        
        cell4 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID4];
        cell4.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *label1 = [UILabel new];
        label1.tag = 108;
        [cell4.contentView addSubview:label1];
        [self makeLabel:label1 font:14 color:colorWithRGB(0x333333) text:@"发票信息"];
        label1.sd_layout.leftSpaceToView(cell4.contentView,17).topSpaceToView(cell4.contentView,18).heightIs(14).widthIs(SCREEN_WIDTH/2);
        
        UILabel *label2 = [UILabel new];
        label2.tag = 109;
        [cell4.contentView addSubview:label2];
        [self makeLabel:label2 font:14 color:colorWithRGB(0x9999999) text:@"纸质发票"];
        label2.textAlignment = NSTextAlignmentRight;
        label2.sd_layout.rightSpaceToView(cell4.contentView,17).topSpaceToView(cell4.contentView,18).heightIs(14).widthIs(SCREEN_WIDTH/2);
        
        UILabel *label3 = [UILabel new];
        label3.tag = 110;
        [cell4.contentView addSubview:label3];
        [self makeLabel:label3 font:12 color:colorWithRGB(0x9999999) text:@"个人"];
        label3.textAlignment = NSTextAlignmentRight;
        label3.sd_layout.rightSpaceToView(cell4.contentView,17).topSpaceToView(label2,10).heightIs(12).widthIs(SCREEN_WIDTH/2);
        
        UILabel *label4 = [UILabel new];
        label4.tag = 111;
        [cell4.contentView addSubview:label4];
        [self makeLabel:label4 font:12 color:colorWithRGB(0x9999999) text:@"抬头"];
        label4.sd_layout.leftSpaceToView(cell4.contentView,17).topSpaceToView(label1,10).heightIs(12).widthIs(SCREEN_WIDTH/2);
        
    }
    manyDetailModel *model = dataArray[0];
    if (indexPath.section==0) {
        UILabel *lab1 = [cell1.contentView viewWithTag:100];
        UILabel *lab2 = [cell1.contentView viewWithTag:101];
        UILabel *lab3 = [cell1.contentView viewWithTag:102];
        lab1.text = [NSString stringWithFormat:@"订单号：%@",model.order_sn];
        lab2.text = model.status;
        lab2.textAlignment = NSTextAlignmentRight;
        lab3.text = [NSString stringWithFormat:@"下单时间：%@",model.add_time_str];
        return cell1;
    }
     else if (indexPath.section==1)
     {
         UILabel *lab1 = [cell1.contentView viewWithTag:100];
         UILabel *lab2 = [cell1.contentView viewWithTag:101];
         UILabel *lab3 = [cell1.contentView viewWithTag:102];
         lab1.text = [NSString stringWithFormat:@"%@ %@",USERINFO.memberName,model.contact_phone];
         lab2.text = @"";
         lab3.text = [NSString stringWithFormat:@"%@",model.consignee_address];
         
         return cell1;
     
     }
    else if (indexPath.section==2)
    {
        if (indexPath.row==0) {
            
            return cell5;
        }
        else if (indexPath.row==1)
        {
            UILabel *lab2 = [cell2.contentView viewWithTag:105];
            UILabel *lab3 = [cell2.contentView viewWithTag:106];
            UILabel *lab4 = [cell2.contentView viewWithTag:107];
            lab2.text = model.goods_name;
            lab3.text = [NSString stringWithFormat:@"x%.1f",model.goods_number];
            lab4.text = [NSString stringWithFormat:@"¥%0.2f",model.goods_price];
            
            return cell2;
            return cell2;
        }
        else if (indexPath.row==2)
        {
            UILabel *lab2 = [cell2.contentView viewWithTag:109];
            UILabel *lab3 = [cell2.contentView viewWithTag:110];
            lab2.text = model.invoice_type ;
            lab3.text = model.invoice_title;
            return cell4;
        }
        else {
            UILabel *lab1 = [cell3.contentView viewWithTag:112];
            UILabel *lab2 = [cell3.contentView viewWithTag:113];
            lab1.text = tempArray[indexPath.section][indexPath.row];
            lab2.text = tempArray1[indexPath.section][indexPath.row];
            return cell3;
        }
    }
    else {
        UILabel *lab1 = [cell3.contentView viewWithTag:112];
        UILabel *lab2 = [cell3.contentView viewWithTag:113];
        lab1.text = tempArray[indexPath.section][indexPath.row];
        lab2.text = tempArray1[indexPath.section][indexPath.row];
        return cell3;
    }
}

- (void)makeLabel:(UILabel *)label font:(CGFloat)fonts color:(UIColor *)color text:(NSString *)str
{
    label.text = str;
    label.font = font(fonts);
    label.textColor = color;
    label.textAlignment = NSTextAlignmentLeft;
}

- (void)makeBottobView
{
    UIView *view  = [UIView new];
    [self.view addSubview:view];
    view.backgroundColor = WhiteColor;
    view.sd_layout.leftEqualToView(self.view).bottomEqualToView(self.view).heightIs(64).rightEqualToView(self.view);
    //待支付预定款3个按钮 和订单倒计时
    retainLabel = [UILabel new];
    [view addSubview:retainLabel];
    [self makeLabel:retainLabel font:12 color:colorWithRGB(0x595656) text:@"剩余付款时间:"];
    retainLabel.sd_layout.leftSpaceToView(view,15).topSpaceToView(view,19).heightIs(12).widthIs(78);
    
    timeLabel = [UILabel new];
    [view addSubview:timeLabel];
    timeLabel.textAlignment = NSTextAlignmentLeft;
    [self makeLabel:timeLabel font:10 color:colorWithRGB(0xEA5520) text:@""];
    timeLabel.sd_layout.leftSpaceToView(view,15).topSpaceToView(retainLabel,7).heightIs(13).widthIs(100);
    
    for (int i = 0; i<3; i++) {
      
        UIButton *btn = [UIButton new];
        btn.tag = 50 + i;
        [view addSubview:btn];
        btn.sd_layout.rightSpaceToView(view,15+i*(76*SCREEN_PRESENT+15)).widthIs(76*SCREEN_PRESENT).heightIs(33).bottomSpaceToView(view,15);
        btn.titleLabel.font = font(14);
        btn.layer.borderWidth = 1;
        btn.layer.cornerRadius = 3;
        btn.layer.masksToBounds = YES;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0) {
           btn.layer.borderColor = colorWithRGB(0xEA5520).CGColor;
           [btn setTitleColor:colorWithRGB(0xEA5520) forState:UIControlStateNormal];
        }
        else {

           btn.layer.borderColor = colorWithRGB(0x999999).CGColor;
           [btn setTitleColor:colorWithRGB(0x999999) forState:UIControlStateNormal];
        }
    }
}

- (void)btnClick:(UIButton *)btn
{
    if (btn.tag == 50) {
        if ([myStatus isEqualToString:@"0"]) {
          //立即支付
            PayCenterController *vc  = [PayCenterController new];
            vc.price = tempArray1[3][3];
            vc.endTime = endTime;
            vc.order_sn = self.order_num;
            vc.order_type = @"0";
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else if ([myStatus isEqualToString:@"1"])
        {
            //联系客服
            NSString *phone = [NSString stringWithFormat:@"tel:%@",myPhone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
        }
        else if ([myStatus isEqualToString:@"5"])
        {
            //确认收货
            [DataSourceTool deleteOrder:2 order_sn:self.order_num order_type:@"0" ViewController:self success:^(id json) {
                
                if ([json[@"errcode"] integerValue]==0) {
                    
                    [MBProgressHUD showSuccess:@"确认收货" toView:self.view complete:^{
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                    
                }
            } failure:^(NSError *error) {
                
            }];
        }
        else if ([myStatus isEqualToString:@"6"])
        {
            //评价
            MineDiscussController *vc = [MineDiscussController new];
            vc.goods_img = goods_img;
            vc.goods_name = goods_name;
            vc.goods_price = goods_price;
            vc.goods_number = goods_number;
            vc.goods_id = goods_id;
            vc.isType= @"0";
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([myStatus isEqualToString:@"7"])
        {
          
            //删除订单
            [DataSourceTool deleteOrder:0 order_sn:self.order_num order_type:@"0" ViewController:self success:^(id json) {
                
                if ([json[@"errcode"] integerValue]==0) {
                    
                   
                    [MBProgressHUD showSuccess:@"删除成功" toView:self.view complete:^{
                      [self.navigationController popViewControllerAnimated:YES];
                    }];
                    
                }
            } failure:^(NSError *error) {
                
            }];
        }
     
        else if ([myStatus isEqualToString:@"10"])
        {
            //删除订单
            [DataSourceTool deleteOrder:0 order_sn:self.order_num order_type:@"0" ViewController:self success:^(id json) {
                
                if ([json[@"errcode"] integerValue]==0) {
                    
                    [MBProgressHUD showSuccess:@"删除成功" toView:self.view complete:^{
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                   
                }
            } failure:^(NSError *error) {
                
            }];
        }
        else if ([myStatus integerValue]==-1)
        {
            //删除订单
            [DataSourceTool deleteOrder:0 order_sn:self.order_num order_type:@"0" ViewController:self success:^(id json) {
                
                if ([json[@"errcode"] integerValue]==0) {
                    
                    [MBProgressHUD showSuccess:@"删除成功" toView:self.view complete:^{
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
             
                }
            } failure:^(NSError *error) {
                
            }];
        }
        else
        {
            //联系客服
            NSString *phone = [NSString stringWithFormat:@"tel:%@",myPhone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
        }

        
    }
    else if (btn.tag == 51)
    {
        if ([myStatus isEqualToString:@"0"]) {
        //取消订单
            [DataSourceTool deleteOrder:1 order_sn:self.order_num order_type:@"0" ViewController:self success:^(id json) {
                
                if ([json[@"errcode"] integerValue]==0) {
                    
                    [MBProgressHUD showSuccess:@"取消成功" toView:self.view complete:^{
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                 
                    //[tableview reloadData];
                }
            } failure:^(NSError *error) {
                
            }];
        }
      
        else if ([myStatus isEqualToString:@"5"]||[myStatus isEqualToString:@"6"]||[myStatus isEqualToString:@"7"])
        {
            //查看物流
        }
       
        else if ([myStatus isEqualToString:@"10"]||[myStatus isEqualToString:@"-1"])
        {
           //联系客服
            NSString *phone = [NSString stringWithFormat:@"tel:%@",myPhone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
        }
        else
        {
            //不做处理
        }
    }
    else
    {
        if ([myStatus isEqualToString:@"0"]||[myStatus isEqualToString:@"5"]||[myStatus isEqualToString:@"6"]) {
            //联系客服
            NSString *phone = [NSString stringWithFormat:@"tel:%@",myPhone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];

        }
        else
        {
            //不做处理
        }

    }
}


//加载网络数据
- (void)loadData
{
    UIButton *btn = [self.view viewWithTag:52];
    UIButton *btn1 = [self.view viewWithTag:51];
    UIButton *btn2 = [self.view viewWithTag:50];
    
    [DataSourceTool crowOrderDetailID:self.order_num ViewController:self success:^(id json) {
        
        if ([json[@"errcode"] integerValue]==0) {
            [dataArray removeAllObjects];
            NSMutableArray *temp = [NSMutableArray array];
            
            manyDetailModel * model = [manyDetailModel new];
            [model setValuesForKeysWithDictionary:json[@"rsp"][0]];
            [temp addObject:model];

            dataArray = temp;
            manyDetailModel *model1 = dataArray[0];
            tempArray1 = @[@[],@[],@[@"",model1.pay_type,@"",model1.remark],@[model1.goods_amount,model1.has_pay_amount,@"到付",model1.goods_amount]];
            
            [tableview reloadData];
            
            myStatus = [NSString stringWithFormat:@"%ld",(long)model.order_status];
            beginTime = [NSString stringWithFormat:@"%ld",(long)model.service_time];
            endTime = [NSString stringWithFormat:@"%ld",(long)model.expire_time];
            
            if ([myStatus isEqualToString:@"0"]) {
                 [btn setTitle:@"联系客服" forState:UIControlStateNormal];
                 [btn1 setTitle:@"取消订单" forState:UIControlStateNormal];
                 [btn2 setTitle:@"立即支付" forState:UIControlStateNormal];
                
            }
            else if ([myStatus isEqualToString:@"1"])
            {
                [btn setHidden:YES];
                [btn1 setHidden:YES];
                [btn2 setTitle:@"联系客服" forState:UIControlStateNormal];
            }
            else if ([myStatus isEqualToString:@"2"])
            {
                [btn setHidden:YES];
                [btn1 setHidden:YES];
                [btn2 setTitle:@"联系客服" forState:UIControlStateNormal];
            }
            else if ([myStatus isEqualToString:@"3"])
            {
                [btn setHidden:YES];
                [btn1 setHidden:YES];
                [btn2 setTitle:@"联系客服" forState:UIControlStateNormal];
            }
            else if ([myStatus isEqualToString:@"4"])
            {
                [btn setHidden:YES];
                [btn1 setHidden:YES];
                [btn2 setTitle:@"联系客服" forState:UIControlStateNormal];
            }
            else if ([myStatus isEqualToString:@"5"])
            {
                [btn setTitle:@"联系客服" forState:UIControlStateNormal];
                [btn1 setTitle:@"查看物流" forState:UIControlStateNormal];
                [btn2 setTitle:@"确认收货" forState:UIControlStateNormal];
            }
            else if ([myStatus isEqualToString:@"6"])
            {
                [btn setTitle:@"联系客服" forState:UIControlStateNormal];
                [btn1 setTitle:@"查看物流" forState:UIControlStateNormal];
                [btn2 setTitle:@"评价" forState:UIControlStateNormal];
            }
            else if ([myStatus isEqualToString:@"7"])
            {
                 [btn setHidden:YES];
                [btn1 setTitle:@"查看物流" forState:UIControlStateNormal];
                [btn2 setTitle:@"删除订单" forState:UIControlStateNormal];

            }
            else if ([myStatus isEqualToString:@"8"])
            {
                [btn setHidden:YES];
                [btn1 setHidden:YES];
                [btn2 setTitle:@"联系客服" forState:UIControlStateNormal];
            }
            else if ([myStatus isEqualToString:@"9"])
            {
                [btn setHidden:YES];
                [btn1 setHidden:YES];
                [btn2 setTitle:@"联系客服" forState:UIControlStateNormal];
            }
            else if ([myStatus isEqualToString:@"10"])
            {
                [btn setHidden:YES];
                [btn1 setTitle:@"联系客服" forState:UIControlStateNormal];
                [btn2 setTitle:@"删除订单" forState:UIControlStateNormal];
            }
            else
            {
                [btn setHidden:YES];
                [btn1 setTitle:@"联系客服" forState:UIControlStateNormal];
                [btn2 setTitle:@"删除订单" forState:UIControlStateNormal];
            }
            kWeakSelf(self);
            if ([myStatus isEqualToString:@"0"]) {
               timeLabel.text = [weakself getNowTimeWithString:endTime];
            }
            else
            {
                [retainLabel setHidden:YES];
                [timeLabel setHidden:YES];
            }
            
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)commonInit{
    
    self.countDown = [[CountDown alloc] init];
    __weak __typeof(self) weakSelf= self;
    // //每秒回调一次
    [self.countDown countDownWithPER_SECBlock:^{
        
        [weakSelf updateTimeInVisibleCells];
    }];
    
}
- (void)beginArray
{
    
    dataArray = [NSMutableArray array];
    manyDetailModel *model = [manyDetailModel new];
    model.service_time = 0;
    model.invoice_title= @"";
    model.consignee_address= @"";
    model.add_time_str= @"";
    model.status= @"";
    model.consignee= @"";
    model.order_status= 0;
    model.goods_name= @"";
    model.pay_type= @"";
    model.contact_phone= @"";
    model.expire_time= 0;
    model.goods_img= @"";
    model.has_invoice= @"";
    model.invoice_type= @"";
    model.order_sn= 0;
    model.add_time= 0;
    model.goods_price= 0;
    model.goods_number= 0;
    model.has_pay_amount= @"";
    model.remark= @"";
    model.order_type= 0;
    [dataArray addObject:model];
    
}
#pragma mark - 倒计时相关方法
-(void)updateTimeInVisibleCells{
   
   timeLabel.text =   [self getNowTimeWithString:endTime];
 
}

-(NSString *)getNowTimeWithString:(NSString *)aTimeString {
    
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 截止时间date格式
    NSDate  *expireDate = [NSDate dateWithTimeIntervalSince1970:[aTimeString doubleValue]];
    NSDate  *nowDate = [NSDate date];
    
    NSTimeInterval timeInterval =[expireDate timeIntervalSinceDate:nowDate];
    
    int days = (int)(timeInterval/(3600*24));
    int hours = (int)((timeInterval-days*24*3600)/3600);
    int minutes = (int)(timeInterval-days*24*3600-hours*3600)/60;
    int seconds = timeInterval-days*24*3600-hours*3600-minutes*60;
    
    NSString *dayStr;NSString *hoursStr;NSString *minutesStr;NSString *secondsStr;
    //天
    dayStr = [NSString stringWithFormat:@"%d",days];
    //小时
    hoursStr = [NSString stringWithFormat:@"%d",hours];
    //分钟
    if(minutes<10)
        minutesStr = [NSString stringWithFormat:@"0%d",minutes];
    else
        minutesStr = [NSString stringWithFormat:@"%d",minutes];
    //秒
    if(seconds < 10)
        secondsStr = [NSString stringWithFormat:@"0%d", seconds];
    else
        secondsStr = [NSString stringWithFormat:@"%d",seconds];
    if (hours<=0&&minutes<=0&&seconds<=0) {
        return @"订单已取消";
    }
    if (days) {
        return [NSString stringWithFormat:@"%@天 %@小时 %@分 %@秒", dayStr,hoursStr, minutesStr,secondsStr];
    }
    return [NSString stringWithFormat:@"%@小时 %@分 %@秒",hoursStr , minutesStr,secondsStr];
}

-(void)dealloc{
    NSLog(@"%s dealloc",object_getClassName(self));
}



@end
