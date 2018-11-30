//
//  MemberMineViewController.m
//  ONLY
//
//  Created by 上海点硕 on 2016/12/20.
//  Copyright © 2016年 cbl－　点硕. All rights reserved.
//

#import "MemberMineViewController.h"
#import "MemberMineOrderManageController.h"
#import "MemberMineOneCell.h"
#import "MemberMineTwoCell.h"
#import "MemberLoginController.h"
#import "MineChangePSDController.h"
#import "UIViewController+Cache.h"
static NSInteger const contentOffset = 300;

@interface MemberMineViewController ()<UITableViewDelegate,UITableViewDataSource,MineOneCellclickDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) UITableView* tableView; /*表视图*/
@property (nonatomic,strong) NSMutableArray* dataSource; /*数据模型*/

@end

@implementation MemberMineViewController
{
    UILabel* position_label;
    UILabel* service_time_label;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    [self createNavi];
    [self.view addSubview:self.tableView];
    [self  loadData];
}

-(UITableView*) tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Nav, SCREEN_WIDTH, SCREEN_HEIGHT - Nav) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.contentInset = UIEdgeInsetsMake(-contentOffset, 0, 0, 0);
        _tableView.backgroundColor = ClearColor;
        
        [_tableView registerNib:[UINib nibWithNibName:@"MemberMineOneCell" bundle:nil] forCellReuseIdentifier:@"MemberMineOneCell"];
        [_tableView registerNib:[UINib nibWithNibName:@"MemberMineTwoCell" bundle:nil] forCellReuseIdentifier:@"MemberMineTwoCell"];
    }
    return _tableView;
}

-(void) createNavi
{
    /*类似于波浪线的图片*/
    UIImageView* ripple_image = [[UIImageView alloc] init];
    [self.view addSubview:ripple_image];
    ripple_image.sd_layout
    .topSpaceToView(self.view,30)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(210);
    ripple_image.image = [UIImage imageNamed:@"member_mine_bg"];
    
    self.view.backgroundColor = TableviewGroupColor;
    UIView* navi_view = [[UIView alloc] init];
    [self.view addSubview:navi_view];
    navi_view.backgroundColor = BlueColor;
    navi_view.sd_layout
    .topSpaceToView(self.view,0)
    .leftSpaceToView(self.view,0)
    .rightSpaceToView(self.view,0)
    .heightIs(Nav);
    
    UILabel* navi_label = [MyControl titleLabelWithText:@"我的" textColor:WhiteColor bgColor:ClearColor Font:18.0f TextAlignmentType:textAlignmentTypeCenter];
    [navi_view addSubview:navi_label];
    navi_label.sd_layout
    .topSpaceToView(navi_view,20)
    .leftSpaceToView(navi_view,0)
    .rightSpaceToView(navi_view,0)
    .heightIs(44);
}

#pragma mark - UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
         return 1;
    }
    else
    {
         return 3;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 210 + contentOffset;
    }
    else
    {
        return 10;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0.001;
    }
    else
    {
        return 100;
    }
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 72;
    }
    else
    {
        return 44;
    }
}

-(UIView*) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return [self headerView];
    }
    else
    {
        UIView* header_view = [[UIView alloc] init];
        header_view.backgroundColor = TableviewGroupColor;
        return header_view;
    }
}

