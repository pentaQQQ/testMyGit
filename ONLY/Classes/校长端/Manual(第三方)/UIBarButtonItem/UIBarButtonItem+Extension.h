//
//  UIBarButtonItem+Extension.h
//  InnoSpace
//
//  Created by zfd on 16/5/26.
//  Copyright © 2016年 zfd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^buttonBlock)();

@interface UIBarButtonItem (Extension)

/**
 * 配置一个图片按钮的未选中和选中状态的方法
 */
+ (UIBarButtonItem *) itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage;

/**
 * 配置UIBarButtonItem,文字
 */
+(UIBarButtonItem *)itemWithframe:(CGRect) frame Title:(NSString *)title bgColor:(UIColor*) bgColor textColor:(UIColor*) textColor font:(CGFloat) font TextAlignment:(NSTextAlignment) TextAlignment Target:(id)target Action:(SEL)action;

/**
 * 配置UIBarButtonItem，文字,边距
 */
+(UIBarButtonItem *)itemWithframe:(CGRect) frame Title:(NSString *)title leftEdge:(CGFloat)leftEdge bgColor:(UIColor*) bgColor textColor:(UIColor*) textColor font:(CGFloat) font TextAlignment:(NSTextAlignment) TextAlignment Target:(id)target Action:(SEL)action;

/**
 * UIBarButtonSystemItemFixedSpace
 */
+(UIBarButtonItem*) itemFixedSpace;

/**
 *  UIBarButtonSystemItemFixedSpace
 */
+(UIBarButtonItem*) itemFixedSpace:(NSInteger) space;

@end
