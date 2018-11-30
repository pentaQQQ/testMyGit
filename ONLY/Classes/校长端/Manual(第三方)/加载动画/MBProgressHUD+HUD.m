//
//  MBProgressHUD+HUD.m
//  OA
//
//  Created by George on 16/11/1.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import "MBProgressHUD+HUD.h"

@implementation MBProgressHUD (HUD)


/**
 显示GIF的loading

 @param view HUD显示的父视图
 */
+(void)showGIFInView:(UIView *)view {
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    hud.animationType = MBProgressHUDAnimationFade;
    hud.contentColor = [UIColor darkGrayColor];
    hud.square = NO;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    
//    YLImageView* imageView = [YLImageView new];
//    imageView.image = [YLGIFImage imageNamed:@"run.gif"];
    
//    hud.customView = imageView;
}


/**
 显示imageView贞动画的loading

 @param view HUD显示的父视图
 */
+(void)showIMGInView:(UIView *)view {
    
    MBProgressHUD *hud = [self loadingInView:view];
    
    NSMutableArray *imageArr = [NSMutableArray array];
    for (int i = 1; i<23; i++) {
        [imageArr addObject:[UIImage imageNamed:[NSString stringWithFormat:@"Loading.bundle/loading_7/loading_7_%d", i]]];
    }
    UIImageView *imageView = [UIImageView new];
//    imageView.animationImages = @[[UIImage imageNamed:@"score_green_money"],
//                                  [UIImage imageNamed:@"score_purple_money"],
//                                  [UIImage imageNamed:@"score_red_money"]];
    imageView.animationImages = imageArr;
    imageView.animationDuration = (imageArr.count+1)*0.075;
    imageView.animationRepeatCount = MAXFLOAT;
    [imageView startAnimating];
    
    hud.customView = imageView;
}


///**
// 显示shape animation layer
// 
// @param view HUD显示的父视图
// */
//+(void)showSALInView:(UIView *)view {
//    
//    MBProgressHUD *hud = [self loadingInView:view];
//    
//    MBCircleView *circle = [MBCircleView new];
//    circle.frame = CGRectMake(0, 0, 33, 33);
//    circle.tintColor = [UIColor greenColor];
//    
//    hud.customView = circle;
//}

/**
 隐藏loading

 @param view HUD显示的父视图
 */
+(void)dismissInView:(UIView *)view {
    [MBProgressHUD hideHUDForView:view animated:YES];
}


/**
 显示请求成功的loading

 @param view         HUD显示的父视图
 @param text         提示文字
 @param successBlock 请求成功的回调
 */
+(void)loadingInView:(UIView *)view withText:(NSString *)text success:(void(^)())successBlock {
    
    MBProgressHUD *hud = [self loadingInView:view];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"score_purple_money"]];
    
    hud.label.text = text;
    
    hud.minShowTime = 2;
    hud.completionBlock = successBlock;
    [MBProgressHUD hideHUDForView:view animated:YES];
}


/**
 显示请求失败的loading

 @param view         HUD显示的父视图
 @param text         提示文字
 @param failureBlock 请求失败的回调
 */
+(void)loadingInView:(UIView *)view withText:(NSString *)text failure:(void(^)())failureBlock {
    
    MBProgressHUD *hud = [self loadingInView:view];
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"score_green_money"]];
    
    hud.label.text = text;
    
    hud.minShowTime = 2;
    hud.completionBlock = failureBlock;
    [MBProgressHUD hideHUDForView:view animated:YES];
}


/**
 私有方法

 @param view HUD显示的父视图

 @return 返回一个MBProgress的实例
 */
+(MBProgressHUD *)loadingInView:(UIView *)view {
    MBProgressHUD *hud = nil;
    hud = [MBProgressHUD HUDForView:view];
    if (hud == nil) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    hud.mode = MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide = YES;
    hud.animationType = MBProgressHUDAnimationFade;
    hud.contentColor = [UIColor darkGrayColor];
    hud.square = NO;
    hud.backgroundView.style = MBProgressHUDBackgroundStyleSolidColor;
    return hud;
}

@end