-(UIView*) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView* footer_view = [[UIView alloc] init];
    UIButton* out_login_button = [BlockButton buttonWithType:UIButtonTypeCustom];
    [footer_view addSubview:out_login_button];
    out_login_button.sd_layout
    .topSpaceToView(footer_view,24)
    .leftSpaceToView(footer_view,15)
    .rightSpaceToView(footer_view,15)
    .heightIs(45);
    [out_login_button setTitle:@"退出登录" forState:UIControlStateNormal];
    out_login_button.titleLabel.font = font(14.0f);
    out_login_button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    out_login_button.backgroundColor = colorWithRGB(0xFD7240);
    out_login_button.layer.cornerRadius = 5.0f;
    [out_login_button addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
    
    if (section == 0)
    {
        return nil;
    }
    else
    {
        return footer_view;
    }
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        MemberMineOneCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MemberMineOneCell"];
        cell.delegate = self;
        cell.pending_order_label.text = @"200";
        cell.history_order_label.text = @"1400";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        NSArray* icon_array = @[@"member_mine_reset",@"member_mine_clean",@"member_mine_news_set"];
        NSArray* title_array = @[@"修改密码",@"清除缓存",@"消息设置"];
        MemberMineTwoCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MemberMineTwoCell"];
        cell.icon_imageView.image = [UIImage imageNamed:icon_array[indexPath.row]];
        cell.icon_name_label.text = title_array[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
}


-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:YES];
    
    if (indexPath.section==1) {
        if (indexPath.row==0) {
            
            //修改密码
            MineChangePSDController *vc  = [MineChangePSDController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row==1)
        {
            //清除缓存
             [[[UIAlertView alloc] initWithTitle:@"提示" message:@"是否清除缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil]show];
        }
        else
        {
            //消息设置
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        }
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        
        [self clearAllCache];
    }
    else{
        
    }
    
    
}

-(void) clickWithTag:(NSInteger) tag
{
    MemberMineOrderManageController* vc = [[MemberMineOrderManageController alloc] init];
    switch (tag)
    {
        case 100:
        {
            vc.select_index = 1;
        }
            break;
        case 101:
        {
            vc.select_index = 2;
        }
            break;
            
        default:
            break;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

-(UIView*) headerView
{
    UIView* header_view = [[UIView alloc] init];
    //header_view.backgroundColor = BlueColor;
    
    /*头像*/
    UIImageView* portrait_image = [[UIImageView alloc] init];
    [header_view addSubview:portrait_image];
    portrait_image.sd_layout
    .topSpaceToView(header_view,8 + contentOffset)
    .leftSpaceToView(header_view,SCREEN_WIDTH / 2 - 45)
    .widthIs(90)
    .heightIs(90);
    cornerRadiusView(portrait_image, 45);
    [portrait_image sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,USERINFO.Mportrait]] placeholderImage:[UIImage imageNamed:@"member_mine_user"]];
    
    /*姓名*/
    UILabel* name_label = [MyControl titleLabelWithText:USERINFO.MmemberName textColor:WhiteColor bgColor:ClearColor Font:18.0f TextAlignmentType:textAlignmentTypeCenter];
    [header_view addSubview:name_label];
    name_label.sd_layout
    .topSpaceToView(portrait_image,16)
    .leftSpaceToView(header_view,SCREEN_WIDTH / 2 - 80)
    .widthIs(160)
    .heightIs(20);
    
    /*职位*/
    position_label = [MyControl titleLabelWithText:@"经理级" textColor:WhiteColor bgColor:ClearColor Font:12.0f TextAlignmentType:textAlignmentTypeRight];
    [header_view addSubview:position_label];
    position_label.sd_layout
    .topSpaceToView(name_label,10)
    .rightSpaceToView(header_view,220 * SCREEN_PRESENT)
    .widthIs(100)
    .heightIs(13);
    
    /*竖线*/
    UILabel* long_string_label = [[UILabel alloc] init];
    [header_view addSubview:long_string_label];
    long_string_label.sd_layout
    .topSpaceToView(name_label,13)
    .leftSpaceToView(position_label,11)
    .widthIs(1)
    .heightIs(6);
    long_string_label.backgroundColor = TableviewLineColor;
    
    /*服务次数*/
    service_time_label = [MyControl titleLabelWithText:[NSString stringWithFormat:@"服务次数: %d",500] textColor:WhiteColor bgColor:ClearColor Font:12.0f TextAlignmentType:textAlignmentTypeLeft];
    [header_view addSubview:service_time_label];
    service_time_label.sd_layout
    .topEqualToView(position_label)
    .leftSpaceToView(long_string_label,24)
    .widthIs(SCREEN_WIDTH / 2 - 50)
    .heightIs(13);
    
    UIView* order_manage_view = [[UIView alloc] init];
    [header_view addSubview:order_manage_view];
    order_manage_view.sd_layout
    .bottomSpaceToView(header_view,0)
    .leftSpaceToView(header_view,0)
    .rightSpaceToView(header_view,0)
    .heightIs(32);
    order_manage_view.backgroundColor = TableviewGroupColor;
    
    UILabel* order_manage_label = [MyControl titleLabelWithText:@"订单管理" textColor:lightGray_Color() bgColor:ClearColor Font:12.0f TextAlignmentType:textAlignmentTypeLeft];
    [order_manage_view addSubview:order_manage_label];
    order_manage_label.sd_layout
    .topSpaceToView(order_manage_view,0)
    .leftSpaceToView(order_manage_view,15)
    .rightSpaceToView(order_manage_view,15)
    .heightIs(order_manage_view.height);
    
    return header_view;
}



//推出登陆
- (void)loginOut
{
    [USERINFO cleanMemberData];
    MemberLoginController *vc = [MemberLoginController new];
    [self presentViewController:vc animated:YES completion:nil];

}

//加载
- (void)loadData
{
  [DataSourceTool serviceTimes:@"" ViewController:self success:^(id json) {
      
      if ([json[@"errcode"] integerValue]==0) {
          position_label.text = json[@"rsp"][@"service_count"];
          service_time_label.text = json[@"rsp"][@"service_level"];
          
      }
  } failure:^(NSError *error) {
      
  }];

}

@end
