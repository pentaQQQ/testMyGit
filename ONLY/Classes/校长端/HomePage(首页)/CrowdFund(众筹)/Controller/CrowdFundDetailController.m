//
//  CrowdFundDetailController.m
//  ONLY
//
//  Created by Dylan on 14/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "CrowdFundDetailController.h"
#import "MineSureOrderController.h"
#import "CrowdFundCommentController.h"
#import "CartViewController.h"

#import "CrowdFundDetailHeadView.h"
#import "CrowdFundDetailCell_1.h"
#import "CrowdFundDetailCell_2.h"
#import "CrowdFundDetailCell_3.h"
#import "CrowdFundDetailFooterView.h"
#import "CrowdFundBottomView.h"
#import "ChooseCountView.h"

#import "CountDown.h"
#import "UIViewController+HUD.h"
#import "BaseTabBarController.h"
#define tableHeaderH 212


@interface CrowdFundDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) CrowdFundBottomView * bottomView;
@property (nonatomic, strong) CountDown * countDown;
@property (nonatomic, strong) UIButton * bottomBtn;
@property (nonatomic, strong) CrowdFundDetailFooterView * footerView;

@end

@implementation CrowdFundDetailController{
    UIView * _bottomBGView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    [self commonInit];
    [self setupUI];
    [self setupNavi];
    [self getData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES];
    
}

-(void)commonInit{
    
    self.countDown = [[CountDown alloc] init];
    __weak __typeof(self) weakSelf= self;
    //   //每分钟回调一次
    [self.countDown countDownWithPER_SECBlock:^{
        [weakSelf updateTimeInVisibleCells];
    }];
    
}

-(void)setupNavi{
    UIButton * backBtn = [[UIButton alloc]init];
    [backBtn setImage:[UIImage imageNamed:@"产品众筹_back"] forState:UIControlStateNormal];
    [backBtn jk_addActionHandler:^(NSInteger tag) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.view insertSubview:backBtn aboveSubview:self.tableHeaderView];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.view).insets(UIEdgeInsetsMake(33, 15, 0, 0));
        make.height.width.mas_equalTo(30);
    }];
}
-(void)setupUI{
    [self setupBottomView];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    
    self.tableHeaderView = [self tableViewHeadView];
    self.tableView.tableFooterView = [self tableViewFooterView];
    self.tableHeaderView.frame = CGRectMake(0, -tableHeaderH, screenWidth(), tableHeaderH);
    [self.tableView addSubview:self.tableHeaderView];
    [self.tableView setContentInset:UIEdgeInsetsMake(tableHeaderH, 0, 0, 0)];
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 63, 0));
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CrowdFundDetailCell_1" bundle:nil] forCellReuseIdentifier:@"CrowdFundDetailCell_1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CrowdFundDetailCell_2" bundle:nil] forCellReuseIdentifier:@"CrowdFundDetailCell_2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CrowdFundDetailCell_3" bundle:nil] forCellReuseIdentifier:@"CrowdFundDetailCell_3"];
    
    
//    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    self.webView.delegate = self;
//    self.webView.scrollView.scrollEnabled = NO;
//    self.webView.scalesPageToFit = YES;
    
    
}

