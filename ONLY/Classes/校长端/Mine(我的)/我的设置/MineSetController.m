//
//  MineSetController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/2/8.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineSetController.h"
#import "MineComListCell.h"
#import "MineMemberCell.h"
#import "MineInformationController.h"
#import "MineAddressController.h"
#import "MineInterestController.h"
#import "MineChangeMobController.h"
#import "MineChangePSDController.h"
#import "LoginViewController.h"
#import "AboutMeController.h"
#import "UIViewController+Cache.h"
@interface MineSetController ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@end

@implementation MineSetController
{
    UITableView *tableview;
    NSArray *titleArr;
    NSArray *detailArr;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = colorWithRGB(0xEFEFF4);
    self.fd_prefersNavigationBarHidden = YES;
    titleArr = @[@[@"我的资料 ",@"地址管理",@"兴趣标签"],@[@"手机号码",@"修改密码",@"清除缓存",@"消息设置" ],@[@"鼓励一下 ",@"关于我们"],@[@""]];
    
    NSString *cahce = [NSString stringWithFormat:@"%.1fM", [self calculateCacheSize]];
    detailArr = @[@[@"",@"",@""],@[@"",@"",cahce,@"" ],@[@"",@"当前版本：V1.0.1"],@[@""]];
    
    [self setNavView];
    
}

//创建导航栏（自定义）
- (void)setNavView
{
    UIView *view  = [UIView new];
    view.backgroundColor = colorWithRGB(0x00A9EB);
    [self.view addSubview:view];
    view.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(64);
    
    UIImageView *imageview = [UIImageView new];
    imageview.image = [UIImage imageNamed:@"head"];
    [self.view addSubview:imageview];
    imageview.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(view,0).heightIs(112);
    
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
    titleLabel.text = @"我的资料";
    
    
    tableview = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableview.separatorStyle= UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,16).topSpaceToView(view,0).bottomSpaceToView(self.view,0);
    cornerRadiusView(tableview, 4);
    tableview.showsVerticalScrollIndicator = NO;
    
    [tableview registerNib:[UINib nibWithNibName:@"MineMemberCell" bundle:nil] forCellReuseIdentifier:@"MineMemberCell"];
    
    [self setHeadView];
}

- (void)setHeadView
{
    UIView *headView = [UIView new];
    headView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.01];
    cornerRadiusView(headView, 3);
    headView.frame = CGRectMake(0, 0, tableview.width, 61);
    tableview.tableHeaderView = headView;
    
    UIView *bgView = [UIView new];
    [headView addSubview:bgView];
    bgView.backgroundColor = WhiteColor;
    bgView.sd_layout.leftEqualToView(headView).rightEqualToView(headView).bottomSpaceToView(headView,0).heightIs(30);
    
    UIImageView *setImg = [UIImageView new];
    [headView addSubview:setImg];
    setImg.sd_layout.topEqualToView(headView).bottomEqualToView(headView).leftSpaceToView(headView,142*SCREEN_PRESENT).widthIs(61);
    setImg.image = [UIImage imageNamed:@"set-icon"];
    
    [self setFootView];
    
}

-(void)setFootView
{
    UIView *footView = [UIView new];
    footView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.01];

    footView.frame = CGRectMake(16, 0, tableview.width, 70);
    tableview.tableFooterView = footView;
    
    UIButton *btn = [UIButton new];
    [footView addSubview:btn];
    btn.sd_layout.leftEqualToView(footView).rightEqualToView(footView).heightIs(45).topSpaceToView
    (footView,14);
    btn.backgroundColor = colorWithRGB(0xF77142);
    btn.titleLabel.font = font(14);
    [btn setTitle:@"退出登录" forState:UIControlStateNormal];
    [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
    cornerRadiusView(btn, 4);
    [btn jk_addActionHandler:^(NSInteger tag) {
        
         [USERINFO cleanData];
        LoginViewController *vc = [LoginViewController new];
        [self presentViewController:vc animated:YES completion:nil];
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 3;
    }
    else if (section==1)
    {
        return 4;
    }
    else {
        return 2;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 47 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineMemberCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *line = [UIView new];
    [cell.contentView addSubview:line];
    line.backgroundColor = colorWithRGB(0x999999);
    line.alpha = 0.102;
    line.sd_layout.leftEqualToView(cell.contentView).rightEqualToView(cell.contentView).heightIs(1).bottomSpaceToView(cell.contentView,0);
    
    //cell set value
    cell.titleLab.text = titleArr[indexPath.section][indexPath.row];
    cell.detailLab.text = detailArr[indexPath.section][indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
            
            MineInformationController *vc = [MineInformationController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ( indexPath.row==1)
        {
            MineAddressController *vc = [MineAddressController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ( indexPath.row==2)
        {
            MineInterestController *vc = [MineInterestController new];
            vc.typeVc = 3;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            
        }
    }
    else if (indexPath.section==1)
    {
        if (indexPath.row==0) {
            
            MineChangeMobController *vc  = [MineChangeMobController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ( indexPath.row==1)
        {
            MineChangePSDController *vc = [MineChangePSDController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if ( indexPath.row==3)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
        else
        {
            
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否清除缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil]show];
           
        }
        
    }
    else{
    
        if (indexPath.row==1) {
            AboutMeController *vc = [AboutMeController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        [self clearAllCache];
        detailArr = @[@[@"",@"",@""],@[@"",@"",@"0M",@"" ],@[@"",@"当前版本：V1.0.1"],@[@""]];
        [tableview reloadData];
    }
    else{
    
    }


}


@end
