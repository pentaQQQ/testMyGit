//
//  CompetitionDetailController.m
//  ONLY
//
//  Created by Dylan on 14/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "CompetitionDetailController.h"
#import "CompetitionEnrollController.h"
#import "CompetitionVoteListController.h"
#import "CompetitionResultController.h"
#import "CompetitionDetailCell_1.h"
#import "CompetitionDetailCell_2.h"
#import "CrowdFundDetailHeadView.h"
#import "CompetitionDetailBottomView.h"

#define tableHeaderH 212

@interface CompetitionDetailController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView *tableHeaderView;
@property (nonatomic, strong) CompetitionDetailBottomView *bottomView;
@property (nonatomic, strong) UIButton * bottomBtn;

@end

@implementation CompetitionDetailController{
    UIView * _bottomBGView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
    [self setupUI];
    [self getData];
}

-(void)setupNavi{
    self.title = self.item.match_name;
    self.view.backgroundColor = AppBackColor;
}

-(void)setupUI{
    [self setupBottomView];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    self.tableHeaderView = [self tableViewHeadView];
    self.tableHeaderView.frame = CGRectMake(0, -tableHeaderH, screenWidth(), tableHeaderH);
    [self.tableView addSubview:self.tableHeaderView];
    [self.tableView setContentInset:UIEdgeInsetsMake(tableHeaderH, 0, 0, 0)];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 63, 0));
        //        make.bottom.equalTo(self.bottomView.mas_top);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CompetitionDetailCell_1" bundle:nil] forCellReuseIdentifier:@"CompetitionDetailCell_1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CompetitionDetailCell_2" bundle:nil] forCellReuseIdentifier:@"CompetitionDetailCell_2"];
}


-(UIView *)tableViewHeadView{
    CrowdFundDetailHeadView * headView = [[[NSBundle mainBundle]loadNibNamed:@"CrowdFundDetailHeadView" owner:nil options:nil]lastObject];
    headView.bottomView.hidden = YES;
    [headView.photoIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,self.item.match_img]]];
    return headView;
}

-(void)setupBottomView{
    kWeakSelf(self);
    if ([self.item.status isEqualToString:@"已结束"]) {
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
        
        
        [self.bottomBtn jk_addActionHandler:^(NSInteger tag) {
            CompetitionResultController * vc = [CompetitionResultController new];
            vc.item = weakself.item;
            [weakself.navigationController pushViewController:vc animated:YES];
        }];
        [self.bottomBtn setTitle:@"已结束，查看结果" forState:UIControlStateNormal];
        
        [_bottomBGView addSubview:self.bottomBtn];
        [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_bottomBGView).insets(UIEdgeInsetsMake(9, 16, 9, 16));
        }];
    }else{
        self.bottomView = [[[NSBundle mainBundle]loadNibNamed:@"CompetitionDetailBottomView" owner:nil options:nil]lastObject];
        [self.view addSubview:self.bottomView];
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.view);
            make.height.mas_equalTo(63);
        }];
        kWeakSelf(self);
        self.bottomView.btnAction_block = ^(NSInteger index){
            if (index == 1) {
                CompetitionVoteListController * vc = [CompetitionVoteListController new];
                vc.item = weakself.item;
                [weakself.navigationController pushViewController:vc animated:YES];
            }else{
                  CompetitionEnrollController * vc = [CompetitionEnrollController new];
                vc.item = weakself.item;
                [weakself.navigationController pushViewController:vc animated:YES];
                
            }
        };
    }
    
}

-(void)getData{
    NSDictionary * param = @{
                             @"match_id": self.item.match_id
                             };
    
    [DataSourceTool competitionDetailWithParam:param toViewController:self success:^(id json) {
        NSLog(@"%@",json);
        if([json[@"errcode"]integerValue]==0){
            NSDictionary * dic = json[@"rsp"];
            [self.item setValuesForKeysWithDictionary:dic];
            [self.tableView reloadData];
//            [json[@"rsp"] createPropertyCode];
            
//            [self reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}


#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        CompetitionDetailCell_1 * cell = [tableView dequeueReusableCellWithIdentifier:@"CompetitionDetailCell_1"];
        cell.item = self.item;
        return cell;
    }else{
        CompetitionDetailCell_2 * cell = [tableView dequeueReusableCellWithIdentifier:@"CompetitionDetailCell_2"];
        return cell;
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGPoint point = scrollView.contentOffset;
    NSLog(@"%f",point.y);
    self.tableHeaderView.frame = CGRectMake(0, point.y, scrollView.width, -point.y);
    
}

@end
