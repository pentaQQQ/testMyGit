//
//  MemberLoginController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/1/12.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MemberLoginController.h"
#import "UITableView+Sure_Placeholder.h"
#import "MemberBaseTabBarController.h"
#import "LoginViewController.h"
#import "MBProgressHUD+Extension.h"
@interface MemberLoginController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MemberLoginController
{
    TPKeyboardAvoidingTableView *tableview;
    NSArray *arr ;
    NSArray *arr1;
    NSString *mobile;
    NSString *password;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = colorWithRGB(0xEFEFF4);
    [self prefersStatusBarHidden];
    arr = @[@"手机号",@"密码"];
    arr1 = @[@"phone",@"password"];
    [self makeUI];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mobileText:) name:UITextFieldTextDidChangeNotification object:nil];
}
- (void)mobileText:(NSNotification *)obj
{
    UITextField * tf = obj.object;
    if (tf.tag == 101) {
        mobile = tf.text;
    }
    else
    {
        password = tf.text;
    }
    
}

- (void)makeUI
{
    UIView *navView = [UIView new];
    [self.view addSubview:navView];
    navView.backgroundColor = colorWithRGB(0xEFEFF4);;
    navView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).heightIs(64).topSpaceToView(self.view,0);
    
    UILabel *schoolmaster = [UILabel new];
    [navView addSubview:schoolmaster];
    [self makeLabel:schoolmaster font:18 color:colorWithRGB(0x333333) text:@"市场人员登录"];
    schoolmaster.sd_layout.topSpaceToView(navView,37).heightIs(18).leftSpaceToView(navView,135*SCREEN_PRESENT).widthIs(108);
    
    UILabel *changeLogin = [UILabel new];
    [navView addSubview:changeLogin];
    changeLogin.userInteractionEnabled = YES;
    [self makeLabel:changeLogin font:14 color:colorWithRGB(0x008CCF) text:@"切换身份"];
    changeLogin.sd_layout.topSpaceToView(navView,41).heightIs(14).rightSpaceToView(navView,17).widthIs(56);
    // 单击的 Recognizer
    UITapGestureRecognizer* singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changeMember)];
    //点击的次数
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [changeLogin addGestureRecognizer:singleRecognizer];
    
    
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
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==2) {
        return 100;
        
    }
    
    else
    {
        return 46;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"LoginCell2";
    static NSString *cellID1 = @"LoginCell3";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellID1];
    
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
        phoneImg.tag = 100;
        phoneImg.image = [UIImage imageNamed:@"phone"];
        phoneImg.sd_layout.leftSpaceToView(view,17).topSpaceToView(view,18).widthIs(11).heightIs(15);
        
        UITextField *textfield = [UITextField  new];
        [view addSubview:textfield];
        textfield.tag = 101;
        textfield.font  = font(14);
        if (indexPath.row==0) {
            textfield.tag = 101;
        }
        else
        {
            textfield.tag = 102;
            textfield.secureTextEntry = YES;
        }

        textfield.textAlignment = NSTextAlignmentLeft;
        textfield.placeholder = @"密码";
        textfield.sd_layout.leftSpaceToView(phoneImg,13).topSpaceToView(view,18).heightIs(14).rightSpaceToView(view,10);
        
        
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
        [btn setTitle:@"登录" forState:UIControlStateNormal];
        [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
        btn.titleLabel.font = font(16);
        [btn addTarget:self action:@selector(loginClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *btn1 = [UIButton new];
        [cell1.contentView addSubview:btn1];
        btn1.sd_layout.leftSpaceToView(cell1.contentView,2).widthIs(96).topSpaceToView(btn,24).heightIs(15);
        [btn1 setTitle:@"忘记密码？" forState:UIControlStateNormal];
        [btn1 setTitleColor:colorWithRGB(0x666666) forState:UIControlStateNormal];
        btn1.titleLabel.font = font(14);
        
        
//        UIButton *btn2 = [UIButton new];
//        [cell1.contentView addSubview:btn2];
//        btn2.sd_layout.rightSpaceToView(cell1.contentView,8).widthIs(102).topSpaceToView(btn,24).heightIs(15);
//        [btn2 setTitle:@"新用户注册" forState:UIControlStateNormal];
//        [btn2 setTitleColor:colorWithRGB(0x008CCF) forState:UIControlStateNormal];
//        btn2.titleLabel.font = font(14);
    }
    
    //*************************************************//
    if (indexPath.row==2) {
        return cell1;
    }
    else
    {
      
        UIImageView *imageview = [cell.contentView viewWithTag:100];
        imageview.image = [UIImage imageNamed:arr1[indexPath.row]];
        
        UITextField *textfield = [cell.contentView viewWithTag:101];
        textfield.placeholder = arr[indexPath.row];
        textfield.text = mobile;
        
        UITextField *textfield1 = [cell.contentView viewWithTag:102];
        textfield1.placeholder = arr[indexPath.row];
        textfield1.text = password;
        return cell;
    }
}

//登陆按钮的点击
- (void)loginClick
{
    UITextField *textfield = [self.view viewWithTag:101];
    UITextField *textfield1 = [self.view viewWithTag:102];
    [textfield resignFirstResponder];
    [textfield1 resignFirstResponder];
    if (mobile.length ==0||password.length==0) {
        
        [MBProgressHUD showFailure:@"请完善登录信息" toView:self.view];
    }
    else {
    
    [DataSourceTool requestLogin:mobile password:password type :@"2" toViewController:self success:^(id json) {
        if ([json[@"errcode"] integerValue]==0) {
            USERINFO.personal= YES;
            [DataSourceTool saveMemberUserInfo:json[@"rsp"]];
            [UIApplication sharedApplication].keyWindow.rootViewController =[MemberBaseTabBarController new];
        }
        
    } failure:^(NSError *error) {
        
        
    }];
    }
}

- (void)changeMember
{
    
    LoginViewController *myVC = [[LoginViewController alloc] init];
    myVC.LoginType = 0;
    //创建动画
    CATransition *animation = [CATransition animation];
    //设置运动轨迹的速度
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    //设置动画类型为立方体动画
    animation.type = @"cube";
    //设置动画时长
    animation.duration =0.5f;
    //设置运动的方向
    animation.subtype =kCATransitionFromRight;
    //控制器间跳转动画
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:nil];
    
    [self presentViewController:myVC animated:YES completion:nil];
    
    //OglFlip
    
}


- (void)makeLabel:(UILabel *)label font:(CGFloat)fonts color:(UIColor *)color text:(NSString *)str
{
    label.text = str;
    label.font = font(fonts);
    label.textColor = color;
    label.textAlignment = NSTextAlignmentLeft;
}

- (BOOL)prefersStatusBarHidden { //设置隐藏显示
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
