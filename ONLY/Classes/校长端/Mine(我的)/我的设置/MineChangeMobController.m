//
//  MineChangeMobController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/2/10.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineChangeMobController.h"
#import "MineBingdingController.h"
@interface MineChangeMobController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@end

@implementation MineChangeMobController
{
    UITableView *tableview;
    int secend;
    UIButton *confirmBtn;
    NSString *code;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    secend = 60;
    self.view.backgroundColor = colorWithRGB(0xEFEFF4);
    self.fd_prefersNavigationBarHidden = YES;
    [self setNavView];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setMobileText:) name:UITextFieldTextDidChangeNotification object:nil];
}

-(void)setMobileText:(NSNotification *)noti{
    UITextField * tf = noti.object;
    code  = tf.text;
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
    titleLabel.text = @"修改手机";
    
    
    tableview = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    //tableview.separatorStyle= UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,16).topSpaceToView(view,0).bottomSpaceToView(self.view,0);
    cornerRadiusView(tableview, 3);
    tableview.showsVerticalScrollIndicator = NO;
    tableview.rowHeight = 70;
    [tableview registerNib:[UINib nibWithNibName:@"MineAddressCell" bundle:nil] forCellReuseIdentifier:@"MineAddressCell"];
    
    [self makeFootView];
    
}

//创建尾部试图
- (void)makeFootView
{
    UIView *footView = [UIView new];
    footView.frame = CGRectMake(16, 0, tableview.width, 46);
    footView.backgroundColor = WhiteColor;
    tableview.tableFooterView = footView;
    
    confirmBtn= [UIButton new];
    confirmBtn.backgroundColor = colorWithRGB(0xCCCCCC);
    [confirmBtn setTitle:@"下一步" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [footView addSubview:confirmBtn];
    confirmBtn.sd_layout.leftEqualToView(footView).rightEqualToView(footView).topEqualToView(footView).bottomEqualToView(footView);
    confirmBtn.titleLabel.font = font(14);
    cornerRadiusView(confirmBtn, 4);
    confirmBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [confirmBtn addTarget:self action:@selector(addAddress:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
//添加收获地址
- (void)addAddress:(UIButton *)btn
{
    MineBingdingController *vc  = [MineBingdingController new];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineChangeMob"];
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"MineChangeMob1"];
    
    if (cell==nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MineChangeMob"];
        UILabel *lab1 = [UILabel new];
        [cell.contentView addSubview:lab1];
        lab1.font = font(12);
        lab1.textColor = colorWithRGB(0x666666);
        lab1.textAlignment = NSTextAlignmentLeft;
        lab1.sd_layout.leftSpaceToView(cell.contentView,17).topSpaceToView(cell.contentView,20).rightSpaceToView(cell.contentView,17).heightIs(12);
        lab1.text = @"更换手机号，之后可以用新手机号及当前的密码登录";
        
        UILabel *lab2 = [UILabel new];
        [cell.contentView addSubview:lab2];
        lab2.font = font(12);
        lab2.textColor = colorWithRGB(0x666666);
        lab2.textAlignment = NSTextAlignmentLeft;
        lab2.sd_layout.leftSpaceToView(cell.contentView,17).topSpaceToView(lab1,12).rightSpaceToView(cell.contentView,17).heightIs(12);
        lab2.text = [NSString stringWithFormat:@"需要验证原来的手机号码：%@",USERINFO.mobile];
        
    }
    
    if (cell1==nil) {
        
        cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MineChangeMob1"];
        
        UITextField *textfield = [UITextField  new];
        textfield.delegate = self;
        textfield.tag = 100;
        [cell1.contentView addSubview:textfield];
        textfield.font  = font(14);
        textfield.textAlignment = NSTextAlignmentLeft;
        textfield.placeholder = @"输入验证码";
        textfield.sd_layout.leftSpaceToView(cell1.contentView,17).topSpaceToView(cell1.contentView,25).heightIs(18).widthIs(80);
        
        UIButton *codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [codeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [cell1.contentView addSubview:codeBtn];
        codeBtn.titleLabel.font = font(14);
        cornerRadiusView(codeBtn, 4);
        [codeBtn jk_setBackgroundColor:colorWithRGB(0x00A9EB) forState:UIControlStateNormal];
        codeBtn.sd_layout.rightSpaceToView(cell1.contentView,16).topSpaceToView(cell1.contentView,12).widthIs(124).heightIs(45);
        [codeBtn jk_addActionHandler:^(NSInteger tag) {
            
            [DataSourceTool requestMobileCode:USERINFO.mobile typePhone:@"1" toViewController:self success:^(id json) {
                if ([json[@"errcode"] integerValue]==0) {
                    
                    NSLog(@"获取验证码成功");
                }
                
            } failure:^(NSError *error) {
                
            }];
            [self modifyCodeButtonTitle:codeBtn];
            
        }];
        

    }
    if (indexPath.row==0) {
        
        return cell;
    }
    else
    {
        UITextField *textField = [cell1.contentView viewWithTag:100];
        textField.text = code;
        return cell1;
    }
    
 
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

-(void)modifyCodeButtonTitle:(UIButton *)codeBtn {
    
    if (secend > 0) {
        secend--;
        
        NSString *btnTitle = [NSString stringWithFormat:@"重新发送(%ds)", secend];
        [codeBtn setTitle:btnTitle forState:UIControlStateNormal];
        codeBtn.enabled = NO;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self modifyCodeButtonTitle:codeBtn];
        });
        
    }
    else {
        secend = 60;
        codeBtn.enabled = YES;
        [codeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
    }
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];

}


@end
