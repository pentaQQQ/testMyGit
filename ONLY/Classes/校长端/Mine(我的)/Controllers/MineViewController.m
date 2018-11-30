//
//  MineViewController.m
//  ONLY
//
//  Created by 上海点硕 on 2016/12/17.
//  Copyright © 2016年 cbl－　点硕. All rights reserved.
//

#import "MineViewController.h"
#import "UITableView+Sure_Placeholder.h"
#import "MIneCell.h"
#import "MineCoinController.h"
#import "MineManyOrderController.h"
#import "MineMeetingController.h"
#import "MineServerController.h"
#import "MineDownLoadController.h"
#import "MIneZCViweController.h"
#import "MinePXController.h"
#import "MineFWController.h"
#import "MIneGodIdeaController.h"
#import "MineComplainController.h"
#import "MineMemberController.h"
#import "MineSetController.h"
#import "MineDBPController.h"
@interface MineViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MineViewController
{
    NSMutableArray *array;
    TPKeyboardAvoidingTableView *tableview ;
    NSArray *imaArr;
    NSArray *titleArr;
    UIImageView *sexImg;
    UIImageView *headimage;
    UILabel *nameLabel;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = colorWithRGB(0xEFEFF4);
    self.fd_prefersNavigationBarHidden = YES;
    imaArr =  @[@[],@[@"mine_icon1",@"mine_icon2",@"mine_icon3",@"mine_icon4",@"mine_icon5"],@[@"mine_icon6", @"mine_icon7",@"mine_icon8"]];
    titleArr = @[@[],@[@"我的众筹",@"我的培训",@"我的服务",@"我的金点子",@"我的大比拼"],@[@"我的人员", @"我的下载",@"投诉建议"]];
    
    [self setNavView];
    
