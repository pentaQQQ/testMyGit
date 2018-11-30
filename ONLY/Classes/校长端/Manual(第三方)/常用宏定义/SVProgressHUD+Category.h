//
//  SVProgressHUD+Category.h
//  DaoShengMedical
//
//  Created by George on 16/6/23.
//  Copyright © 2016年 George. All rights reserved.
//

#import <SVProgressHUD/SVProgressHUD.h>

@interface SVProgressHUD (Category)

#pragma mark -  下一次更新
+(void)beginLoading;
+(void)showSuccessWithTitle:(NSString *)title success:(void(^)(void))successBlock;
+(void)showFailureWithTitle:(NSString *)title success:(void(^)(void))failureBlock;

@end
