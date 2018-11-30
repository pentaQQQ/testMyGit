//
//  BaseNavigationController.m
//  ONLY
//
//  Created by 上海点硕 on 2016/12/17.
//  Copyright © 2016年 cbl－　点硕. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.translucent = NO;
    navBar.barTintColor = colorWithRGB(0x00A5E9);
    navBar.tintColor = [UIColor whiteColor];
    [navBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:17 weight:UIFontWeightLight]}];
    [navBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [navBar setShadowImage:[UIImage new]];
    
    [self setNavBarItemTheme];
    
}

- (void)setNavBarItemTheme
{
    //返回按钮
    UIImage *backImg = [UIImage imageNamed:@"6_白箭头"];
    [[UIBarButtonItem appearance]setBackButtonBackgroundImage:[backImg resizableImageWithCapInsets:UIEdgeInsetsMake(0, backImg.size.width, 0, 0)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance]setBackButtonTitlePositionAdjustment:UIOffsetMake(-1000, 0) forBarMetrics:UIBarMetricsDefault];
    
    
    //设置背景
    //    [item setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    // 设置文字属性
    //    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    //    textAttrs[NSForegroundColorAttributeName] = [UIColor redColor];
    //    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:16];
    //    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    //    [item setTitleTextAttributes:textAttrs forState:UIControlStateHighlighted];
    
}

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size

{
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context,
                                   
                                   color.CGColor);
    
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return img;
}

//hide  tabbar
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}


//status  become  white
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


+(instancetype)navigationRootController:(UIViewController *)root {
    return [[BaseNavigationController alloc] initWithRootViewController:root];
}


@end
