//
//  PayCenterController.m
//  ONLY
//
//  Created by Dylan on 07/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "PayCenterController.h"
#import "PayCenterCell.h"
#import "PayCenterCell_1.h"
#import "CountDown.h"
#import "WXApi.h"
#import "AlipaySDK.h"
#import "PaySuccessController.h"

typedef NS_ENUM(NSUInteger, PaymentWay) {
    PaymentWay_None,
    PaymentWay_WeChat,
    PaymentWay_Alipay
};

@interface PayCenterController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) CountDown * countDown;
@property (nonatomic, assign) PaymentWay paymentWay;
@end

@implementation PayCenterController{
    UIView * _bottomBGView;
}
- (instancetype)init{
    if (self = [super init]) {
        self.endTime = @"0";
        self.price = @"0";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(WexinSucess) name:@"WXPaySuccess" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AlipaySucess) name:@"AlipaySuccess" object:nil];
    
    
    [self commonInit];
    [self setupNavi];
    [self setupUI];
}

//微信支付成功 后的回调
- (void)WexinSucess
{
    PaySuccessController *vc  = [PaySuccessController new];
    vc.order_type = self.order_type;
    [self.navigationController pushViewController:vc animated:YES];
}

//支付宝成功 的回调
- (void)AlipaySucess
{
    PaySuccessController *vc  = [PaySuccessController new];
    vc.order_type = self.order_type;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"");
}

-(void)commonInit{
    self.countDown = [[CountDown alloc] init];
    self.paymentWay = PaymentWay_None;
    __weak __typeof(self) weakSelf= self;
    //   //每秒回调一次
    [self.countDown countDownWithPER_SECBlock:^{
        [weakSelf updateTimeInVisibleCells];
    }];

}
-(void)setupNavi{
    self.title = @"支付中心";
    self.view.backgroundColor = AppBackColor;
}

-(void)setupUI{
    
    [self setupBottomView];
    
    UIImageView * bgIV = [UIImageView new];
    bgIV.image = [UIImage imageNamed:@"head"];
    [self.view addSubview:bgIV];
    [bgIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    self.tableView.backgroundColor = [UIColor clearColor];
    

    self.tableView.tableFooterView = [UIView new];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 16, 63, 16));
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PayCenterCell" bundle:nil] forCellReuseIdentifier:@"PayCenterCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"PayCenterCell_1" bundle:nil] forCellReuseIdentifier:@"PayCenterCell_1"];
}


-(void)setupBottomView{

    _bottomBGView = [[UIView alloc]init];
    _bottomBGView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_bottomBGView];
    [_bottomBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(63);
    }];
    
    UIButton * btn = [UIButton new];
    [btn setTitle:@"付款" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.layer.cornerRadius = 4.f;
    [btn setBackgroundColor:colorWithRGB(0xFD7240)];
    [btn jk_addActionHandler:^(NSInteger tag) {
        [self pay];
    }];
    
    [_bottomBGView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_bottomBGView).insets(UIEdgeInsetsMake(9, 16, 9, 16));
    }];
    
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 3;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        PayCenterCell_1 * cell = [tableView dequeueReusableCellWithIdentifier:@"PayCenterCell_1"];
        cell.priceLabel.text = [NSString stringWithFormat:@"¥%@",self.price];
        return cell;
    }else{
        if (indexPath.row == 0) {
            UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
                cell.textLabel.text = @"选择支付方式:";
                cell.textLabel.font = [UIFont systemFontOfSize:14];
                cell.textLabel.textColor = kColorWithHex(0x333333);
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.userInteractionEnabled = NO;
            }
            return cell;
        }else{
            PayCenterCell * cell = [tableView dequeueReusableCellWithIdentifier:@"PayCenterCell"];
            if (indexPath.row == 1) {
                cell.iconIV.image = [UIImage imageNamed:@"会议培训_zhifubao"];
                cell.titleLabel.text = @"支付宝";
            }
            if (indexPath.row == 2) {
                cell.iconIV.image = [UIImage imageNamed:@"会议培训_weixin"];
                cell.titleLabel.text = @"微信";
            }
            return cell;
        }
        
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 1) {
        if (indexPath.row > 0) {
           __weak PayCenterCell * cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.selectedIV.image = [UIImage imageNamed:@"会议培训_right"];
        }
        if (indexPath.row == 1) {
            self.paymentWay = PaymentWay_Alipay;
        }else if (indexPath.row == 2){
            self.paymentWay = PaymentWay_WeChat;
        }
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row > 0) {
            __weak PayCenterCell * cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.selectedIV.image = nil;
        }
    }
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    if ([view isKindOfClass: [UITableViewHeaderFooterView class]]) {
        UITableViewHeaderFooterView* castView = (UITableViewHeaderFooterView*) view;
        
        castView.backgroundView.backgroundColor = [UIColor clearColor];
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([cell respondsToSelector:@selector(tintColor)]) {
        if (tableView == self.tableView) {
            CGFloat cornerRadius = 3.f;
            cell.backgroundColor = UIColor.clearColor;
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            CGMutablePathRef pathRef = CGPathCreateMutable();
            CGRect bounds = CGRectInset(cell.bounds, 0, 0);
            BOOL addLine = NO;
            if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            } else if (indexPath.row == 0) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
                addLine = YES;
            } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
                
            } else {
                CGPathAddRect(pathRef, nil, bounds);
                addLine = YES;
            }
            layer.path = pathRef;
            CFRelease(pathRef);
            if (indexPath.section == 0) {
                layer.fillColor = [UIColor clearColor].CGColor;
            }else{
                layer.fillColor = [UIColor colorWithWhite:1.f alpha:1.f].CGColor;
            }
            
            
            if (addLine == YES) {
                CALayer *lineLayer = [[CALayer alloc] init];
                CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
                lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+14, bounds.size.height-lineHeight, bounds.size.width-28, lineHeight);
                lineLayer.backgroundColor = tableView.separatorColor.CGColor;
                [layer addSublayer:lineLayer];
            }
            UIView *testView = [[UIView alloc] initWithFrame:bounds];
            [testView.layer insertSublayer:layer atIndex:0];
            testView.backgroundColor = UIColor.clearColor;
            cell.backgroundView = testView;
        }
    }
}

