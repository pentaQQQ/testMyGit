//
//  AboutMeController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/3/15.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "AboutMeController.h"

@interface AboutMeController ()

@end

@implementation AboutMeController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = colorWithRGB(0xEFEFF4);
    self.fd_prefersNavigationBarHidden = YES;
    [self setNavView];
    [self makeUI];
    
}


//创建导航栏（自定义）
- (void)setNavView
{
    UIView *view  = [UIView new];
    view.backgroundColor = colorWithRGB(0x00A9EB);
    [self.view addSubview:view];
    view.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(64);
    
    UIButton *backBtn = [UIButton new];
    [view addSubview:backBtn];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backBtn.sd_layout.leftSpaceToView(view,8).topSpaceToView(view,25).heightIs(30).widthIs(30);
    [backBtn jk_addActionHandler:^(NSInteger tag) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    UIImageView *imageview = [UIImageView new];
    imageview.image = [UIImage imageNamed:@"member_mine_bg"];
    [self.view addSubview:imageview];
    imageview.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(view,0).heightIs(174);
    
    UILabel *titleLabel = [UILabel new];
    [view addSubview:titleLabel];
    titleLabel.textColor= WhiteColor;
    titleLabel.font = font(18);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.sd_layout.leftSpaceToView(view,50).rightSpaceToView(view,50).heightIs(17).topSpaceToView(view,35);
    titleLabel.text = @"关于我们";
    
}

//创建UI
- (void)makeUI
{
    UIView *view  = [UIView new];
    [self.view addSubview:view];
    view.backgroundColor = WhiteColor;
    cornerRadiusView(view, 5);
    view.sd_layout.leftSpaceToView(self.view,15).rightSpaceToView(self.view,15).bottomSpaceToView(self.view,95*SCREEN_PRESENT).heightIs(475*SCREEN_PRESENT);
    
    UIImageView *imageview = [UIImageView new];
    [view addSubview:imageview];
    imageview.sd_layout.leftSpaceToView(view,140*SCREEN_PRESENT).heightIs(81).widthIs(66).topSpaceToView(view,38);
    imageview.image = [UIImage imageNamed:@"logo"];
    
    UILabel *lab = [UILabel new];
    [view addSubview:lab];
    lab.font = font(14);
    lab.text = @"当前版本：V1.0.1";
    lab.textColor = colorWithRGB(0x333333);
    lab.textAlignment = NSTextAlignmentCenter;
    lab.sd_layout.leftSpaceToView(view,15).rightSpaceToView(view,15).heightIs(14).topSpaceToView(imageview,20);
    
    UIView *lineView = [UIView new];
    lineView.alpha = 0.3;
    lineView.backgroundColor = colorWithRGB(0x999999);
    [view addSubview:lineView];
    lineView.sd_layout.leftEqualToView(view).rightEqualToView(view).heightIs(1).topSpaceToView(lab,25);
    
    UILabel *textView = [UILabel new];
    textView.numberOfLines = 0;
    textView.text = @"“昂立微点”始于1984年上海交通大学成立的全国第一个大学生勤工俭学中心，三十多年来，演绎出了教育培训行业中驰名的“昂立教育”品牌。 是目前上海教学点最多、综合规模最大、全国加盟学校最多的综合性非学历教育机构。 教育产品涵盖幼儿园、少儿、中学生、外语、学历助学、企业管理等板块，创新的产品、优质的教学、周到的服务，满足国人追求卓越教育的渴望。 如今昂立教育更是重点关注中国基础教育发展，聚焦K12领域，成为青少儿教育成长专家。 昂立教育目前拥有3000多名正式员工，近1500位全职教师，拥有完备的教研与服务体系。 2014年，昂立教育通过资产重组，整体注入上市公司，成为中国A股教育第一股。昂立教育迎来了新的发展机遇.";
    
    [view addSubview:textView];
    textView.font = font(14);
    textView.alpha = 0.9;
    textView.textColor = colorWithRGB(0x333333);
    textView.sd_layout.leftSpaceToView(view,15).rightSpaceToView(view,15).topSpaceToView(lineView,20).bottomSpaceToView(view,10);
    
}


@end
