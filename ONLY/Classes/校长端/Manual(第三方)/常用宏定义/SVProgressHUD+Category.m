//
//  SVProgressHUD+Category.m
//  DaoShengMedical
//
//  Created by George on 16/6/23.
//  Copyright © 2016年 George. All rights reserved.
//

#import "SVProgressHUD+Category.h"

@implementation SVProgressHUD (Category)


#pragma mark - 下一次更新
+(void)beginLoading {
    [SVProgressHUD showWithStatus:@"正在加载"];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeFlat];
//    [SVProgressHUD setForegroundColor:[UIColor colorWithRGB:0x0000dd]];
    [SVProgressHUD setForegroundColor:colorWithRGB(0x0000dd)];
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
}


+(void)showSuccessWithTitle:(NSString *)title success:(void(^)(void))successBlock {
    [SVProgressHUD showSuccessWithStatus:title];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
//    [SVProgressHUD setForegroundColor:[UIColor colorWithRGB:0x0000dd]];
    [SVProgressHUD setForegroundColor:colorWithRGB(0x0000dd)];
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        if (successBlock) {
            successBlock();
        }
    });
}

+(void)showFailureWithTitle:(NSString *)title success:(void(^)(void))failureBlock {
    [SVProgressHUD showErrorWithStatus:title];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeCustom];
//    [SVProgressHUD setForegroundColor:[UIColor colorWithRGB:0x0000dd]];
    [SVProgressHUD setForegroundColor:colorWithRGB(0x0000dd)];
    [SVProgressHUD setBackgroundColor:[UIColor whiteColor]];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
        if (failureBlock) {
            failureBlock();
        }
    });
}

@end
