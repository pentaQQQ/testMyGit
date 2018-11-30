//
//  MBProgressHUD+Extension.h
//  Test
//
//  Created by George on 2017/1/4.
//  Copyright © 2017年 虞嘉伟. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (Extension)

//加载成功
+(void)showSuccess:(NSString *)success toView:(UIView *)view complete:(dispatch_block_t)completeBlock;

//加载失败
+(void)showFailure:(NSString *)failure toView:(UIView *)view complete:(dispatch_block_t)completeBlock;
+(void)showFailure:(NSString *)failure toView:(UIView *)view;

//加载中
+(void)showLoadingToView:(UIView *)view;


@end
