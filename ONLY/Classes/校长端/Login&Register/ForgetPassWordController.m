//
//  ForgetPassWordController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/1/12.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "ForgetPassWordController.h"
#import "ResetPasswordController.h"
#import "MBProgressHUD+Extension.h"
@interface ForgetPassWordController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation ForgetPassWordController
{
    TPKeyboardAvoidingTableView *tableview;
    NSString *mobile;
}

- (void)viewDidLoad {
    [super viewDidLoad];self.view.backgroundColor = colorWithRGB(0xEFEFF4);
    [self prefersStatusBarHidden];
    [self makeUI];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setMobileText:) name:UITextFieldTextDidChangeNotification object:nil];
    
    
}

-(void)setMobileText:(NSNotification *)noti{
    UITextField * tf = noti.object;
    mobile = tf.text;
    NSLog(@"%@",tf.text);
}

- (void)makeUI
{
    UIView *navView = [UIView new];
    [self.view addSubview:navView];
    navView.backgroundColor = colorWithRGB(0xEFEFF4);;
    navView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).heightIs(64).topSpaceToView(self.view,0);
    
    UIButton *backBtn = [UIButton new];
    [navView addSubview:backBtn];
    backBtn.sd_layout.leftSpaceToView(navView,0).widthIs(45).topSpaceToView(navView,36).heightIs(20);
    [backBtn setImage:[UIImage imageNamed:@"blueBack"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
   
    
    UILabel *schoolmaster = [UILabel new];
    [navView addSubview:schoolmaster];
    [self makeLabel:schoolmaster font:18 color:colorWithRGB(0x333333) text:@"找回密码"];
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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
        return 146;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"LoginCell4";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = colorWithRGB(0xEFEFF4);
        
        UILabel *titleLabel = [UILabel new];
        titleLabel.font = font(14);
        titleLabel.textColor = colorWithRGB(0x999999);
        [cell.contentView addSubview:titleLabel];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.text = @"请输入您的手机号码以查找您的账号";
        titleLabel.sd_layout.leftSpaceToView(cell.contentView,16).topSpaceToView(cell.contentView,0).widthIs(SCREEN_WIDTH/2+40).heightIs(14);
        
        UIView *view  = [UIView new];
        view.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:view];
        cornerRadiusView(view, 3);
        view.sd_layout.leftSpaceToView(cell.contentView,16).rightSpaceToView(cell.contentView,16).topSpaceToView(titleLabel,16).heightIs(46);
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = colorWithRGB(0xE3ECF0);
        [view addSubview:lineView];
        lineView.sd_layout.leftEqualToView(view).rightEqualToView(view).bottomSpaceToView(view,0).heightIs(1);
        
        UIImageView *phoneImg = [UIImageView new];
        [view addSubview:phoneImg];
        phoneImg.image = [UIImage imageNamed:@"形状3"];
        phoneImg.sd_layout.leftSpaceToView(view,17).topSpaceToView(view,18).widthIs(11).heightIs(15);
        
        UITextField *textfield = [UITextField  new];
        [view addSubview:textfield];
        textfield.keyboardType = UIKeyboardTypeNumberPad;
        textfield.tag = 100;
        textfield.font  = font(14);
        textfield.textAlignment = NSTextAlignmentLeft;
        textfield.placeholder = @"请输入手机号";
        textfield.sd_layout.leftSpaceToView(phoneImg,13).topSpaceToView(view,18).heightIs(14).rightSpaceToView(view,10);
        
        
        UIButton *btn = [UIButton new];
        [cell.contentView addSubview:btn];
        btn.sd_layout.leftSpaceToView(cell.contentView,16).rightSpaceToView(cell.contentView,16).topSpaceToView(view,24).heightIs(45);
        btn.backgroundColor = colorWithRGB(0x00A9EB);
        cornerRadiusView(btn, 4);
        [btn setTitle:@"下一步" forState:UIControlStateNormal];
        [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
        btn.titleLabel.font = font(16);
        [btn addTarget:self action:@selector(nextClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
       UITextField *textfield = [cell.contentView viewWithTag:100];
       textfield.text = mobile;
        return cell;
}

//下一步按钮的点击
- (void)nextClick
{
    if ([Validate ValidateMobileNumber:mobile]) {
        ResetPasswordController *vc = [ResetPasswordController new];
        vc.mobile = mobile;
        [self presentViewController:vc animated:YES completion:nil];
    }
    else {
        [MBProgressHUD showFailure:@"手机号不合法" toView:self.view];
    }
    
}

//返回登录界面
- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
