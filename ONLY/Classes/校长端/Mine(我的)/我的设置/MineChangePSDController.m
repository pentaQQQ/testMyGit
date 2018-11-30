//
//  MineChangePSDController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/2/10.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineChangePSDController.h"
#import "ForgetPassWordController.h"
#import "MBProgressHUD+Extension.h"
@interface MineChangePSDController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation MineChangePSDController
{
    UITableView *tableview;
    UIButton *confirmBtn;
    NSArray *titleArr;
    NSArray *textArr;
    NSString *oldPwd;
    NSString *newPwd;
    NSString *rePwd;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = colorWithRGB(0xEFEFF4);
    self.fd_prefersNavigationBarHidden = YES;
    titleArr = @[@"输入原密码",@"设置新密码",@"重复新密码"];
    //textArr = @[oldPwd,newPwd,rePwd];
    [self setNavView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setMobileText:) name:UITextFieldTextDidChangeNotification object:nil];
}

-(void)setMobileText:(NSNotification *)noti{
    UITextField * tf = noti.object;
    if (tf.tag == 100) {
        oldPwd = tf.text;
    }
    else if (tf.tag == 101)
    {
        newPwd = tf.text;
    }
    else
    {
        rePwd = tf.text;
    }

    NSLog(@"%@",tf.text);
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
    titleLabel.text = @"修改密码";
    
    
    tableview = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    //tableview.separatorStyle= UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,16).topSpaceToView(view,0).bottomSpaceToView(self.view,0);
    cornerRadiusView(tableview, 3);
    tableview.showsVerticalScrollIndicator = NO;
    tableview.rowHeight = 47;
    [tableview registerNib:[UINib nibWithNibName:@"MineAddressCell" bundle:nil] forCellReuseIdentifier:@"MineAddressCell"];
    
    [self makeFootView];
    
}

//创建尾部试图
- (void)makeFootView
{
    UIView *footView = [UIView new];
    footView.frame = CGRectMake(16, 0, tableview.width, 106);
    tableview.tableFooterView = footView;
    
    confirmBtn= [UIButton new];
    confirmBtn.backgroundColor = colorWithRGB(0x00A9EB);
    [confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [footView addSubview:confirmBtn];
    confirmBtn.sd_layout.leftEqualToView(footView).rightEqualToView(footView).topEqualToView(footView).heightIs(46);
    confirmBtn.titleLabel.font = font(14);
    cornerRadiusView(confirmBtn, 4);
    confirmBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [confirmBtn addTarget:self action:@selector(addAddress:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *forgotBtn = [UIButton new];
    [footView addSubview:forgotBtn];
    [forgotBtn setTitle:@"忘记密码?" forState:UIControlStateNormal];
    forgotBtn.titleLabel.font = font(14);
    [forgotBtn setTitleColor:colorWithRGB(0x008CCF) forState:UIControlStateNormal];
    forgotBtn.sd_layout.leftSpaceToView(footView,0).topSpaceToView(confirmBtn,13).widthIs(98).heightIs(40);
    [forgotBtn jk_addActionHandler:^(NSInteger tag) {
      
            ForgetPassWordController *vc  = [ForgetPassWordController new];
            [self presentViewController:vc animated:YES completion:nil];
    }];

}

//修改密码成功
- (void)addAddress:(UIButton *)btn
{
    [DataSourceTool modifyPasswd:USERINFO.mobile oldpwd:oldPwd pwd:newPwd repwd:rePwd toViewController:self success:^(id json) {
        
        if ([json[@"errcode"] integerValue]==0) {
            
            [MBProgressHUD showSuccess:@"修改成功" toView:self.view complete:^{
                
                USERINFO.password = newPwd;
                [self.navigationController popViewControllerAnimated:YES];
                
                
            }];
            
        }
    } failure:^(NSError *error) {
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineChangePSD"];
    
    if (cell==nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MineChangePSD"];
        
        UITextField *textfield = [UITextField  new];
        textfield.tag = 100+indexPath.row;
        [cell.contentView addSubview:textfield];
        textfield.font  = font(14);
        textfield.textAlignment = NSTextAlignmentLeft;
        textfield.sd_layout.leftSpaceToView(cell.contentView,17).topSpaceToView(cell.contentView,17).heightIs(18).rightSpaceToView(cell.contentView,12);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    UITextField *textfield = [cell.contentView viewWithTag:100+indexPath.row];
    textfield.placeholder = titleArr[indexPath.row];
    if (textfield.tag==100) {
        textfield.text = oldPwd;
    }
    else if (textfield.tag == 101)
    {
        textfield.text = newPwd;
    }
    else
    {
        textfield.text = rePwd;
    }
    
    return cell;
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    if (textField.text.length>4) {
        confirmBtn.backgroundColor = colorWithRGB(0x00A9EB);
        
    }
    else
    {
        confirmBtn.backgroundColor = colorWithRGB(0xCCCCCC);
    }
    return YES;
}

@end
