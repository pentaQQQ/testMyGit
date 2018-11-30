//
//  ServiceConfirmOrderController.m
//  ONLY
//
//  Created by Dylan on 08/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "ServiceConfirmOrderController.h"

#import "ServiceConfirmOrderCell_1.h"
#import "ServiceConfirmOrderCell_2.h"
#import "ServiceConfirmOrderCell_3.h"
#import "ServiceConfirmOrderBottomView.h"
#import "ServiceConfirmOrderFooterView.h"

#import "SGPickerView.h"
#import "ReceiptView.h"

#import "UIViewController+HUD.h"
#import "UIViewController+method.h"
@interface ServiceConfirmOrderController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView * tableView;
@property(nonatomic, strong)ServiceConfirmOrderBottomView * bottomView;

@property(nonatomic, strong)NSString * supportAddress;
@property(nonatomic, strong)NSString * receiptInfo;
@property(nonatomic, strong)NSString * identity;//纳税人识别号
@property(nonatomic, strong)NSString * receiptType;//0个人 1公司 -1不要发票
@property(nonatomic, assign)BOOL  has_receipt;
@property(nonatomic, strong)NSString * address;
@property(nonatomic, strong)NSString * contact_phone;
@property(nonatomic, strong)NSString * remark;

@end

@implementation ServiceConfirmOrderController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
    [self setupNavi];
    [self setupUI];
}
-(void)commonInit{
    self.supportAddress = @"";
    self.receiptInfo = @"不开发票";
    self.receiptType = @"-1";
    self.has_receipt = NO;
    self.address = @"";
    self.contact_phone = @"";
    self.remark = @"";
}
-(void)setupNavi{
    self.title = @"确认订单";
    self.view.backgroundColor = AppBackColor;
    
}

-(void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(16, 0, screenWidth()-32, screenHeight()-63-Nav) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 10;
    ServiceConfirmOrderFooterView * footerView = [[[NSBundle mainBundle]loadNibNamed:@"ServiceConfirmOrderFooterView" owner:nil options:nil]firstObject];
    self.tableView.tableFooterView = footerView;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorColor = AppBackColor;
    self.tableView.separatorInset = UIEdgeInsetsMake(0,0,0,0);
    [self.view addSubview:self.tableView];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ServiceConfirmOrderCell_1" bundle:nil] forCellReuseIdentifier:@"ServiceConfirmOrderCell_1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ServiceConfirmOrderCell_2" bundle:nil] forCellReuseIdentifier:@"ServiceConfirmOrderCell_2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ServiceConfirmOrderCell_3" bundle:nil] forCellReuseIdentifier:@"ServiceConfirmOrderCell_3"];
    
    [self setupBottomView];
    
}

-(void)setupBottomView{
    self.bottomView = [[[NSBundle mainBundle]loadNibNamed:@"ServiceConfirmOrderBottomView" owner:nil options:nil]lastObject];
    self.bottomView.serviceManItem = self.manItem;
    [self.view addSubview:self.bottomView];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(63);
    }];
    kWeakSelf(self);
    [self.bottomView setBtnAction_block:^(NSInteger index) {
        [weakself addOrder];
    }];
    
}
#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        return 5;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    kWeakSelf(self);
    if (indexPath.section == 0) {
        ServiceConfirmOrderCell_1 * cell = [tableView dequeueReusableCellWithIdentifier:@"ServiceConfirmOrderCell_1"];
        cell.manItem = self.manItem;
        cell.serviceItem = self.serviceItem;
        return cell;
    }
    else {
        if (indexPath.row == 0 || indexPath.row == 3) {
            ServiceConfirmOrderCell_2 * cell = [tableView dequeueReusableCellWithIdentifier:@"ServiceConfirmOrderCell_2"];
            
            if (indexPath.row == 0) {
                cell.titleLabel.text = @"支持服务地址";
                cell.detailLabel.text = self.supportAddress?self.supportAddress:@"请选择支持服务地址";
            }else if (indexPath.row == 3){
                cell.titleLabel.text = @"发票信息";
                cell.detailLabel.text = self.receiptInfo?self.receiptInfo:@"不开发票";
            }
            return cell;
        }else {
            ServiceConfirmOrderCell_3 * cell = [tableView dequeueReusableCellWithIdentifier:@"ServiceConfirmOrderCell_3"];
            cell.indexPath = indexPath;
            if (indexPath.row == 1) {
                cell.titleLabel.text = @"详细地址";
                cell.placeHolderLabel.text = @"请填写准确地址";
                cell.contentTV.text = self.address;
                [cell setTextChanged_block:^(NSString * text) {
                    weakself.address = text;
                }];
            }else if (indexPath.row == 2){
                cell.titleLabel.text = @"联系电话";
                cell.placeHolderLabel.text = @"请填写常用电话";
                cell.contentTV.text = self.contact_phone;
                [cell setTextChanged_block:^(NSString * text) {
                    weakself.contact_phone = text;
                    
                }];
            }else{
                cell.titleLabel.text = @"备注";
                [cell setTextChanged_block:^(NSString * text) {
                    weakself.remark = text;
                }];
            }
            return cell;
        }
    }
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    if ([view isKindOfClass: [UITableViewHeaderFooterView class]]) {
        UITableViewHeaderFooterView* castView = (UITableViewHeaderFooterView*) view;
        
        castView.backgroundView.backgroundColor = colorWithRGB(0xf6f7fb);
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    kWeakSelf(self);
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[ServiceConfirmOrderCell_3 class]]) {
        ServiceConfirmOrderCell_3 * cell1 =(ServiceConfirmOrderCell_3*)cell;
        [cell1.contentTV becomeFirstResponder];
    }
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            SGPickerView *pickerView = [[SGPickerView alloc] init];
            [pickerView show];
            
            pickerView.locationMessage = ^(NSString *str){
                weakself.supportAddress = str;
                [weakself.tableView reloadData];
            };
        }else if (indexPath.row == 3){
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
                [weakself.tableView reloadData];
            };
            [view show];
        }
    }
}

-(BOOL)checkData{
    if ([self isBlankString:self.supportAddress]) {
        [self showAlertViewWithMessage:@"请选择支持服务地址"];
        return NO;
    }
    if ([self isBlankString:self.address]) {
        [self showAlertViewWithMessage:@"请填写详细地址"];
        return NO;
    }
    if ([self isBlankString:self.contact_phone]) {
        [self showAlertViewWithMessage:@"请填写联系电话"];
        return NO;
    }
    if (![self.contact_phone jk_isMobileNumber]) {
        [self showAlertViewWithMessage:@"电话号码格式有误"];
        return NO;
    }
    return YES;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
#pragma mark - 网络请求
-(void)addOrder{
    if (![self checkData]) {
        return;
    };

    NSDictionary * param = @{
                             @"service_id":self.serviceItem.service_id,
                             @"member_id":USERINFO.memberId,
                             @"support_member_id":self.manItem.member_id,
                             @"has_invoice":@(self.has_receipt),
                             @"invoice_type":self.receiptType,//个人，公司
                             @"invoice_taxes":self.identity,//纳税号
                             @"invoice_title":self.receiptInfo,
                             @"service_address":self.supportAddress,
                             @"address":self.address,
                             @"contact_phone":self.contact_phone,
                             @"activity_date":self.selectedActivityDate,
                             @"remark":self.remark
                             };
    [DataSourceTool addServiceOrderListWithParam:param toViewController:self success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"errcode"]integerValue]==0) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController jk_popToViewControllerWithClassName:@"ServiceController" animated:YES];
            });
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}

@end

