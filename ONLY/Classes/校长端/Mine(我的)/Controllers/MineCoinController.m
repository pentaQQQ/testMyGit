//
//  MineCoinController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/1/14.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineCoinController.h"
#import "MineCoinCell.h"
#import "MineCoinRuleController.h"
#import "CoinModel.h"
@interface MineCoinController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MineCoinController
{
    UITableView *tableview ;
    NSArray *dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = WhiteColor;
    [self setNavView];
    [self makeUI];
    [self loadData];
    
}

//创建导航栏（自定义）
- (void)setNavView
{
    UIView *view  = [UIView new];
    view.backgroundColor = colorWithRGB(0x00A9EB);
    [self.view addSubview:view];
    view.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(64);
    
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
    titleLabel.text = @"金币管理";
    
    UILabel *ruleLabel = [UILabel new];
    ruleLabel.userInteractionEnabled = YES;
    [view addSubview:ruleLabel];
    ruleLabel.textColor= WhiteColor;
    ruleLabel.font = font(14);
    ruleLabel.textAlignment = NSTextAlignmentRight;
    ruleLabel.sd_layout.widthIs(56).rightSpaceToView(view,16).heightIs(13).topSpaceToView(view,40);
    ruleLabel.text = @"规则说明";
    
    // 单击的 Recognizer
    UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ruleClick)];
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [ruleLabel addGestureRecognizer:singleRecognizer];
    
}

- (void)ruleClick
{
    MineCoinRuleController *vc  = [MineCoinRuleController new];
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)makeUI
{
    tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,64).bottomSpaceToView(self.view,0);
    cornerRadiusView(tableview, 3);
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.showsVerticalScrollIndicator = NO;
    
    UIView *headView = [UIView new];
    headView.backgroundColor = WhiteColor;
    headView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 67);
    tableview.tableHeaderView = headView;
    
    UILabel *dangLabel = [UILabel new];
    [headView addSubview:dangLabel];
    dangLabel.textColor= colorWithRGB(0x333333);
    dangLabel.font = font(14);
    dangLabel.textAlignment = NSTextAlignmentLeft;
    dangLabel.sd_layout.leftSpaceToView(headView,16).widthIs(SCREEN_WIDTH/2).heightIs(13).topSpaceToView(headView,25);
    dangLabel.text = @"您当前金币：";
    
    
    UILabel *coinLabel = [UILabel new];
    [headView addSubview:coinLabel];
    coinLabel.textColor= colorWithRGB(0xEA5520);
    coinLabel.font = font(24);
    coinLabel.textAlignment = NSTextAlignmentRight;
    coinLabel.sd_layout.rightSpaceToView(headView,16).widthIs(SCREEN_WIDTH/2).heightIs(18).topSpaceToView(headView,25);
    coinLabel.text = @"230";
    
    UIView *footView = [UIView new];
    footView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 67);
    tableview.tableFooterView = footView;
    
    UILabel *footLabel = [UILabel new];
    [footView addSubview:footLabel];
    footLabel.textColor= colorWithRGB(0x999999);
    footLabel.font = font(14);
    footLabel.textAlignment = NSTextAlignmentCenter;
    footLabel.sd_layout.leftSpaceToView(footView,16).rightSpaceToView(footView,16).heightIs(13).topSpaceToView(footView,25);
    footLabel.text = @"没有更多啦~🙀🙀🙀";
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 61;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 46;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00000001;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"MineCoinCell";
    MineCoinCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell==nil) {
        
        cell = [[MineCoinCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    CoinModel *model = dataArray[indexPath.row];
    cell.titleLabel.text = model.name;
    cell.timeLabel.text = [self becomeTime:model.add_time];
    cell.numLabel.text = [NSString stringWithFormat:@"+%@",model.point];
    
    return cell;

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [UIView new];
    bgView.backgroundColor = colorWithRGB(0xEFEFF4);
    
    UIView *view  = [UIView new];
    [bgView addSubview:view];
    view.backgroundColor = WhiteColor;
    view.frame = CGRectMake(0, 10, SCREEN_WIDTH, 36);
    
    UILabel *titleLabel = [UILabel new];
    [view addSubview:titleLabel];
    titleLabel.textColor= colorWithRGB(0x333333);
    titleLabel.font = font(14);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.sd_layout.leftSpaceToView(view,16).rightSpaceToView(view,16).heightIs(13).topSpaceToView(view,25);
    titleLabel.text = @"最近30天金币明细:";
    
    
    return bgView;
}

- (void)loadData
{

  [DataSourceTool coinListtoViewController:self success:^(id json) {
      
      if ([json[@"errcode"] integerValue]==0) {
          NSMutableArray *temp = [NSMutableArray array];
          for (NSDictionary *dic  in json[@"rsp"]) {
              
              CoinModel *model = [CoinModel new];
              [model setValuesForKeysWithDictionary:dic];
              [temp addObject:model];
          }
          dataArray = temp;
          [tableview reloadData];
      }
      
  } failure:^(NSError *error) {
      
  }];

}

- (NSString *)becomeTime:(NSString *)time
{
    NSDateFormatter* formatter = [NSDateFormatter new];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *dt = [NSDate dateWithTimeIntervalSince1970:[time integerValue]];
    
    NSString *nowtimeStr = [formatter stringFromDate:dt];
    
    return nowtimeStr;
    
}

@end
