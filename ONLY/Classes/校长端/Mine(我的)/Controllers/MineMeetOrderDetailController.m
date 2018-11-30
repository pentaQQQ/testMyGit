//
//  MineMeetOrderDetailController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/1/17.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineMeetOrderDetailController.h"
#import "BLPopView.h"
#import "MineClassController.h"
#import "manyDetailModel.h"
#import "PeopleItem.h"
#import "MBProgressHUD+Extension.h"
#import "MineDiscussController.h"
#import "CountDown.h"
#import "PayCenterController.h"
@interface MineMeetOrderDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) CountDown * countDown;
@end

@implementation MineMeetOrderDetailController
{
    UITableView *tableview;
    NSInteger state;
    UILabel *timeLabel;
    BLPopView *alert;
    NSMutableArray *dataArray;
    NSString  *myStatus;
    NSArray *tempArray;
    
    NSString *order_amount; //allprice
    NSString *unit_price;  //unitprice
    NSString *order_sn;    //order num
    NSString *add_time_str;
    NSString *status;
    
    NSString *course_title;
    NSString *course_img;
    NSString *pay_type;
    NSString *invoice_title;
    NSString *invoice_type;
    NSString *person_num;
    NSString *customer_service_phone;
    NSString * address;
    
    NSString *beginTime;
    NSString *endTime;
    UILabel *retainLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = colorWithRGB(0xEFEFF4);
    
    self.fd_prefersNavigationBarHidden = YES;
    
    [self commonInit];
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
    //tableview.separatorStyle= UITableViewCellSeparatorStyleNone;
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
    if (section==0) {
        
        return 1;
    }
    else if (section==1)
    {
        return 3;
    }
    else if (section==2)
    {
        return tempArray.count+1;
    }
    else {
        
       return 1;
        
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 30;
    }
    else
    {
        return 0.0000001;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 85;
    }
    else if (indexPath.section==1)
    {
        if      (indexPath.row==0)  {return 118;}
        else if (indexPath.row==1)  {return 48 ;}
        else                        {return 70 ;}
    }
    else if (indexPath.section==2)
    {
        return 48 ;
    }
    else
    {
        return 48;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID1 = @"MineMeetOrderDetail1";
    static NSString *cellID2 = @"MineMeetOrderDetail2";
    static NSString *cellID3 = @"MineMeetOrderDetail3";
    static NSString *cellID4 = @"MineMeetOrderDetail4";
    static NSString *cellID5 = @"MineMeetOrderDetail5";
    static NSString *cellID6 = @"MineMeetOrderDetail6";
    
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellID1];
    UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellID2];
    UITableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:cellID3];
    UITableViewCell *cell4 = [tableView dequeueReusableCellWithIdentifier:cellID4];
    UITableViewCell *cell5 = [tableView dequeueReusableCellWithIdentifier:cellID5];
    UITableViewCell *cell6 = [tableView dequeueReusableCellWithIdentifier:cellID6];
    
    if (cell1==nil) {
        cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *label1 = [UILabel new];
        label1.tag = 501;
        [cell1.contentView addSubview:label1];
        [self makeLabel:label1 font:14 color:colorWithRGB(0x333333) text:@"订单号：10000545484"];
        label1.sd_layout.leftSpaceToView(cell1.contentView,18).topSpaceToView(cell1.contentView,25).heightIs(14).widthIs(SCREEN_WIDTH/2);
        
        UILabel *label3 = [UILabel new];
        [cell1.contentView addSubview:label3];
        label3.tag = 502;
        [self makeLabel:label3 font:14 color:colorWithRGB(0xEA5520)text:@"已付款"];
        label3.textAlignment = NSTextAlignmentRight;
        label3.sd_layout.rightSpaceToView(cell1.contentView,16).topSpaceToView(cell1.contentView,25).heightIs(14).widthIs(SCREEN_WIDTH/2-18);
        
        UILabel *label2 = [UILabel new];
        label2.tag = 503;
        [cell1.contentView addSubview:label2];
        [self makeLabel:label2 font:14 color:colorWithRGB(0x999999) text:@"下单时间：2016-12-25 10:51:15"];
        label2.sd_layout.leftSpaceToView(cell1.contentView,18).topSpaceToView(label1,17).heightIs(14).rightSpaceToView(cell1.contentView,16);
        
    }
    
    if (cell2==nil) {
        
        cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *label1 = [UILabel new];
        [cell2.contentView addSubview:label1];
        [self makeLabel:label1 font:14 color:colorWithRGB(0x333333) text:@"微点平台"];
        label1.sd_layout.leftSpaceToView(cell2.contentView,18).topSpaceToView(cell2.contentView,25).heightIs(14).widthIs(SCREEN_WIDTH/2);
        
        UIImageView *imageview = [UIImageView new];
        imageview.tag = 504;
        [cell2.contentView addSubview:imageview];
        imageview.image = [UIImage imageNamed:@"图层59"];
        cornerRadiusView(imageview, 3);
        imageview.sd_layout.leftSpaceToView(cell2.contentView,17).topSpaceToView(label1,12).widthIs(107*SCREEN_PRESENT).heightIs(61);
        
        UILabel *label2 = [UILabel new];
        [cell2.contentView addSubview:label2];
        label2.tag = 505;
        [self makeLabel:label2 font:14 color:colorWithRGB(0x333333) text:@"庆祝昂立微点平台成立纪念台历"];
        label2.sd_layout.leftSpaceToView(imageview,12).topSpaceToView(cell2.contentView,51).heightIs(14).rightSpaceToView(cell2.contentView,5);
        
        UILabel *label4 = [UILabel new];
        [cell2.contentView addSubview:label4];
        label4.tag = 506;
        [self makeLabel:label4 font:14 color:colorWithRGB(0x999999) text:@"x12"];
        label4.textAlignment = NSTextAlignmentRight;
        label4.sd_layout.rightSpaceToView(cell2.contentView,17).topSpaceToView(label2,17).heightIs(12).widthIs(48);
        
        UILabel *label3 = [UILabel new];
        label3.tag = 507;
        [cell2.contentView addSubview:label3];
        [self makeLabel:label3 font:14 color:colorWithRGB(0x999999) text:@"￥200.00"];
        label3.sd_layout.leftSpaceToView(imageview,12).topSpaceToView(label2,17).heightIs(12).rightSpaceToView(label4,13);
        
    }
    
    if (cell3==nil) {
        cell3 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID3];
        cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *label1 = [UILabel new];
        label1.tag = 509;
        [cell3.contentView addSubview:label1];
        [self makeLabel:label1 font:14 color:colorWithRGB(0x333333) text:@"支付方式"];
        label1.sd_layout.leftSpaceToView(cell3.contentView,17).topSpaceToView(cell3.contentView,18).heightIs(14).widthIs(SCREEN_WIDTH/2);
        
        UILabel *label2 = [UILabel new];
        [cell3.contentView addSubview:label2];
        label2.tag = 510;
        [self makeLabel:label2 font:14 color:colorWithRGB(0x999999) text:@"￥4800.00"];
        label2.textAlignment = NSTextAlignmentRight;
        label2.sd_layout.rightSpaceToView(cell3.contentView,17).topSpaceToView(cell3.contentView,18).heightIs(14).widthIs(SCREEN_WIDTH/2);
    }
    
    if (cell4==nil) {
        cell4 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID4];
        cell4.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        UILabel *label1 = [UILabel new];
        [cell4.contentView addSubview:label1];
        [self makeLabel:label1 font:14 color:colorWithRGB(0x333333) text:@"发票信息"];
        label1.sd_layout.leftSpaceToView(cell4.contentView,17).topSpaceToView(cell4.contentView,18).heightIs(14).widthIs(SCREEN_WIDTH/2);
        
        UILabel *label2 = [UILabel new];
        label2.tag = 511;
        [cell4.contentView addSubview:label2];
        [self makeLabel:label2 font:14 color:colorWithRGB(0x9999999) text:@"纸质发票"];
        label2.textAlignment = NSTextAlignmentRight;
        label2.sd_layout.rightSpaceToView(cell4.contentView,17).topSpaceToView(cell4.contentView,18).heightIs(14).widthIs(SCREEN_WIDTH/2);
        
        UILabel *label3 = [UILabel new];
        label3.tag  = 512;
        [cell4.contentView addSubview:label3];
        [self makeLabel:label3 font:12 color:colorWithRGB(0x9999999) text:@"个人"];
        label3.textAlignment = NSTextAlignmentRight;
        label3.sd_layout.rightSpaceToView(cell4.contentView,17).topSpaceToView(label2,10).heightIs(12).widthIs(SCREEN_WIDTH/2);
        
        UILabel *label4 = [UILabel new];
        [cell4.contentView addSubview:label4];
        [self makeLabel:label4 font:12 color:colorWithRGB(0x9999999) text:@"抬头"];
        label4.sd_layout.leftSpaceToView(cell4.contentView,17).topSpaceToView(label1,10).heightIs(12).widthIs(SCREEN_WIDTH/2);
        
    }
    if (cell5==nil) {
        cell5 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID5];
        cell5.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIImageView *imageview = [UIImageView new];
        imageview.image = [UIImage imageNamed:@"支持服务_人员列表_mine"];
        [cell5.contentView addSubview:imageview];
        imageview.sd_layout.leftSpaceToView(cell5.contentView,18).topSpaceToView(cell5.contentView,18).heightIs(14).widthIs(12);
        
        UILabel *label1 = [UILabel new];
        [cell5.contentView addSubview:label1];
        label1.tag = 600;
        [self makeLabel:label1 font:14 color:colorWithRGB(0x333333) text:@"温宇达"];
        label1.sd_layout.leftSpaceToView(imageview,7).topSpaceToView(cell5.contentView,18).heightIs(14).widthIs(SCREEN_WIDTH/2);
        
        UIButton *codeBtn = [UIButton new];
        [cell5.contentView addSubview:codeBtn];
        cornerRadiusView(codeBtn, 3);
        codeBtn.sd_layout.rightSpaceToView(cell5.contentView,16).topSpaceToView(cell5.contentView,5).widthIs(107).heightIs(31);
        codeBtn.backgroundColor = colorWithRGB(0x00A9EB);
        codeBtn.userInteractionEnabled = NO;
        [codeBtn setTitle:@"查看二维码" forState:UIControlStateNormal];
        [codeBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        codeBtn.titleLabel.font = font(14);
        
    }
    
    if (cell6==nil) {
        cell6 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID6];
        cell6.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UILabel *label2 = [UILabel new];
        [cell6.contentView addSubview:label2];
        label2.tag = 500;
        [self makeLabel:label2 font:14 color:colorWithRGB(0xEA5520) text:@"¥ 2400.00"];
        label2.sd_layout.rightSpaceToView(cell6.contentView,0).topSpaceToView(cell6.contentView,18).heightIs(14).widthIs(88);
        
        UILabel *label1 = [UILabel new];
        [cell6.contentView addSubview:label1];
        [self makeLabel:label1 font:14 color:colorWithRGB(0x333333) text:@"共6人，合计"];
        label1.textAlignment = NSTextAlignmentRight;
        label1.sd_layout.rightSpaceToView(label2,2).topSpaceToView(cell6.contentView,18).heightIs(14).widthIs(SCREEN_WIDTH/2);
        
    }
    
 //****************************************//
    if (indexPath.section==0) {
        UILabel *label1 = [cell1.contentView viewWithTag:501];
        UILabel *label2 = [cell1.contentView viewWithTag:502];
        UILabel *label3 = [cell1.contentView viewWithTag:503];
        
        label1.text = [NSString stringWithFormat:@"订单号:%@",order_sn];
        label2.text = status;
        label3.text = [NSString stringWithFormat:@"下单时间:%@",add_time_str];
        
        return cell1;
    }
    else if (indexPath.section==1)
    {
        if (indexPath.row==0) {
            UIImageView *imageview =[cell2.contentView viewWithTag:504];
            UILabel *label1 = [cell2.contentView viewWithTag:505];
            UILabel *label2 = [cell2.contentView viewWithTag:506];
            UILabel *label3 = [cell2.contentView viewWithTag:507];
            
            label1.text = course_title;
            label2.text = @"";
            label3.text = [NSString stringWithFormat:@"¥ %@",unit_price];
            
            [imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,course_img]] placeholderImage:[UIImage imageNamed:@"图层59"]];
            
            
            return cell2;
            
        }
        else if (indexPath.row==1)
        {
            UILabel *label1 = [cell3.contentView viewWithTag:510];
            UILabel *label2= [cell3.contentView viewWithTag:509];
            label2.text = @"支付方式";
            label1.text = pay_type;
            return cell3;
        }
        else
        {
            UILabel *label1 = [cell4.contentView viewWithTag:511];
            UILabel *label2 = [cell4.contentView viewWithTag:512];
            
            label1.text = invoice_type;
            label2.text = invoice_title;
            return cell4;
        }
      
    }
    
    else if (indexPath.section==2)
    {
        if (indexPath.row==0) {
            UILabel *label1 = [cell3.contentView viewWithTag:510];
            UILabel *label2= [cell3.contentView viewWithTag:509];
            label2.text = [NSString stringWithFormat:@"培训人员(%@)",person_num];
            label1.text = @"";
            return cell3;
        }
        else {
            PeopleItem *model = tempArray[indexPath.row-1];
            UILabel *label1 = [cell5.contentView viewWithTag:600];
            label1.text = model.name;
            return cell5;
        }
       
    }
    else {
        UILabel *lab = [cell6.contentView viewWithTag:500];
        lab.text = [NSString stringWithFormat:@"¥ %@",order_amount];
        return cell6;
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
    
    for (int i = 0; i<2; i++) {
        
        UIButton *btn = [UIButton new];
        [view addSubview:btn];
        btn.tag = 50+i;
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


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        if (indexPath.row==0) {
            
        }
        else {
            PeopleItem *model = tempArray[indexPath.row-1];
            alert = [[BLPopView alloc] initWithAlertViewHeight:320 name:model.name mudi:course_title time:add_time_str address:address];
        }
    }
}

