//
//  MineCoinRuleController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/1/14.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineCoinRuleController.h"

@interface MineCoinRuleController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MineCoinRuleController
{
    UITableView *tableview;
    NSArray *secArr;
    NSArray *dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    self.fd_prefersNavigationBarHidden = YES;
    secArr = @[@"金币获取途径",@"其它"];
    [self setNavView];
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
    titleLabel.text = @"规则说明";
    
    tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,64).bottomSpaceToView(self.view,0);
    cornerRadiusView(tableview, 3);
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.showsVerticalScrollIndicator = NO;

    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0){
    return dataArray.count;
    }
    else
    {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 52;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"MineCoinCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell==nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
       UIView *view = [UIView new];
       [cell.contentView addSubview:view];
       view.backgroundColor = colorWithRGB(0x333333);
        view.sd_layout.leftSpaceToView(cell.contentView, 27).topSpaceToView(cell.contentView, 15).heightIs(1.5).widthIs(1.5);
        
        UILabel *label = [UILabel new];
        label.tag = 100;
        label.textColor = colorWithRGB(0x333333);
        [cell.contentView addSubview:label];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = font(14);
        label.sd_layout.leftSpaceToView(view, 5).topSpaceToView(cell.contentView, 10).heightIs(14).rightSpaceToView(cell.contentView, 15);
        
    
    }
    
    UILabel *label = [cell.contentView viewWithTag:100];
    label.text = dataArray[indexPath.row];
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView = [UIView new];
    bgView.backgroundColor = WhiteColor;
    
    UIImageView *imageview = [UIImageView new];
    [bgView addSubview:imageview];
    imageview.image = [UIImage imageNamed:@"member_mine_clean"];
    imageview.sd_layout.leftSpaceToView(bgView,16).topSpaceToView(bgView,28).widthIs(13).heightIs(11);
    
    UILabel *titleLabel = [UILabel new];
    [bgView addSubview:titleLabel];
    titleLabel.textColor= colorWithRGB(0x333333);
    titleLabel.font = font(16);
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.sd_layout.leftSpaceToView(imageview,12).rightSpaceToView(bgView,16).heightIs(16).topSpaceToView(bgView,25);
    titleLabel.text = secArr[section];
    
    return bgView;
}



//加载网络数据
- (void)loadData
{
   [DataSourceTool coinRule:@"" ViewController:self success:^(id json) {
       
       if ([json[@"errcode"] integerValue]==0) {
           NSMutableArray *temp = [NSMutableArray array];
           for (NSDictionary *dic  in json[@"rsp"]) {
               [temp addObject:dic[@"name"]];
               
           }
           dataArray = temp;
           [tableview reloadData];
           
       }
   } failure:^(NSError *error) {
       
       
   }];
}



@end