-(void)setupBottomView{
    kWeakSelf(self);
    if (self.status == CrowdFundStatus_Progressing) {
        self.bottomView = [[[NSBundle mainBundle]loadNibNamed:@"CrowdFundBottomView" owner:nil options:nil]lastObject];
        self.bottomView.item = self.item;
        [self.view addSubview:self.bottomView];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.view);
            make.height.mas_equalTo(50);
        }];
        
        self.bottomView.btnAction_Block = ^(NSInteger index){
            if (index == 1) {//关注
                [weakself collectFund];
            }else if (index == 2){//购物车
        
                CartViewController * vc = [CartViewController new];
                vc.type = 1;
                [weakself.navigationController pushViewController:vc animated:YES];
                
            }else if (index == 3 ){//加入购物车
                ChooseCountView * view = [[[NSBundle mainBundle]loadNibNamed:@"ChooseCountView" owner:nil options:nil]lastObject];
                view.item = weakself.item;
                [view setBtnAction_block:^(NSInteger num) {
                    [weakself addToCartWithNum:num];
                }];
                [view show];
            }else if (index == 4){//立即购买
                ChooseCountView * view = [[[NSBundle mainBundle]loadNibNamed:@"ChooseCountView" owner:nil options:nil]lastObject];
                view.item = weakself.item;
                [view setBtnAction_block:^(NSInteger num) {
                    MineSureOrderController * vc = [MineSureOrderController new];
                    vc.cart_ids = weakself.item.good_id;
                    vc.goodPrice = [NSString stringWithFormat:@"%.2f",[weakself.item.unit_price floatValue]*num];
                    vc.whoCome = YES;
                    vc.num = num;
                    [weakself.navigationController pushViewController:vc animated:YES];
                }];
                [view show];
            }
        };
    }else{
        _bottomBGView = [[UIView alloc]init];
        _bottomBGView.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:_bottomBGView];
        [_bottomBGView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.view);
            make.height.mas_equalTo(63);
        }];
        
        self.bottomBtn = [UIButton new];
        self.bottomBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        self.bottomBtn.layer.cornerRadius = 4.f;
        [self.bottomBtn setBackgroundColor:colorWithRGB(0x00A9EB)];
        
        if (self.status == CrowdFundStatus_Requset) {
            [self.bottomBtn jk_addActionHandler:^(NSInteger tag) {
                NSLog(@"我要点赞");
                [self thumbFund];
            }];
            [self.bottomBtn setTitle:@"我要点赞" forState:UIControlStateNormal];
        }else{
            [self.bottomBtn jk_addActionHandler:^(NSInteger tag) {
                NSLog(@"查看评价");
                CrowdFundCommentController * vc = [CrowdFundCommentController new];
                vc.item = self.item;
                [weakself.navigationController pushViewController:vc animated:YES];
            }];
            [self.bottomBtn setTitle:[NSString stringWithFormat:@"查看评价(%@)",weakself.item.commentCount] forState:UIControlStateNormal];
            [self.bottomBtn setImage:[UIImage imageNamed:@"look"] forState:UIControlStateNormal];
        }
        
        [_bottomBGView addSubview:self.bottomBtn];
        [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_bottomBGView).insets(UIEdgeInsetsMake(9, 16, 9, 16));
        }];
    }
}

-(UIView *)tableViewHeadView{
    CrowdFundDetailHeadView * headView = [[[NSBundle mainBundle]loadNibNamed:@"CrowdFundDetailHeadView" owner:nil options:nil]lastObject];
    headView.frame = CGRectMake(0, -tableHeaderH, screenWidth(), tableHeaderH);
    [headView.photoIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,self.item.picture]]];
    if (self.status == CrowdFundStatus_Finish) {
        headView.bottomView.hidden = YES;
    }else if (self.status == CrowdFundStatus_Requset){
        headView.bottomTitleLabel.text = @"点赞数未达到预定目标，将无法开始众筹";
    }else if (self.status == CrowdFundStatus_Progressing){
        headView.bottomTitleLabel.text = @"众筹数未达到预期目标，该众筹将被取消";
    }
    return headView;
}

-(UIView*)tableViewFooterView{
    kWeakSelf(self);
    self.footerView = [[[NSBundle mainBundle]loadNibNamed:@"CrowdFundDetailFooterView" owner:nil options:nil]lastObject];
    self.footerView.frame = CGRectMake(0, 0, screenWidth(), 300);
    self.footerView.reload_block = ^(CrowdFundDetailFooterView * footerView){
//        [weakself.tableView reloadData];
        weakself.tableView.tableFooterView = footerView;
    };
    return self.footerView;
}

-(void)refreshViewData{
    [self.tableView reloadData];
    self.bottomView.item = self.item;
    self.footerView.item = self.item;
    if (self.status == CrowdFundStatus_Requset) {
        
        if (self.item.is_clicked>0) {
            [self.bottomBtn setTitle:@"已点赞" forState:UIControlStateNormal];
            [self.bottomBtn setBackgroundColor:[UIColor lightGrayColor]];
            self.bottomBtn.userInteractionEnabled = NO;
        }else{
            [self.bottomBtn setTitle:@"我要点赞" forState:UIControlStateNormal];
        }
    }else{
        [self.bottomBtn setTitle:[NSString stringWithFormat:@"查看评价(%@)",self.item.commentCount] forState:UIControlStateNormal];
    }
    
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        CrowdFundDetailCell_1 * cell = [tableView dequeueReusableCellWithIdentifier:@"CrowdFundDetailCell_1"];
        cell.status = self.status;
        cell.item = self.item;
        return cell;
    }else{
        if (self.status == CrowdFundStatus_Requset) {
            CrowdFundDetailCell_2 * cell = [tableView dequeueReusableCellWithIdentifier:@"CrowdFundDetailCell_2"];
            cell.status = self.status;
            cell.item = self.item;
            
            return cell;
        }else{
            CrowdFundDetailCell_3 * cell = [tableView dequeueReusableCellWithIdentifier:@"CrowdFundDetailCell_3"];
            cell.item = self.item;

            return cell;
        }
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
//    NSLog(@"%f",offsetY);
    self.tableHeaderView.frame = CGRectMake(0, offsetY, scrollView.width, -offsetY);
}