#pragma mark - 支付
-(void)pay{
    if (self.paymentWay == PaymentWay_None) {
        UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请选择支付方式" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    if (self.paymentWay == PaymentWay_WeChat) {
        NSDictionary * param = @{
                                 @"member_id":USERINFO.memberId,
                                 @"order_type":self.order_type,
                                 @"order_sn":self.order_sn
                                 };
        [DataSourceTool payWithParam:param toViewController:self success:^(id json) {
            NSLog(@"%@",json);
            NSDictionary * signInfo = json[@"sign"];
            
            //调起微信支付
            PayReq* req             = [[PayReq alloc] init];
            req.partnerId           = [signInfo objectForKey:@"partnerid"];
            req.prepayId            = [signInfo objectForKey:@"prepayid"];
            req.nonceStr            = [signInfo objectForKey:@"noncestr"];
            req.timeStamp           = [[signInfo objectForKey:@"timestamp"]intValue];
            req.package             = [signInfo objectForKey:@"package"];
            req.sign                = [signInfo objectForKey:@"sign"];
            [WXApi sendReq:req];

        } failure:^(NSError *error) {
             NSLog(@"%@",error.userInfo);
        }];
        
        return ;
    }
    
    if (self.paymentWay == PaymentWay_Alipay) {
        
        NSString *appScheme = @"Only";
        NSDictionary * param = @{
                                 @"member_id":USERINFO.memberId,
                                 @"order_type":self.order_type,
                                 @"order_sn":self.order_sn
                                 };
        [DataSourceTool aliPayWithParam:param toViewController:self success:^(id json) {
            NSLog(@"%@",json);
            if ([json[@"status"]integerValue]==0) {
                NSLog(@"支付信息%@",json[@"rs"]);
                    [[AlipaySDK defaultService] payOrder:json[@"rs"] fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                        NSLog(@"reslut = %@",resultDic);
                        if ([resultDic[@"resultStatus"]integerValue]==9000) {
                            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"支付成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                            [alertView show];
                        }else{
                            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"支付失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                            [alertView show];
                        }
                        
                    }];
                }

        } failure:^(NSError *error) {
            NSLog(@"%@",error.userInfo);
        }];
    }
}

//-(void)onResp:(BaseResp*)resp{
//    if ([resp isKindOfClass:[PayResp class]]){
//        PayResp*response=(PayResp*)resp;
//        switch(response.errCode){
//            case WXSuccess:
//                //服务器端查询支付通知或查询API返回的结果再提示成功
//                NSLog(@"支付成功");
//                break;
//            default:
//                NSLog(@"支付失败，retcode=%d",resp.errCode);
//                break;
//        }
//    }
//}

#pragma mark - 倒计时相关方法
-(void)updateTimeInVisibleCells{
    kWeakSelf(self);
    PayCenterCell_1 * cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    cell.countDownLabel.text = [weakself getNowTimeWithString:self.endTime];
}

-(NSString *)getNowTimeWithString:(NSString *)aTimeString{
    
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
        return @"";
    }
    if (days) {
        return [NSString stringWithFormat:@"%@天 %@小时 %@分 %@秒", dayStr,hoursStr, minutesStr,secondsStr];
    }
    return [NSString stringWithFormat:@"%@小时 %@分 %@秒",hoursStr , minutesStr,secondsStr];
}

@end
