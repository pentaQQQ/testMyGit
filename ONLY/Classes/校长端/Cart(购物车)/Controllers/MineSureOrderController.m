//
//  MineSureOrderController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/2/13.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineSureOrderController.h"
#import "MineOrderAddressCell.h"
#import "MineMemberCell.h"
#import "MineOrderSecondCell.h"
#import "TMineOrderThreeCell.h"
#import "ReceiptView.h"
#import "AddressModel.h"
#import "PayCenterController.h"
#import "MineAddressController.h"
@interface MineSureOrderController ()<UITableViewDataSource,UITableViewDelegate,sendModelDelegate>
@property(nonatomic, strong) NSString * receiptInfo;
@property(nonatomic, strong)NSString * identity;//纳税人识别号
@property(nonatomic, strong)NSString * receiptType;//0个人 1公司 -1不要发票
@property(nonatomic, assign)BOOL  has_receipt;
@end

@implementation MineSureOrderController
{
    UITableView *tableview;
    NSMutableArray *dataArray;
    NSString *myContent;
    NSString *beizhu;
    NSString *ino_taxes;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = colorWithRGB(0xEFEFF4);
    self.fd_prefersNavigationBarHidden = YES;
    self.receiptInfo = @"不开发票";
    self.identity = @"";
    self.receiptType  = @"-1";
    [self setNavView];
    
    [self makeBottomView];
    
    [self loadData];
    
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setMobileText:) name:UITextFieldTextDidChangeNotification object:nil];
}

-(void)setMobileText:(NSNotification *)noti{
    UITextField * tf = noti.object;
    beizhu = tf.text;
}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    [self loadData];
//
//}

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
    titleLabel.text = @"填写订单";
    
    
    tableview = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableview.separatorStyle= UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,16).topSpaceToView(view,0).bottomSpaceToView(self.view,0);
    cornerRadiusView(tableview, 3);
    tableview.showsVerticalScrollIndicator = NO;
    
    [tableview registerNib:[UINib nibWithNibName:@"MineOrderAddressCell" bundle:nil] forCellReuseIdentifier:@"MineOrderAddressCell"];
    [tableview registerNib:[UINib nibWithNibName:@"MineMemberCell" bundle:nil] forCellReuseIdentifier:@"MineMemberCell"];
    
    [tableview registerNib:[UINib nibWithNibName:@"MineOrderSecondCell" bundle:nil] forCellReuseIdentifier:@"MineOrderSecondCell"];
    
    [tableview registerNib:[UINib nibWithNibName:@"TMineOrderThreeCell" bundle:nil] forCellReuseIdentifier:@"TMineOrderThreeCell"];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==0)
    {
        return dataArray.count;
    }
    else
    {
       return 3;
    }
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 85;
    }
    else
    {
        return 47;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineOrderAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineOrderAddressCell"];
    MineMemberCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"MineMemberCell"];
    MineOrderSecondCell *cell2 = [tableView dequeueReusableCellWithIdentifier:@"MineOrderSecondCell"];
    TMineOrderThreeCell *cell3 = [tableView dequeueReusableCellWithIdentifier:@"TMineOrderThreeCell"];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    cell2.selectionStyle = UITableViewCellSelectionStyleNone;
    cell3.selectionStyle = UITableViewCellSelectionStyleNone;
    
   
  
    if (indexPath.section==0) {
        
        AddressModel *model = dataArray[indexPath.section];
        cell.namePhone.text = [NSString stringWithFormat:@"%@ %@",model.consignee,model.contact_phone];
        cell.detailAddress.text = [NSString stringWithFormat:@"%@%@%@%@",model.province_name,model.city_name,model.area_name,model.address];

        return cell;
    }
    else
    {
        if (indexPath.row==1) {
            cell1.titleLab.text = @"发信息票";
            cell1.detailLab.text = self.receiptInfo;
            return cell1;
        }
        else if (indexPath.row==0)
        {
            return cell2;
        }
        else
        {
            cell3.beizhu.text = beizhu;
            return cell3;
        }
    
    }
    
}

