//
//  MineEditAddressController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/2/9.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineEditAddressController.h"
#import "MineMemberCell.h"
#import "SGPickerView.h"
#import "MineChangeNameController.h"
@interface MineEditAddressController ()<UITableViewDelegate,UITableViewDataSource,reFreshMyControllerDelegate>

@end

@implementation MineEditAddressController

{
    UITableView *tableview;
    NSArray *titleArr;
    NSMutableArray *detailArr;
    NSInteger myIndex;
    NSArray *addressArr;
//    NSString *name;
//    NSString *phone;
//    NSString *detailAddress;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = colorWithRGB(0xEFEFF4);
    self.fd_prefersNavigationBarHidden = YES;
    titleArr = @[@"收货人姓名" ,@"联系电话" ,@"地区" ,@"地区详情"];
    
    detailArr = [NSMutableArray arrayWithObjects:self.myName,self.myPhone,self.myCity,self.myAdress,nil];
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
    titleLabel.text = @"收货地址";
    
    
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
    btn.backgroundColor = colorWithRGB(0x0099E3);
    btn.titleLabel.font = font(14);
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(saveAddress) forControlEvents:UIControlEventTouchUpInside];
    cornerRadiusView(btn, 4);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
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
    
    cell.titleLab.text = titleArr[indexPath.row];
    cell.detailLab.text = detailArr[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==2) {
        
        SGPickerView *pickerView = [[SGPickerView alloc] init];
        [pickerView show];
        pickerView.locationMessage = ^(NSString *str){
        addressArr = [str componentsSeparatedByString:@" "];
            [detailArr replaceObjectAtIndex:2 withObject:str];
            [tableview reloadData];
            NSLog(@"我的地址是 = %@",addressArr[0]);
        };

    }
    
    else
    {
        MineChangeNameController *vc  = [MineChangeNameController new];
        vc.delegate = self;
        myIndex= indexPath.row;
        vc.isType=1;
        vc.myStr = detailArr[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

//刷新界面的代理
- (void)reFresh:(NSString *)str
{
    [detailArr replaceObjectAtIndex:myIndex withObject:str];
    [tableview reloadData];
}

//保存地址
- (void)saveAddress
{
    if (self.myType==0) {
      
        [DataSourceTool saveAddress:@"" consignee:detailArr[0] contact_phone:detailArr[1] is_status:@"0" province_name:addressArr[0] city_name:addressArr[1] address:detailArr[3] area_name:addressArr[2] toViewController:self success:^(id json) {
            
            if ([json[@"errcode"] integerValue]==0) {
                
                [self.delegate AddressCresh];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        } failure:^(NSError *error) {
            
        }];
    }
    else
    {
        if (addressArr.count==0) {
            addressArr = @[self.myprovince,self.myCity ,self.myArea];
        }
       [DataSourceTool updateAddress:self.myAdressId consignee:detailArr[0] contact_phone:detailArr[1] is_status:self.myStause province_name:addressArr[0] city_name:addressArr[1] address:detailArr[3] area_name:addressArr[2] toViewController:self success:^(id json) {
           if ([json[@"errcode"] integerValue]==0) {
               
               [self.delegate AddressCresh];
               
               [self.navigationController popViewControllerAnimated:YES];
           }
           
       } failure:^(NSError *error) {
           
       }];
    
    }
}

@end
