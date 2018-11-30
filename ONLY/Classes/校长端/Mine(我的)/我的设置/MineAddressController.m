//
//  MineAddressController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/2/9.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineAddressController.h"
#import "MineAddressCell.h"
#import "MineEditAddressController.h"
#import "AddressModel.h"
#import "UITableView+Sure_Placeholder.h"
@interface MineAddressController ()<UITableViewDataSource,UITableViewDelegate,MyDelegate,UIAlertViewDelegate>

@end

@implementation MineAddressController
{
    UITableView *tableview;;
    NSMutableArray *dataArray;
    NSString *addressId;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = colorWithRGB(0xEFEFF4);
    self.fd_prefersNavigationBarHidden = YES;
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
    cornerRadiusView(tableview, 3);
    tableview.showsVerticalScrollIndicator = NO;
    tableview.rowHeight = 115;
    [tableview registerNib:[UINib nibWithNibName:@"MineAddressCell" bundle:nil] forCellReuseIdentifier:@"MineAddressCell"];
    tableview.firstReload = YES;
   
    
    [self makeFootView];
  
    
    
}

//创建尾部试图
- (void)makeFootView
{
    UIView *footView = [UIView new];
    footView.frame = CGRectMake(16, 0, tableview.width, 46);
    footView.backgroundColor = WhiteColor;
    
    tableview.tableFooterView = footView;
    
    
    UIButton *btn= [UIButton new];
    [btn setTitle:@"+ 新建收货地址" forState:UIControlStateNormal];
    [btn setTitleColor:colorWithRGB(0x333333) forState:UIControlStateNormal];
    [footView addSubview:btn];
    btn.sd_layout.leftEqualToView(footView).rightEqualToView(footView).topEqualToView(footView).bottomEqualToView(footView);
    btn.titleLabel.font = font(14);
    btn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [btn addTarget:self action:@selector(addAddress:) forControlEvents:UIControlEventTouchUpInside];

}
//添加收获地址
- (void)addAddress:(UIButton *)btn
{
    MineEditAddressController *vc  = [MineEditAddressController new];
    vc.delegate = self;
    vc.myName = @"";
    vc.myPhone = @"";
    vc.myAdress = @"";
    vc.myCity = @"";
    vc.myType = 0;
    [self.navigationController pushViewController:vc animated:YES];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 40;
    }
    else
    {
        return 0.00000001;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   MineAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineAddressCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    AddressModel *model = dataArray[indexPath.section];
    cell.namePhone.text = [NSString stringWithFormat:@"%@ %@",model.consignee,model.contact_phone];
    cell.detailAddress.text = [NSString stringWithFormat:@"%@%@%@%@",model.province_name,model.city_name,model.area_name,model.address];
    if ([model.is_status isEqualToString:@"1"]) {
        cell.selectedImg.image = [UIImage imageNamed:@"selected"];
    }
    else
    {
     cell.selectedImg.image = [UIImage imageNamed:@"pay_normal"];
    }
    
    cell.deleteAddressBlock = ^(void)
    {
        addressId = model.member_address_id;
        
        UIAlertView* alv = [[UIAlertView alloc] initWithTitle:nil message:@"确定删除吗?" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",@"放弃", nil];
        
        [alv show];

      
    };
    
    
    cell.editAddressBlock = ^(void)
    {
        MineEditAddressController *vc  = [MineEditAddressController new];
        vc.myName = model.consignee;
        vc.myPhone = model.contact_phone;
        vc.myAdress = model.address;
        vc.myCs = [NSString stringWithFormat:@"%@%@%@",model.province_name,model.city_name,model.area_name];
        vc.myprovince = model.province_name;
        vc.myArea = model.area_name;
        vc.myCity = model.city_name;
        vc.myType = 1;
        vc.myAdressId = model.member_address_id;
        vc.myStause = model.is_status;
        vc.delegate = self;
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    cell.defaultAddressBlock = ^(void)
    {
        if (self.whoCome==YES) {
        
            [self.delegate sendAddressModel:model];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
     [DataSourceTool defaultAddress:model.member_address_id toViewController:self success:^(id json) {
         if ([json[@"errcode"] integerValue]==0) {
             
             [self loadData];
         }
         
     } failure:^(NSError *error) {
         
     }];
        }
    
    };
    
    return cell;

}

//买东西选地址
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.whoCome==YES) {
        
        AddressModel *model = dataArray[indexPath.section];
        [self.delegate sendAddressModel:model];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
    
    }

}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
        [DataSourceTool deleteAddress:addressId toViewController:self success:^(id json) {
            if ([json[@"errcode"] integerValue]==0) {
                
                [self loadData];
            }
        } failure:^(NSError *error) {
            
        }];
    }
    else
    {
    
    }
}

//加载地址列表
- (void)loadData
{
    [DataSourceTool findAddressStaus:@"0" ViewController:self success:^(id json) {
       
       if ([json[@"errcode"] integerValue]==0) {
           NSMutableArray *temp = [NSMutableArray array];
           for (NSDictionary *dic in json[@"rsp"]) {
               
               AddressModel *model = [AddressModel new];
               [model setValuesForKeysWithDictionary:dic];
               [temp addObject:model];
           }
            dataArray  = temp;
           [tableview reloadData];
           [tableview.placeholderView removeFromSuperview];
       }
       
   } failure:^(NSError *error) {
       
   }];
 
}

- (void)AddressCresh
{
    
    [self loadData];
 
}

@end