- (void)makeBottomView
{
    UIView *view  = [UIView new];
    [self.view addSubview:view];
    view.backgroundColor = WhiteColor;
    view.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).bottomSpaceToView(self.view,0).heightIs(64);
    
    UIButton *orderBtn = [UIButton new];
    [view addSubview:orderBtn];
    orderBtn.titleLabel.font = font(14);
    orderBtn.backgroundColor = colorWithRGB(0xF77142);
    [orderBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [orderBtn setTitle:@"确认订单" forState:UIControlStateNormal];
    [orderBtn addTarget:self action:@selector(orderBtnClick) forControlEvents:UIControlEventTouchUpInside];
    orderBtn.sd_layout.rightSpaceToView(view,16).topSpaceToView(view,9).widthIs(107).heightIs(45);
    cornerRadiusView(orderBtn,4);
    
    
    UILabel*sumLab = [UILabel new];
    sumLab.font= font(14);
    sumLab.textColor = colorWithRGB(0x333333);
    sumLab.textAlignment = NSTextAlignmentLeft;
    sumLab.text = @"合计：";
    [view addSubview:sumLab];
    sumLab.sd_layout.leftSpaceToView(view,16).topSpaceToView(view,27).widthIs(42).heightIs(14);
    
    UILabel*priceLab = [UILabel new];
    priceLab.font= font(21);
    priceLab.textColor = colorWithRGB(0xEA5520);
    priceLab.textAlignment = NSTextAlignmentLeft;
    priceLab.text = [NSString stringWithFormat:@"¥%@",self.goodPrice];
    [view addSubview:priceLab];
    priceLab.sd_layout.leftSpaceToView(sumLab,5).topSpaceToView(view,23).rightSpaceToView(orderBtn,5).heightIs(16);

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakself = self;
    if (indexPath.section==1&&indexPath.row==1) {
        ReceiptView * view =  [[[NSBundle mainBundle]loadNibNamed:@"ReceiptView" owner:nil options:nil]firstObject];
        if (weakself.has_receipt) {
            [view setDataWithReceiptType:weakself.receiptType companyName:weakself.receiptInfo identity:weakself.identity];
        }
        view.btnAction_block = ^(NSInteger index, NSString *companyName, NSString *identity, NSString * receiptType){
            weakself.identity = identity;
            weakself.receiptType = receiptType;
            weakself.receiptInfo = companyName;
            if ([companyName isEqualToString:@"不开发票"]) {
                weakself.has_receipt = NO;
            }else{
                weakself.has_receipt = YES;
            }
            [tableview reloadData];
        };
        [view show];
        
    }
    
    else if (indexPath.section==0)
    {
        MineAddressController *vc  = [MineAddressController new];
        vc.delegate = self;
        vc.whoCome = YES;
        [self.navigationController pushViewController:vc animated:YES];
    
    }

}

//确认订单
- (void)orderBtnClick
{
    AddressModel *model = dataArray[0];
    if (self.whoCome==NO) {
        [DataSourceTool sureOrderID:self.cart_ids address_id:model.member_address_id has_invoice:[NSString stringWithFormat:@"%d",self.has_receipt] invoice_type:self.receiptType invoice_title:self.receiptInfo invoice_taxes:self.identity ViewController:self success:^(id json) {
            
            if ([json[@"errcode"] integerValue]==0) {
                
                PayCenterController *vc  = [PayCenterController new];
                vc.price = json[@"all_amount"];
                vc.endTime = json[@"expire_time"];
                vc.order_sn = [json[@"order_sns"]  componentsJoinedByString:@","];
                vc.order_type = @"0";
                
                [self.navigationController pushViewController:vc animated:YES];
                
            }
            
        } failure:^(NSError *error) {
            
            
        }];
    }
    else
    {
      [DataSourceTool firstPagesureOrderID:self.cart_ids address_id:model.member_address_id has_invoice:[NSString stringWithFormat:@"%d",self.has_receipt] invoice_type:self.receiptType invoice_title:self.receiptInfo invoice_taxes:self.identity number:self.num ViewController:self success:^(id json) {
          
          if ([json[@"errcode"] integerValue]==0) {
              
              PayCenterController *vc  = [PayCenterController new];
              vc.price = json[@"all_amount"];
              vc.endTime = json[@"expire_time"];
              vc.order_sn = [json[@"order_sns"]  componentsJoinedByString:@","];
              vc.order_type = @"0";
              [self.navigationController pushViewController:vc animated:YES];
              
          }
      } failure:^(NSError *error) {
          
      }];
    
    }
}

//加载地址列表
- (void)loadData
{
    [DataSourceTool findAddressStaus:@"1" ViewController:self success:^(id json) {
        
        if ([json[@"errcode"] integerValue]==0) {
            NSMutableArray *temp = [NSMutableArray array];
            for (NSDictionary *dic in json[@"rsp"]) {
                
                AddressModel *model = [AddressModel new];
                [model setValuesForKeysWithDictionary:dic];
                [temp addObject:model];
            }
             dataArray  = temp;
            [tableview reloadData];
        }
        
    } failure:^(NSError *error) {
        
    }];

}

-(void)sendAddressModel:(AddressModel *)model
{
    [dataArray replaceObjectAtIndex:0 withObject:model];
    [tableview reloadData];

}

@end