- (void)btnClick:(UIButton *)btn
{
    //第二个按钮
    if (btn.tag == 51) {
        
        if ([myStatus isEqualToString:@"0"]) {
            
            [DataSourceTool deleteOrder:1 order_sn:self.order_num order_type:@"1" ViewController:self success:^(id json) {
                
                if ([json[@"errcode"] integerValue]==0) {
                    
                    [MBProgressHUD showSuccess:@"取消成功" toView:self.view complete:nil];
                    [tableview reloadData];
                }
            } failure:^(NSError *error) {
                
            }];
        }
        
        else if ([myStatus isEqualToString:@"3"]||[myStatus isEqualToString:@"4"])
        {
            //查看课表
            MineClassController *vc  = [MineClassController new];
            vc.course_id = self.course_id;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
        else if ([myStatus isEqualToString:@"6"]||[myStatus isEqualToString:@"1"]||[myStatus isEqualToString:@"5"])
        {
            //不做处理
        }
        else
        {
            //联系客服
            NSString *phone = [NSString stringWithFormat:@"tel:%@",customer_service_phone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
        }
    }
    else
    {
        if ([myStatus isEqualToString:@"0"]) {
            //立即支付
            PayCenterController *vc  = [PayCenterController new];
            vc.price = order_amount;
            vc.endTime = endTime;
            vc.order_sn = self.order_num;
            vc.order_type = @"1";
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ([myStatus isEqualToString:@"1"]||[myStatus isEqualToString:@"5"] ||[myStatus isEqualToString:@"6"])
        {
            //联系客服
            NSString *phone = [NSString stringWithFormat:@"tel:%@",customer_service_phone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
            
        }
        
        else if ([myStatus isEqualToString:@"2"])
        {
            //查看课表
            MineClassController *vc  = [MineClassController new];
            vc.course_id = self.course_id;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else if ([myStatus isEqualToString:@"3"])
        {
            //评价
            MineDiscussController *vc = [MineDiscussController new];
            vc.goods_img = course_img;
            vc.goods_name = course_title;
            vc.goods_price = unit_price;
            vc.goods_number = @"x1";
            vc.goods_id =self.course_id ;
            vc.isType = @"1";
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            //删除订单
            [DataSourceTool deleteOrder:0 order_sn:self.order_num order_type:@"1" ViewController:self success:^(id json) {
                
                if ([json[@"errcode"] integerValue]==0) {
                    
                    [MBProgressHUD showSuccess:@"删除成功" toView:self.view complete:nil];
                    [tableview reloadData];
                }
            } failure:^(NSError *error) {
                
            }];
            
        }

    }
    
//    MineClassController *vc = [MineClassController new];
//    [self.navigationController pushViewController:vc animated:YES];
    
}
-(void)commonInit{
    
    self.countDown = [[CountDown alloc] init];
    __weak __typeof(self) weakSelf= self;
    // //每秒回调一次
    [self.countDown countDownWithPER_SECBlock:^{
        
        [weakSelf updateTimeInVisibleCells];
    }];
    
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



//加载网络数据
- (void)loadData
{
    UIButton *btn1 = [self.view viewWithTag:51];
    UIButton *btn2 = [self.view viewWithTag:50];
    
    [DataSourceTool trainOrderDetailID:self.order_num ViewController:self success:^(id json) {
        
        if ([json[@"errcode"] integerValue]==0) {
            
            myStatus = json[@"rsp"][0][@"order_status"];
            order_amount = json[@"rsp"][0][@"order_amount"];
            unit_price = json[@"rsp"][0][@"unit_price"];
            
            order_sn = json[@"rsp"][0][@"order_sn"];
            add_time_str = json[@"rsp"][0][@"add_time_str"];
            status = json[@"rsp"][0][@"status"];
            
            beginTime =json[@"rsp"][0][@"service_time"] ;
            endTime = json[@"rsp"][0][@"expire_time"];
            course_title=json[@"rsp"][0][@"course_title"];
            course_img=json[@"rsp"][0][@"course_img"];
            pay_type=json[@"rsp"][0][@"pay_type"];
            invoice_title=json[@"rsp"][0][@"invoice_title"];
            invoice_type=json[@"rsp"][0][@"invoice_type"];
            person_num=json[@"rsp"][0][@"person_num"];
            customer_service_phone = json[@"rsp"][0][@"customer_service_phone"];
            address = json[@"rsp"][0][@"address"];
           
            NSMutableArray *temp = [NSMutableArray array];
            
            for (NSDictionary *dic in json[@"rsp"][0][@"persons"]) {
                PeopleItem *model = [PeopleItem new];
                [model setValuesForKeysWithDictionary:dic];
                [temp addObject:model];
                
            }
            tempArray = temp;
            
            if ([myStatus isEqualToString:@"0"])
            {
                
                [btn1 setTitle:@"取消订单" forState:UIControlStateNormal];
                [btn2 setTitle:@"立即支付" forState:UIControlStateNormal];
            }
            //这个有尾款
            else if ([myStatus isEqualToString:@"1"])
            {
                [btn1 setHidden:YES];
                [btn2 setTitle:@"联系客服" forState:UIControlStateNormal];
            }
            
            else if ([myStatus isEqualToString:@"2"])
            {
                [btn1 setTitle:@"联系客服" forState:UIControlStateNormal];
                [btn2 setTitle:@"查看课表" forState:UIControlStateNormal];
            }
            else if ([myStatus isEqualToString:@"3"])
            {
                [btn1 setTitle:@"查看课表" forState:UIControlStateNormal];
                [btn2 setTitle:@"评价" forState:UIControlStateNormal];
            }
            else if ([myStatus isEqualToString:@"4"])
            {
                [btn1 setTitle:@"查看课表" forState:UIControlStateNormal];
                [btn2 setTitle:@"删除订单" forState:UIControlStateNormal];
                
            }
            else if ([myStatus isEqualToString:@"5"])
            {
                [btn1 setHidden:YES];
                [btn2 setTitle:@"联系客服" forState:UIControlStateNormal];
            }
            else if ([myStatus isEqualToString:@"6"])
            {
                [btn1 setHidden:YES];
                [btn2 setTitle:@"联系客服" forState:UIControlStateNormal];
            }
            else if ([myStatus isEqualToString:@"7"])
            {
                [btn1 setTitle:@"联系客服" forState:UIControlStateNormal];
                [btn2 setTitle:@"删除订单" forState:UIControlStateNormal];
            }
            else
            {
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
            
            [tableview reloadData];
            
        }
    } failure:^(NSError *error) {
        
    }];
}


@end
