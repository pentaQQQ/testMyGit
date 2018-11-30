//
//  MineServerDetailController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/1/19.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineServerDetailController.h"
#import "MIneServerHeadCell.h"
#import "MineServerSecondCell.h"
#import "MineOneCell.h"
#import "MineBillCell.h"
#import "MineSerDiscussController.h"
#import "manyDetailModel.h"
#import "SerDeailModel.h"
#import "MBProgressHUD+Extension.h"
#import "CountDown.h"
#import "PayCenterController.h"
@interface MineServerDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) CountDown * countDown;
@end

@implementation MineServerDetailController
{
    UITableView *tableview;
    NSArray *dataArray;
    NSArray *titleArray;
    NSArray *myArray;
    NSString *myPhone;
    NSString *beginTime;
    NSString *endTime;
    UILabel *retainLabel;
    UILabel *timeLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = colorWithRGB(0xEFEFF4);
    self.fd_prefersNavigationBarHidden = YES;
    titleArray = @[@[],@[@"",@"服务时间",@"详细地址",@"联系电话"],@[@"支付方式",@"发票信息",@"备注"],@[@"合计"]];
    [self commonInit];
    [self setNavView];
    [self makeBottomView];
    [self makeFootView];
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

- (void)makeFootView
{
    UIView *footView = [UIView new];
    footView.frame =  CGRectMake(16, 0, SCREEN_WIDTH-16, 186);
      tableview.tableFooterView = footView;
    
    UILabel *footlabel = [UILabel new];
    footlabel.font =font(12);
    [footView addSubview:footlabel];
    footlabel.textColor = colorWithRGB(0x999999);
    footlabel.text = @"1.支持差旅费标准：往返车费、住宿费（线下自行沟通摊\n2.住宿标准：安静、卫生、方便即可，按当地普通标准间标准即可\n3.每天工作时间不超过10小时，如贵校有特殊情况需要工作人员加班工作，请提前与工作人员沟通。\n4.请贵校投资人自行负责分校财务工作。\n5.未尽事宜或临时突发事宜再协商。\n6.对于支持中心外派主管，贵校有监督权，在工作中欧有不合适的地方，请于总部联系协商解决。";
    footlabel.sd_layout.leftSpaceToView(footView,5).rightSpaceToView(footView,5).topSpaceToView(footView,0).bottomSpaceToView(footView,0);
    footlabel.numberOfLines = 0;
}

- (void)makeBottomView
{
    UIView *view  = [UIView new];
    [self.view addSubview:view];
    view.backgroundColor = WhiteColor;
    view.sd_layout.leftEqualToView(self.view).bottomEqualToView(self.view).heightIs(64).rightEqualToView(self.view);

    retainLabel = [UILabel new];
    [view addSubview:retainLabel];
    [self makeLabel:retainLabel font:12 color:colorWithRGB(0x595656) text:@"剩余付款时间:"];
    retainLabel.sd_layout.leftSpaceToView(view,15).topSpaceToView(view,19).heightIs(12).widthIs(78);
    
    timeLabel = [UILabel new];
    [view addSubview:timeLabel];
    timeLabel.textAlignment = NSTextAlignmentLeft;
    [self makeLabel:timeLabel font:14 color:colorWithRGB(0xEA5520) text:@""];
    timeLabel.sd_layout.leftSpaceToView(view,15).topSpaceToView(retainLabel,7).heightIs(13).widthIs(90);
    
    for (int i = 0; i<2; i++) {
        
        UIButton *btn = [UIButton new];
        [view addSubview:btn];
        btn.sd_layout.rightSpaceToView(view,15+i*(76*SCREEN_PRESENT+15)).widthIs(76*SCREEN_PRESENT).heightIs(33).bottomSpaceToView(view,15);
        btn.tag = 50+i;
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

- (void)makeLabel:(UILabel *)label font:(CGFloat)fonts color:(UIColor *)color text:(NSString *)str
{
    label.text = str;
    label.font = font(fonts);
    label.textColor = color;
    label.textAlignment = NSTextAlignmentLeft;
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
        return 4;
    }
    else if (section==2)
    {
        return 3;
    }
    else
    {
        return 1;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 85;
    }
    else if (indexPath.section==1)
    {
        if (indexPath.row==0) {
            return 75;
        }
        else {
            return 44;
        }
    }
    else if (indexPath.section==2)
    {
        if (indexPath.row==1) {
            return 70;
        }
        else {
            return 44;
        }
    }
    else
    {
        return 44;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"MIneServerHeadCell";
    static NSString *cellID1 = @"MineServerSecondCell";
    static NSString *cellID2 = @"MineOneCell";
    static NSString *cellID3 = @"MineBillCell";
    
    MIneServerHeadCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    MineServerSecondCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellID1];
    MineOneCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellID2];
    MineBillCell *cell3 = [tableView dequeueReusableCellWithIdentifier:cellID3];
    
    if (cell == nil ) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MIneServerHeadCell" owner:nil options:nil] firstObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (cell1 == nil ) {
        cell1 = [[[NSBundle mainBundle] loadNibNamed:@"MineServerSecondCell" owner:nil options:nil] firstObject];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (cell2 == nil ) {
        cell2 = [[[NSBundle mainBundle] loadNibNamed:@"MineOneCell" owner:nil options:nil] firstObject];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (cell3 == nil ) {
        cell3 = [[[NSBundle mainBundle] loadNibNamed:@"MineBillCell" owner:nil options:nil] firstObject];
        cell3.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    SerDeailModel *model = myArray[0];
    if (indexPath.section==0) {
        cell.serverNum.text= [NSString stringWithFormat:@"订单号：%@",model.order_sn];
        cell.serverAddtime.text = [NSString stringWithFormat:@"下单时间：%@",model.add_time_str];
        cell.serverStatus.text = model.status;
        return cell;
    }
    
    else if (indexPath.section==1)
    {
        if (indexPath.row==0) {
            cell1.abc.text = model.member_name;
            cell1.serverNumber.text = model.service_count;
            cell1.range.text = model.level_name;
            cell1.serverType.text = [NSString stringWithFormat:@"服务类型：%@ %@",model.service_type_name,model.service_name];
            cell1.serverPrice.text = model.order_amount;
            if ([model.sex isEqualToString:@"0"]) {
                cell1.sexImg.image = [UIImage imageNamed:@"member_mine_male"];
            }
            else
            {
                cell1.sexImg.image = [UIImage imageNamed:@"member_mine_female"];
            }
            
            
            return cell1;
        }
        else {
            
            cell2.titleLab.text = titleArray[indexPath.section][indexPath.row];
            cell2.detailLab.text = dataArray[indexPath.section][indexPath.row];
            
            return cell2;
        }
        
    }
    else if (indexPath.section==2)
    {
        if(indexPath.row==1) {
            cell3.titleLab.text = titleArray[indexPath.section][indexPath.row];
            cell3.detailLab.text = dataArray[indexPath.section][indexPath.row];
            
            return cell3;
            
        }
        else {
            cell2.titleLab.text = titleArray[indexPath.section][indexPath.row];
            cell2.detailLab.text = dataArray[indexPath.section][indexPath.row];
            
            return cell2;
            
        }
    }
    else
        
    {
        cell2.titleLab.text = titleArray[indexPath.section][indexPath.row];
        cell2.detailLab.text = dataArray[indexPath.section][indexPath.row];
        
        return cell2;
    }

}

//底部按钮的点击事件（发表评价界面先放在这里）
- (void)btnClick:(UIButton *)btn
{
    if (btn.tag == 50) {
        if ([self.order_status isEqualToString:@"0"]) {
            if ([self.is_receive isEqualToString:@"1"]) {
               
              //立即支付
                //立即支付
                PayCenterController *vc  = [PayCenterController new];
                vc.price = dataArray[3][0];
                vc.endTime = endTime;
                vc.order_sn = self.order_sn;
                vc.order_type =  @"2";
                [self.navigationController pushViewController:vc animated:YES];
            }
            else{
               //取消订单
                //@"取消订单"
                [DataSourceTool deleteOrder:1 order_sn:self.order_sn order_type:@"2" ViewController:self success:^(id json) {
                    
                    if ([json[@"errcode"] integerValue]==0) {
                        
                        [MBProgressHUD showSuccess:@"取消成功" toView:self.view complete:nil];
                        [tableview reloadData];
                    }
                } failure:^(NSError *error) {
                    
                }];
            }
        }
        //只有 这个有尾款
        else if ([self.order_status isEqualToString:@"1"])
        {
            //联系客服
            NSString *phone = [NSString stringWithFormat:@"tel:%@",myPhone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
        }
        
        else if ([self.order_status isEqualToString:@"2"])
        {
            //联系客服
            NSString *phone = [NSString stringWithFormat:@"tel:%@",myPhone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];

        }
        else if ([self.order_status isEqualToString:@"3"])
        {
            //确认结束
            [DataSourceTool deleteOrder:2 order_sn:self.order_sn order_type:@"2" ViewController:self success:^(id json) {
                
                if ([json[@"errcode"] integerValue]==0) {
                    
                    [MBProgressHUD showSuccess:@"确认结束" toView:self.view complete:nil];
                    
                }
            } failure:^(NSError *error) {
                
            }];

        }
        else if ([self.order_status isEqualToString:@"4"])
        {
            //评价
            
        }
        else if ([self.order_status isEqualToString:@"5"])
        {
           //删除订单
            [DataSourceTool deleteOrder:0 order_sn:self.order_sn order_type:@"2" ViewController:self success:^(id json) {
                
                if ([json[@"errcode"] integerValue]==0) {
                    
                    [MBProgressHUD showSuccess:@"删除成功" toView:self.view complete:nil];
                    [tableview reloadData];
                }
            } failure:^(NSError *error) {
                
            }];
        }
        else{
            
            //删除订单
            //@"删除订单"
            [DataSourceTool deleteOrder:0 order_sn:self.order_sn order_type:@"2" ViewController:self success:^(id json) {
                
                if ([json[@"errcode"] integerValue]==0) {
                    
                    [MBProgressHUD showSuccess:@"删除成功" toView:self.view complete:nil];
                    [tableview reloadData];
                }
            } failure:^(NSError *error) {
                
            }];
   
        }
 
    }
    //第一个按钮的点击
    else
    {
        if ([self.order_status isEqualToString:@"0"]) {
            if ([self.is_receive isEqualToString:@"1"]) {
                //@"取消订单"
                [DataSourceTool deleteOrder:1 order_sn:self.order_sn order_type:@"2" ViewController:self success:^(id json) {
                    
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
        else if ([self.order_status isEqualToString:@"1"])
        {
            
        }
        
        else if ([self.order_status isEqualToString:@"2"])
        {
            
        }
        else{
            
            //联系客服
            NSString *phone = [NSString stringWithFormat:@"tel:%@",myPhone];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:phone]];
        }
        
    }
}

- (void)loadData
{
    
    UIButton *btn1 = [self.view viewWithTag:51];
    UIButton *btn2 = [self.view viewWithTag:50];
    
   [DataSourceTool supportOrderDetailID:self.order_sn ViewController:self success:^(id json) {
       if ([json[@"errcode"] integerValue]==0) {

           NSMutableArray *temp = [NSMutableArray array];
           
           SerDeailModel * model = [SerDeailModel new];
           [model setValuesForKeysWithDictionary:json[@"rsp"][0]];
           [temp addObject:model];
           myArray = temp;
           SerDeailModel *model1 =temp[0];
           dataArray = @[@[],@[@"",model1.support_time,model1.service_address,model1.contact_phone],@[model1.pay_type,model1.invoice_title,model1.remark],@[model1.order_amount]];
           myPhone = model1.customer_service_phone;
           beginTime = [NSString stringWithFormat:@"%ld",(long)model.service_time];
           endTime = [NSString stringWithFormat:@"%ld",(long)model.expire_time];
           self.order_status = model.order_status;
           self.is_receive = model.is_receive;
           
           [tableview reloadData];
           
//           if ([model.sex isEqualToString:@"0"]) {
//               cell.sex.image = [UIImage imageNamed:@"member_mine_male"];
//           }
//           else
//           {
//               cell.sex.image = [UIImage imageNamed:@"member_mine_female"];
//           }
           
           if ([model1.order_status isEqualToString:@"0"]) {
               if ([model.is_receive isEqualToString:@"1"]) {
                   [btn1 setTitle:@"取消订单" forState:UIControlStateNormal];
                   [btn2 setTitle:@"立即支付" forState:UIControlStateNormal];
               }
               else{
                   [btn1 setHidden:YES];
                   [btn2 setTitle:@"取消订单" forState:UIControlStateNormal];
               }
           }
           //只有 这个有尾款
           else if ([model1.order_status isEqualToString:@"1"])
           {
               [btn1 setHidden:YES];
               [btn2 setTitle:@"联系客服" forState:UIControlStateNormal];
           }
           
           else if ([model1.order_status isEqualToString:@"2"])
           {
               [btn1 setHidden:YES];
               [btn2 setTitle:@"联系客服" forState:UIControlStateNormal];
           }
           else if ([model1.order_status isEqualToString:@"3"])
           {
               [btn1 setTitle:@"联系客服" forState:UIControlStateNormal];
               [btn2 setTitle:@"确认结束" forState:UIControlStateNormal];
           }
           else if ([model1.order_status isEqualToString:@"4"])
           {
               [btn1 setTitle:@"联系客服" forState:UIControlStateNormal];
               [btn2 setTitle:@"评价" forState:UIControlStateNormal];
           }
           else if ([model1.order_status isEqualToString:@"5"])
           {
               [btn1 setTitle:@"联系客服" forState:UIControlStateNormal];
               [btn2 setTitle:@"删除订单" forState:UIControlStateNormal];
           }
           else{
               [btn1 setTitle:@"联系客服" forState:UIControlStateNormal];
               [btn2 setTitle:@"删除订单" forState:UIControlStateNormal];
               
           }
           
           kWeakSelf(self);
           if ([model1.order_status isEqualToString:@"0"]) {
               timeLabel.text = [weakself getNowTimeWithString:endTime begindate:beginTime];
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
    //每秒回调一次
    [self.countDown countDownWithPER_SECBlock:^{
        
        [weakSelf updateTimeInVisibleCells];
    }];
    
}

#pragma mark - 倒计时相关方法
-(void)updateTimeInVisibleCells{
    
    
}

-(NSString *)getNowTimeWithString:(NSString *)aTimeString begindate:(NSString *)beginTime1{
    
    NSDateFormatter* formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    // 截止时间date格式
    NSDate  *expireDate = [NSDate dateWithTimeIntervalSince1970:[aTimeString doubleValue]];
    NSDate  *nowDate = [NSDate dateWithTimeIntervalSince1970:[beginTime1 doubleValue]];;
    
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

@end
