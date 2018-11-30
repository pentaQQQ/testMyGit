//
//  MineChangeNameController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/2/20.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineChangeNameController.h"

@interface MineChangeNameController ()

@end

@implementation MineChangeNameController
{
    NSString *name;
    UITextField *textfield;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = colorWithRGB(0xEFEFF4);
    self.fd_prefersNavigationBarHidden = YES;
    
    [self setNavView];
    [self setMidView];
    
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
    titleLabel.text = @"我的资料";
    
}

//创建中间的输入试图
- (void)setMidView
{
    UIView *midView = [UIView new];
    [self.view addSubview:midView];
    midView.backgroundColor = WhiteColor;
    midView.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,16).heightIs(84).topSpaceToView(self.view,112);
    cornerRadiusView(midView, 4);
    
    UIButton *confirmBtn= [UIButton new];
    confirmBtn.backgroundColor = colorWithRGB(0x00A9EB);
    [confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [self.view addSubview:confirmBtn];
    confirmBtn.sd_layout.leftEqualToView(midView).rightEqualToView(midView).topSpaceToView(midView,24).heightIs(46);
    confirmBtn.titleLabel.font = font(14);
    cornerRadiusView(confirmBtn, 4);
    confirmBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    textfield = [UITextField  new];
    [midView addSubview:textfield];
    textfield.font  = font(14);
    textfield.textAlignment = NSTextAlignmentLeft;
    textfield.sd_layout.leftSpaceToView(midView,16).rightSpaceToView(midView,16).topEqualToView(midView).bottomEqualToView(midView);
    textfield.text = self.myStr;
    textfield.textColor = colorWithRGB(0x333333);

}

//修改姓名接口
- (void)confirmBtnClick
{
    if (self.isType==0) {
        [DataSourceTool updateMineInformation:@"memberName" myValue:textfield.text toViewController:self success:^(id json) {
            
            if ([json[@"errcode"] integerValue]==0) {
                
                USERINFO.memberName = textfield.text;
                [self.delegate reFresh:textfield.text];
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        } failure:^(NSError *error) {
            
        }];
    }
    else
    {
       [self.delegate reFresh:textfield.text];
       [self.navigationController popViewControllerAnimated:YES];
    }
 
}

@end
