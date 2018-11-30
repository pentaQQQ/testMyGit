//
//  MemberBaseTabBarController.m
//  ONLY
//
//  Created by 上海点硕 on 2016/12/19.
//  Copyright © 2016年 cbl－　点硕. All rights reserved.
//

#import "MemberBaseTabBarController.h"

@interface MemberBaseTabBarController ()

@end

@implementation MemberBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTabbar];
    self.tabBar.tintColor = colorWithRGB(0x1D99D4);
}


- (void)createTabbar
{
    MemberHomeViewController *c1=[[MemberHomeViewController alloc]init];
    BaseNavigationController *nav1 = [[BaseNavigationController alloc] initWithRootViewController:c1];
    nav1.view.backgroundColor=[UIColor whiteColor];
    c1.title=@"首页";
    c1.tabBarItem.image=[UIImage imageNamed:@"member_tabbar_home"];
    
    MemberNewsViewController *c2=[[MemberNewsViewController alloc]init];
    BaseNavigationController *nav2 = [[BaseNavigationController alloc] initWithRootViewController:c2];
    nav2.view.backgroundColor=[UIColor whiteColor];
    c2.title=@"消息";
    c2.tabBarItem.image=[UIImage imageNamed:@"member_tabbar_message"];
    
    MemberMineViewController *c3=[[MemberMineViewController alloc]init];
    BaseNavigationController *nav3 = [[BaseNavigationController alloc] initWithRootViewController:c3];
    nav3.view.backgroundColor=[UIColor whiteColor];
    c3.title=@"我的";
    c3.tabBarItem.image=[UIImage imageNamed:@"member_tabbar_mine"];

    self.viewControllers=@[nav1,nav2,nav3];
    
}


@end