#pragma mark - 网络请求

-(void)getData{
    NSDictionary * param = @{
                             @"good_id": self.item.good_id,
                             @"member_id": USERINFO.memberId
                             };
    [DataSourceTool crowdFundDetailWithParam:param toViewController:self success:^(id json) {
        NSLog(@"%@",json);
        [json[@"data"] createPropertyCode];
        if ([json[@"errcode"]integerValue]==0) {
            [self.item setValuesForKeysWithDictionary:json[@"data"]];
            [self refreshViewData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}

//点赞
-(void)thumbFund{
    NSDictionary * param = @{
                             @"member_id": USERINFO.memberId,
                             @"good_id": self.item.good_id
                             };
    [DataSourceTool thumbFundWithParam:param toViewController:self success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"errcode"]integerValue]==0) {
            [self.bottomBtn setTitle:@"已点赞" forState:UIControlStateNormal];
            [self.bottomBtn setBackgroundColor:[UIColor lightGrayColor]];
            self.bottomBtn.userInteractionEnabled = NO;
        }
            
    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
    
}

//关注
-(void)collectFund{
    NSDictionary * param = @{
                             @"member_id": USERINFO.memberId,
                             @"good_id": self.item.good_id
                             };
    [DataSourceTool collectFundWithParam:param toViewController:self success:^(id json) {
        NSLog(@"%@",json);
      
        if ([json[@"errcode"]integerValue]==0) {
            
            self.item.focusCount = [NSString stringWithFormat:@"%ld",[self.item.focusCount integerValue]+1];
            [self refreshViewData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}

//加入购物车
-(void)addToCartWithNum:(NSInteger)num{
    NSDictionary * param = @{
                             @"member_id": USERINFO.memberId,
                             @"goods_id": self.item.good_id,
                             @"num":@(num)
                             };
    [DataSourceTool addToCartWithParam:param toViewController:self success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"errcode"]integerValue]==0) {
            
            self.item.cartCount = json[@"data"];
            [self refreshViewData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
  
}

#pragma mark - 倒计时相关方法
-(void)updateTimeInVisibleCells{
    kWeakSelf(self);
    NSArray  *cells = weakself.tableView.visibleCells; //取出屏幕可见ceLl

    for (UITableViewCell *cell in cells) {
        if ([cell isKindOfClass:[CrowdFundDetailCell_2 class]]) {
            CrowdFundDetailCell_2 * cell2 = (CrowdFundDetailCell_2*)cell;
            cell2.timeLabel.text = [weakself getNowTimeWithString:self.item.endTime];
            if ([cell2.timeLabel.text isEqualToString:@"该众筹已结束"]) {
                cell2.timeLabel.textColor = [UIColor redColor];
            }else{
                cell2.timeLabel.textColor = [UIColor orangeColor];
            }
        }
        if ([cell isKindOfClass:[CrowdFundDetailCell_3 class]]) {
            CrowdFundDetailCell_3 * cell2 = (CrowdFundDetailCell_3*)cell;
            cell2.timeLabel.text = [weakself getNowTimeWithString:self.item.endTime];
            if ([cell2.timeLabel.text isEqualToString:@"该众筹已结束"]) {
                cell2.timeLabel.textColor = [UIColor redColor];
            }else{
                cell2.timeLabel.textColor = [UIColor lightGrayColor];
            }
        }
    }
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
        return @"00天00时00分";
    }
    if (days) {
        return [NSString stringWithFormat:@"%@天 %@小时 %@分", dayStr,hoursStr, minutesStr];
    }
    return [NSString stringWithFormat:@"%@小时 %@分",hoursStr , minutesStr];
}

-(void)dealloc{
    NSLog(@"%s dealloc",object_getClassName(self));
}

@end
