//
//  ConferenceDetailController.m
//  ONLY
//
//  Created by Dylan on 16/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "ConferenceDetailController.h"
#import "ConferenceDetailConfirmOrderController.h"
#import "ConferenceTeacherDetailController.h"
#import "CrowdFundDetailHeadView.h"
#import "ConferenceDetailCell_1.h"
#import "ConferenceDetailBottomView.h"
#import "ConferenceDetailFooterView.h"

#import "TeacherItem.h"

#import "UIViewController+HUD.h"
#define tableHeaderH 212
@interface ConferenceDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) ConferenceDetailFooterView * footerView;
@property (nonatomic, strong) ConferenceDetailBottomView *bottomView;
@property (nonatomic, strong) NSMutableArray * teacherArray;
@end

@implementation ConferenceDetailController{
    UIView * _bottomBGView;
}

-(NSMutableArray *)teacherArray{
    if (!_teacherArray) {
        _teacherArray = [NSMutableArray new];
    }
    return _teacherArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    [self setupUI];
    [self setupNavi];
    [self getData];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    
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
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 63, 0));
//        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.tableFooterView = [UIView new];
    
    self.tableHeaderView = [self tableViewHeadView];
    self.tableView.tableFooterView = [self tableViewFooterView];
    self.tableHeaderView.frame = CGRectMake(0, -tableHeaderH, screenWidth(), tableHeaderH);
    [self.tableView addSubview:self.tableHeaderView];
    [self.tableView setContentInset:UIEdgeInsetsMake(tableHeaderH, 0, 0, 0)];

    [self.tableView registerNib:[UINib nibWithNibName:@"ConferenceDetailCell_1" bundle:nil] forCellReuseIdentifier:@"ConferenceDetailCell_1"];
    
    
}
-(void)setupBottomView{
   
    self.bottomView = [[[NSBundle mainBundle]loadNibNamed:@"ConferenceDetailBottomView" owner:nil options:nil]lastObject];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(63);
    }];
    kWeakSelf(self);
    self.bottomView.btnAction_block = ^(NSInteger index){
        if (index == 1) {
            ConferenceDetailConfirmOrderController * vc = [ConferenceDetailConfirmOrderController new];
            vc.item = weakself.item;
            [weakself.navigationController pushViewController:vc animated:YES];
        }else{
            [weakself follow];
        }
    };
    
}
-(UIView *)tableViewHeadView{
    CrowdFundDetailHeadView * headView = [[[NSBundle mainBundle]loadNibNamed:@"CrowdFundDetailHeadView" owner:nil options:nil]lastObject];
    headView.bottomTitleLabel.text = [NSString stringWithFormat:@"人数未达到%@人，该培训将被取消",self.item.count];
    return headView;
}

-(UIView *)tableViewFooterView{
    kWeakSelf(self);
    self.footerView = [[[NSBundle mainBundle]loadNibNamed:@"ConferenceDetailFooterView" owner:nil options:nil]lastObject];
    self.footerView.dataArray = self.teacherArray;
    self.footerView.item = self.item;
    [self.footerView setReload_block:^(ConferenceDetailFooterView * footerView) {
        weakself.tableView.tableFooterView = footerView;
    }];
    [self.footerView setClicked_block:^(TeacherItem * item) {
        ConferenceTeacherDetailController * vc = [ConferenceTeacherDetailController new];
        vc.item = item;
        [weakself.navigationController pushViewController:vc animated:YES];
    }];
    return self.footerView;
}

-(void)reloadData{
    self.footerView.dataArray = self.teacherArray;
    self.footerView.item = self.item;
    self.bottomView.item = self.item;
    [self.tableView reloadData];
}

-(void)getData{
    NSDictionary * param = @{
                             @"member_id": USERINFO.memberId,
                             @"course_id": self.item.course_id
                             };
    
    [DataSourceTool conferenceDetailWithParam:param toViewController:self success:^(id json) {
        NSLog(@"%@",json);
        if([json[@"errcode"]integerValue]==0){
            NSDictionary * dic = json[@"info"];
            [self.item setValuesForKeysWithDictionary:dic];
            self.item.is_focus = json[@"is_focus"];
            self.item.focus_count = json[@"focus_count"];
            for (NSDictionary * dic in json[@"teacher"]) {
                TeacherItem * item = [TeacherItem new];
                [item setValuesForKeysWithDictionary:dic];
                [self.teacherArray addObject:item];
            }
            [self reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}



#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    }else{
        return 10;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ConferenceDetailCell_1 * cell = [tableView dequeueReusableCellWithIdentifier:@"ConferenceDetailCell_1"];
    cell.item = self.item;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    CGPoint point = scrollView.contentOffset;
//    NSLog(@"%f",point.y);
    self.tableHeaderView.frame = CGRectMake(0, point.y, scrollView.width, -point.y);
  
}

#pragma mark - 网络请求
-(void)follow{
    NSString * focus;
    if ([self.item.is_focus integerValue]==1) {
        focus = @"0";
    }else{
        focus = @"1";
    }
    NSDictionary * param = @{
                             @"member_id": USERINFO.memberId,
                             @"course_id": self.item.course_id,
                             @"focus": focus
                             };
    [DataSourceTool conferenceFollowWithParam:param toViewController:self success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"errcode"]integerValue]==0) {
            self.item.is_focus = focus;
            if ([focus isEqualToString:@"1"]) {
                NSInteger count =[self.item.focus_count integerValue];
                self.item.focus_count = [NSNumber numberWithInteger:(count+1)];
            }else{
                NSInteger count =[self.item.focus_count integerValue];
                self.item.focus_count = [NSNumber numberWithInteger:(count-1)];
            }
            [self reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}
@end