    [self makeUI];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
     [headimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,USERINFO.portrait]] placeholderImage:[UIImage imageNamed:@"member_mine_user"]];
    if ([USERINFO.sex isEqualToString:@"0"]) {
        sexImg.image = [UIImage imageNamed:@"member_mine_male"];
    }
    else
    {
        sexImg.image = [UIImage imageNamed:@"member_mine_female"];
    }
    nameLabel.text = USERINFO.memberName;

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
    [backBtn setImage:[UIImage imageNamed:@"set"] forState:UIControlStateNormal];
    backBtn.sd_layout.rightSpaceToView(view,8).topSpaceToView(view,25).heightIs(30).widthIs(30);
    [backBtn jk_addActionHandler:^(NSInteger tag) {
        MineSetController *vc = [MineSetController new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
    
    UILabel *titleLabel = [UILabel new];
    [view addSubview:titleLabel];
    titleLabel.textColor= WhiteColor;
    titleLabel.font = font(18);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.sd_layout.leftSpaceToView(view,50).rightSpaceToView(view,50).heightIs(17).topSpaceToView(view,35);
    titleLabel.text = @"我的";
    
}


- (void)rightItemAction
{

}

- (void)makeUI
{

    tableview = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    //tableview.separatorStyle= UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(self.view,64).bottomSpaceToView(self.view,64);
    cornerRadiusView(tableview, 3);
    tableview.showsVerticalScrollIndicator = NO;
    
    UIView *headview = [UIView new];
    
    headview.backgroundColor = ClearColor;
    headview.frame = CGRectMake(0, 0, SCREEN_WIDTH, 174);
    tableview.tableHeaderView = headview;
    
    headimage = [UIImageView new];
    [headview addSubview:headimage];
    headimage.frame = CGRectMake(143*SCREEN_PRESENT, 0, 91*SCREEN_PRESENT, 91*SCREEN_PRESENT);
    cornerRadiusView(headimage, 45*SCREEN_PRESENT);

    [headimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,USERINFO.portrait]] placeholderImage:[UIImage imageNamed:@"member_mine_user"]];
    
    sexImg = [UIImageView new];
    if ([USERINFO.sex isEqualToString:@"0"]) {
        sexImg.image = [UIImage imageNamed:@"member_mine_male"];
    }
    else
    {
     sexImg.image = [UIImage imageNamed:@"member_mine_female"];
    }
    
    [headview addSubview:sexImg];
    sexImg.sd_layout.bottomEqualToView(headimage).rightSpaceToView(headview,142*SCREEN_PRESENT).widthIs(25).heightIs(25);
    
    nameLabel = [UILabel new];
    nameLabel.font = font(17);
    [headview addSubview:nameLabel];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.sd_layout.leftEqualToView(headimage).rightEqualToView(headimage).heightIs(17).topSpaceToView(headimage,16);
    nameLabel.text  =USERINFO.memberName;
    nameLabel.textColor = WhiteColor;
    
    
    
    UIButton *coinBtn = [UIButton new]; 
    [headview addSubview:coinBtn];
    coinBtn.sd_layout.rightSpaceToView(headview,10).topSpaceToView(headimage,10).widthIs(89).heightIs(30);
    [coinBtn setTitle:@"金币管理" forState:UIControlStateNormal];
    [coinBtn setImage:[UIImage imageNamed:@"jinbi"] forState:UIControlStateNormal];
    [coinBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    coinBtn.titleLabel.font = font(14);
    coinBtn.layer.borderColor = WhiteColor.CGColor;
    coinBtn.layer.borderWidth = 1;
    coinBtn.layer.cornerRadius = 5;
    coinBtn.layer.masksToBounds = YES;
    [coinBtn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -10, 0.0, 0.0)];
    [coinBtn jk_addActionHandler:^(NSInteger tag) {
        MineCoinController *vc  = [MineCoinController new];
        [self.navigationController pushViewController:vc animated:YES];
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
       
        return 1;
    }
    else if (section==1) {
    
        return 5;
    }
    else {
    
        return 3;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 72;
    }
    else
    {
        return 48;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 32;
    }
        return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.00000001;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view  = [UIView new];
    view.backgroundColor = colorWithRGB(0xEFEFF4);
    
    UIView *view1  = [UIView new];
    view1.backgroundColor = colorWithRGB(0xEFEFF4);
    
    UIButton *btn = [UIButton new];
    [view addSubview:btn];
    
    [btn setTitle:@"订单管理" forState:UIControlStateNormal];
    [btn setTitleColor:colorWithRGB(0x999999) forState:UIControlStateNormal];
    btn.titleLabel.font = font(12);
    btn.sd_layout.leftSpaceToView(view,16).topSpaceToView(view,10).widthIs(48).heightIs(13);
    
    if (section==0) {
        return view;
    }
    else
    {
      return view1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"MineCell";
    static NSString *cellID1 = @"MineCell1";
    
    MIneCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellID1];
    
    if (cell==nil) {
        
        cell = [[MIneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if (cell1==nil) {
        cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *arr = @[@"产品众筹",@"会议培训",@"支持服务"];
        NSArray *arr1 = @[@"众筹",@"培训icon",@"服务"];
        for (int i = 0; i<3; i++) {
            
            UIButton *btn = [UIButton new];
            [cell1.contentView addSubview:btn];
            btn.tag = 300+i;
            btn.sd_layout.leftSpaceToView(cell1.contentView,(SCREEN_WIDTH*i)/3).topSpaceToView(cell1.contentView,0).bottomSpaceToView(cell1.contentView,0).widthIs(SCREEN_WIDTH/3);
            [btn addTarget:self action:@selector(LookOrder:) forControlEvents:UIControlEventTouchUpInside];
            
            //要换成图片
            UIImageView *numImg = [UIImageView new];
            [btn addSubview:numImg];
            numImg.image = [UIImage imageNamed:arr1[i]];
            numImg.sd_layout.leftSpaceToView(btn,47*SCREEN_PRESENT).widthIs(30).heightIs(22).topSpaceToView(btn,15);
            
            UILabel *typeLabel = [UILabel new];
            [btn addSubview:typeLabel];
            [self makeLabel:typeLabel font:14 color:colorWithRGB(0x333333) text:arr[i]];
            typeLabel.sd_layout.leftSpaceToView(btn,15).rightSpaceToView(btn,15).heightIs(14).topSpaceToView(numImg,12);
            
            UIView *lineView = [UIView new];
            [btn addSubview:lineView];
            lineView.backgroundColor = colorWithRGB(0xE3ECF0);
            lineView.sd_layout.rightSpaceToView(btn ,0).widthIs(1).heightIs(39).topSpaceToView(btn,17);
    
        }
    }
    
    if (indexPath.section==0) {
        
        return cell1;
    }
    else
    {
        cell.titleLabel.text = titleArr[indexPath.section][indexPath.row];
        cell.Imgview.image = [UIImage imageNamed:imaArr[indexPath.section][indexPath.row]];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==2) {
        if (indexPath.row==1) {
            MineDownLoadController *vc = [MineDownLoadController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row==2)
        {
          MineComplainController  *vc = [MineComplainController new];
          [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            MineMemberController  *vc = [MineMemberController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else if (indexPath.section==1)
    {
        if (indexPath.row==0) {
            MIneZCViweController *vc = [MIneZCViweController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row==1) {
            MinePXController *vc = [MinePXController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row==2) {
            MineFWController *vc = [MineFWController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
        else if (indexPath.row==3) {
            MIneGodIdeaController *vc = [MIneGodIdeaController new];
            [self.navigationController pushViewController:vc animated:YES];
        }

        else
        {
            MineDBPController *vc = [MineDBPController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else
    {
        
    }
}

- (void)hehe
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:nil];
    UIAlertAction *okAction1 = [UIAlertAction actionWithTitle:@"从手机相册里添加" style:UIAlertActionStyleDefault handler:nil];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [alertController addAction:okAction1];
    
    [self presentViewController:alertController animated:YES completion:nil];

}

- (void)makeLabel:(UILabel *)label font:(CGFloat)fonts color:(UIColor *)color text:(NSString *)str
{
    label.text = str;
    label.font = font(fonts);
    label.textColor = color;
    label.textAlignment = NSTextAlignmentCenter;
}

- (void)LookOrder:(UIButton *)btn
{
    //产品众筹
    if (btn.tag == 300) {
        MineManyOrderController *vc  = [[MineManyOrderController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    //会议培训
    else if (btn.tag == 301)
    {
        MineMeetingController *vc  = [[MineMeetingController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    //支持服务
    else
    {
        MineServerController *vc  = [[MineServerController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
