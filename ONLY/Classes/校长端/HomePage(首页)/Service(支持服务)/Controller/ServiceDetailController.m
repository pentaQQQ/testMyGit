//
//  ServiceDetailController.m
//  ONLY
//
//  Created by Dylan on 08/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "ServiceDetailController.h"
#import "ServiceWaiterListController.h"
#import "CrowdFundDetailHeadView.h"
#import "ServiceDetailCell_1.h"
#import "ServiceDetailCell_2.h"

#import "MHActionSheet.h"
#define tableHeaderH 212
@interface ServiceDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) NSString * selectedActivityDate;
@end

@implementation ServiceDetailController{
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
    [self.navigationController setNavigationBarHidden:YES];
    
}
-(void)commonInit{
    self.selectedActivityDate = @"";
}
-(void)setupNavi{

    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
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
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 63, 0));
        //        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableFooterView = [UIView new];
    
    self.tableHeaderView = [self tableViewHeadView];
    self.tableHeaderView.frame = CGRectMake(0, -tableHeaderH, screenWidth(), tableHeaderH);
    [self.tableView addSubview:self.tableHeaderView];
    [self.tableView setContentInset:UIEdgeInsetsMake(tableHeaderH, 0, 0, 0)];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ServiceDetailCell_1" bundle:nil] forCellReuseIdentifier:@"ServiceDetailCell_1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ServiceDetailCell_2" bundle:nil] forCellReuseIdentifier:@"ServiceDetailCell_2"];
    
    
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
    [btn setTitle:@"确认" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.layer.cornerRadius = 4.f;
    [btn setBackgroundColor:colorWithRGB(0x00A9EB)];
    [btn jk_addActionHandler:^(NSInteger tag) {
        ServiceWaiterListController * vc = [ServiceWaiterListController new];
        vc.serviceItem = self.item;
        vc.selectedActivityDate = self.selectedActivityDate;
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    [_bottomBGView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_bottomBGView).insets(UIEdgeInsetsMake(9, 16, 9, 16));
    }];
    
}

-(UIView *)tableViewHeadView{
    CrowdFundDetailHeadView * headView = [[[NSBundle mainBundle]loadNibNamed:@"CrowdFundDetailHeadView" owner:nil options:nil]lastObject];
    [headView.photoIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,self.item.service_img]]];
    headView.bottomView.hidden = YES;
    return headView;
}

-(void)getData{
    NSDictionary * param = @{
                             @"service_id": self.item.service_id,
                             @"member_id": USERINFO.memberId
                             };
    
    [DataSourceTool serviceDetailWithParam:param toViewController:self success:^(id json) {
        NSLog(@"%@",json);
        if ([json [@"errcode"]integerValue]==0) {
            [self.item setValuesForKeysWithDictionary:json[@"rsp"]];
            self.selectedActivityDate = self.item.activity_time.firstObject;
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}


#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        ServiceDetailCell_1 * cell = [tableView dequeueReusableCellWithIdentifier:@"ServiceDetailCell_1"];
        cell.item = self.item;
        return cell;
    }else{
        ServiceDetailCell_2 * cell = [tableView dequeueReusableCellWithIdentifier:@"ServiceDetailCell_2"];
        cell.item = self.item;
        cell.timeLabel.text = self.selectedActivityDate;
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    if ([view isKindOfClass: [UITableViewHeaderFooterView class]]) {
        UITableViewHeaderFooterView* castView = (UITableViewHeaderFooterView*) view;
        
        castView.backgroundView.backgroundColor = [UIColor clearColor];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        MHActionSheet * view = [[MHActionSheet alloc]initSheetWithTitle:@"" style:MHSheetStyleWeiChat itemTitles:self.item.activity_time];
        view.itemTextFont = [UIFont systemFontOfSize:14];
        kWeakSelf(self);
        [view didFinishSelectIndex:^(NSInteger index, NSString *title) {
            weakself.selectedActivityDate = title;
            [weakself.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
        }];
        [view show];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint point = scrollView.contentOffset;
    NSLog(@"%f",point.y);
    self.tableHeaderView.frame = CGRectMake(0, point.y, scrollView.width, -point.y);
    
}

@end
