//
//  RegisterViewController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/1/13.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "MemberLoginController.h"
#import "MineInterestController.h"
#import "MBProgressHUD+Extension.h"
@interface RegisterViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@end

@implementation RegisterViewController
{
    TPKeyboardAvoidingTableView *tableview;
    int secend;
    NSArray *arr;
    NSArray *arr1;
    NSMutableArray *textArr;
    NSString *mobile;
    NSString *TwoCode;
    NSString *PassWord;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    secend = 60;
    self.view.backgroundColor = colorWithRGB(0xEFEFF4);
    [self prefersStatusBarHidden];
    arr = @[@"手机号",@"",@"设置密码（6-20位英文或数字"];
    arr1 = @[@"phone",@"",@"password"];
    textArr = [NSMutableArray array];
    [self makeUI];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setMobileText:) name:UITextFieldTextDidChangeNotification object:nil];
    
}

-(void)setMobileText:(NSNotification *)noti{
    UITextField * tf = noti.object;
    if (tf.tag == 101) {
        mobile = tf.text;
    }
    else if (tf.tag == 103)
    {
      TwoCode = tf.text;
    }
    else
    {
      PassWord = tf.text;
    }
    
    NSLog(@"%@",tf.text);
}

- (void)makeUI
{
    UIView *navView = [UIView new];
    [self.view addSubview:navView];
    navView.backgroundColor = colorWithRGB(0xEFEFF4);;
    navView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).heightIs(64).topSpaceToView(self.view,0);
    
    UILabel *changeLogin = [UILabel new];
    [navView addSubview:changeLogin];
   
    changeLogin.userInteractionEnabled = YES;
    [self makeLabel:changeLogin font:14 color:colorWithRGB(0x008CCF) text:@"登录"];
    changeLogin.textAlignment = NSTextAlignmentRight;
    changeLogin.sd_layout.topSpaceToView(navView,41).heightIs(14).rightSpaceToView(navView,16).widthIs(56);
    // 单击的 Recognizer
    UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeMember)];
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [changeLogin addGestureRecognizer:singleRecognizer];
    
    
    UILabel *schoolmaster = [UILabel new];
    [navView addSubview:schoolmaster];
    [self makeLabel:schoolmaster font:18 color:colorWithRGB(0x333333) text:@"个人注册"];
    schoolmaster.sd_layout.topSpaceToView(navView,37).heightIs(18).leftSpaceToView(navView,153*SCREEN_PRESENT).widthIs(72);
    
    tableview = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:tableview];
    tableview.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topSpaceToView(navView,0).bottomSpaceToView(self.view,0);
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = colorWithRGB(0xEFEFF4);
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableview setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    UIView *headView = [UIView new];
    headView.backgroundColor = colorWithRGB(0xEFEFF4);
    headView.frame= CGRectMake(0,0,SCREEN_WIDTH,142);
    tableview.tableHeaderView = headView;
    
    UIImageView *imageview = [UIImageView new];
    [headView addSubview:imageview];
    imageview.sd_layout.leftSpaceToView(headView,155*SCREEN_PRESENT).heightIs(81).widthIs(66).topSpaceToView(headView,38);
    imageview.image = [UIImage imageNamed:@"logo"];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==3) {
        return 100;
        
    }
    
    else
    {
        return 46;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"LoginCell";
    static NSString *cellID1 = @"LoginCell1";
    static NSString *cellID2 = @"LoginCell0";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellID1];
    UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellID2];
    
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = colorWithRGB(0xEFEFF4);
        
        UIView *view  = [UIView new];
        view.backgroundColor = WhiteColor;
        [cell.contentView addSubview:view];
        cornerRadiusView(view, 3);
        view.sd_layout.leftSpaceToView(cell.contentView,16).rightSpaceToView(cell.contentView,16).topEqualToView(cell.contentView).bottomSpaceToView(cell.contentView,0);
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = colorWithRGB(0xE3ECF0);
        [view addSubview:lineView];
        lineView.sd_layout.leftEqualToView(view).rightEqualToView(view).bottomSpaceToView(view,0).heightIs(1);
        
        UIImageView *phoneImg = [UIImageView new];
        [view addSubview:phoneImg];
        phoneImg.image = [UIImage imageNamed:@"形状3"];
        phoneImg.sd_layout.leftSpaceToView(view,17).topSpaceToView(view,18).widthIs(11).heightIs(15);
        
        UITextField *textfield = [UITextField  new];
        textfield.tag = 103;
        [view addSubview:textfield];
        textfield.font  = font(14);
        textfield.keyboardType = UIKeyboardTypeNumberPad;
        textfield.textAlignment = NSTextAlignmentLeft;
        textfield.placeholder = @"请输入验证码";
        textfield.sd_layout.leftSpaceToView(phoneImg,13).topSpaceToView(view,18).heightIs(14).rightSpaceToView(view,10);
        
        UIButton *codeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [codeBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [view addSubview:codeBtn];
        codeBtn.titleLabel.font = font(14);
        cornerRadiusView(codeBtn, 4);
        [codeBtn jk_setBackgroundColor:colorWithRGB(0x00A9EB) forState:UIControlStateNormal];
        codeBtn.sd_layout.rightSpaceToView(view,16).topSpaceToView(view,5).widthIs(124).heightIs(35);
        [codeBtn jk_addActionHandler:^(NSInteger tag) {
            
            [DataSourceTool requestMobileCode:mobile typePhone:@"0" toViewController:self success:^(id json) {
                
                NSLog(@"=========%@",json);
            } failure:^(NSError *error) {
                NSLog(@"________%@",error);
            }];
          
            [self modifyCodeButtonTitle:codeBtn];
            
        }];
    
    }
    
    if (cell1==nil) {
        
        cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell1.backgroundColor = colorWithRGB(0xEFEFF4);
        
        UIButton *btn = [UIButton new];
        [cell1.contentView addSubview:btn];
        btn.sd_layout.leftSpaceToView(cell1.contentView,16).rightSpaceToView(cell1.contentView,16).topSpaceToView(cell1.contentView,24).heightIs(45);
        btn.backgroundColor = colorWithRGB(0x00A9EB);
        cornerRadiusView(btn, 4);
        [btn setTitle:@"注册" forState:UIControlStateNormal];
        [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
        btn.titleLabel.font = font(16);
        [btn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    if (cell2==nil) {
        cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        cell2.backgroundColor = colorWithRGB(0xEFEFF4);
        
        UIView *view  = [UIView new];
        view.backgroundColor = WhiteColor;
        [cell2.contentView addSubview:view];
        cornerRadiusView(view, 3);
        view.sd_layout.leftSpaceToView(cell2.contentView,16).rightSpaceToView(cell2.contentView,16).topEqualToView(cell2.contentView).bottomSpaceToView(cell2.contentView,0);
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = colorWithRGB(0xE3ECF0);
        [view addSubview:lineView];
        lineView.sd_layout.leftEqualToView(view).rightEqualToView(view).bottomSpaceToView(view,0).heightIs(1);
        
        UIImageView *phoneImg = [UIImageView new];
        [view addSubview:phoneImg];
        phoneImg.tag = 100;
        phoneImg.image = [UIImage imageNamed:@"password"];
        phoneImg.sd_layout.leftSpaceToView(view,17).topSpaceToView(view,18).widthIs(11).heightIs(15);
        
        UITextField *textfield = [UITextField  new];
        [view addSubview:textfield];
        
        if (indexPath.row==0) {
            textfield.tag = 101;
            textfield.keyboardType = UIKeyboardTypeNumberPad;
        }
        else
        {
          textfield.tag = 102;
          textfield.secureTextEntry = YES;
        }
        
        textfield.font  = font(14);
        textfield.textAlignment = NSTextAlignmentLeft;
        textfield.placeholder = @"设置密码 (6到20位英文或数字)";
        textfield.sd_layout.leftSpaceToView(phoneImg,13).topSpaceToView(view,18).heightIs(14).rightSpaceToView(view,10);
        
    }
    
    //*************************************************//
    if (indexPath.row==2||indexPath.row==0) {
        
        UIImageView *imageview = [cell2.contentView viewWithTag:100];
        imageview.image = [UIImage imageNamed:arr1[indexPath.row]];
        
        //手机号
        UITextField *textfield = [cell2.contentView viewWithTag:101];
        textfield.placeholder = arr[indexPath.row];
        textfield.text = mobile;
        //密码
        UITextField *textfield1 = [cell2.contentView viewWithTag:102];
        textfield1.placeholder = arr[indexPath.row];
        textfield1.text = PassWord;
        //验证码
        UITextField *textfield2 = [cell2.contentView viewWithTag:103];
        textfield2.text  = TwoCode;
        
        return cell2;
    }
    else if (indexPath.row==1)
    {
        return cell;
    }
    else
    {
        return cell1;
    }
}

//登陆按钮的点击（成功之后要返回登录界面）
- (void)confirm
{
    if (mobile.length ==0||PassWord.length==0||TwoCode.length==0) {
        
        [MBProgressHUD showFailure:@"请完善注册信息" toView:self.view];
    }
    else{
    [DataSourceTool requestRegister:mobile password:PassWord code:TwoCode toViewController:self success:^(id json) {
        if ([json[@"errcode"] integerValue]==0) {
            USERINFO.personal = NO;
            NSLog(@"%@",json);
            [DataSourceTool saveUserInfo:json[@"rsp"]];
            
            MineInterestController *vc  = [MineInterestController new];
            vc.typeVc = 0;
            [self presentViewController: vc animated:YES completion:nil];
            
        }
        
    } failure:^(NSError *error) {
        
    }];
    }
  
 }

- (void)changeMember
{
//    LoginViewController *vc  = [[LoginViewController alloc] init];
//    [self presentViewController:vc animated:YES completion:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//这个给二维码的点击事件用吧
- (void)forgetPassword
{
    
    
}

- (void)makeLabel:(UILabel *)label font:(CGFloat)fonts color:(UIColor *)color text:(NSString *)str
{
    label.text = str;
    label.font = font(fonts);
    label.textColor = color;
    label.textAlignment = NSTextAlignmentLeft;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (BOOL)prefersStatusBarHidden {
    //设置隐藏显示
    return NO;
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
