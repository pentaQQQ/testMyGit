//
//  MBProgressHUD+Extension.m
//  Test
//
//  Created by George on 2017/1/4.
//  Copyright © 2017年 虞嘉伟. All rights reserved.
//

#import "MBProgressHUD+Extension.h"
#import "ActivityView.h"

@implementation MBProgressHUD (Extension)


//privite
+(void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view complete:(dispatch_block_t)completeBlock {
    
    [MBProgressHUD hideHUDForView:view animated:NO];
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    
    hud.removeFromSuperViewOnHide = YES;
    
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.animationType = MBProgressHUDAnimationZoomOut;
    
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    
    hud.labelFont = [UIFont fontWithName:@"Helvetica" size:14];
    hud.labelText = text;
    hud.color = [UIColor whiteColor];
    
    hud.layer.shadowColor = [UIColor blackColor].CGColor;
    hud.layer.shadowOffset = CGSizeZero;
    hud.layer.shadowRadius = 8;
    hud.layer.shadowOpacity = 0.6;
    
//    hud.minShowTime = 1.5;
    
    hud.completionBlock = completeBlock;
    
    [hud hide:YES afterDelay:2.0];
}

//加载成功
+(void)showSuccess:(NSString *)success toView:(UIView *)view complete:(dispatch_block_t)completeBlock {
    
    [self show:success icon:@"jg_hud_success" view:view complete:completeBlock];
}
//加载失败
+(void)showFailure:(NSString *)failure toView:(UIView *)view complete:(dispatch_block_t)completeBlock {
    
    [self show:failure icon:@"jg_hud_error" view:view complete:completeBlock];
}
+(void)showFailure:(NSString *)failure toView:(UIView *)view {
    
    [self show:failure icon:@"jg_hud_error" view:view complete:nil];
}

//加载中
+(void)showLoadingToView:(UIView *)view {
    
    if (!view) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    
//    UIView *cus = [UIView new];
//    cus.backgroundColor = [UIColor redColor];
//    cus.frame = CGRectMake(0, 0, 50, 50);
    
    MBProgressHUD *hud = nil;
    hud = [MBProgressHUD HUDForView:view];
    if (hud == nil) {
        hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    }
    
    hud.removeFromSuperViewOnHide = YES;
    
//    hud.mode = MBProgressHUDModeAnnularDeterminate;
    hud.mode = MBProgressHUDModeCustomView;
//    hud.animationType = MBProgressHUDAnimationZoomOut;
    
    hud.customView = [ActivityView new];
//    hud.labelText = @"loading";
    
    hud.color = [UIColor whiteColor];
    
    
    hud.layer.shadowColor = [UIColor blackColor].CGColor;
    hud.layer.shadowOffset = CGSizeZero;
    hud.layer.shadowRadius = 4;
    hud.layer.shadowOpacity = 0.3;
    
//    hud.minShowTime = 0.2;
    
    hud.opacity = 1;
}




//上传中



@end
