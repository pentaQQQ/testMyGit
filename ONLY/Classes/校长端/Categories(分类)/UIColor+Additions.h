//
//  UIColor+Additions.h
//  InnoSpace
//
//  Created by zfd on 16/5/26.
//  Copyright © 2016年 zfd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Additions)

+ (UIColor *)colorWithRGB:(int)rgb;
+ (UIColor *)colorWithRGB:(int)rgb alpha:(CGFloat)alpha;
+ (UIColor *)colorWithHexString:(NSString *)hexString;

+ (UIColor *)colorWithRGB:(NSUInteger)r green:(NSInteger)g blue:(NSUInteger)b;
+ (UIColor *)colorWithRGB:(NSUInteger)r green:(NSInteger)g blue:(NSUInteger)b alpha:(CGFloat)a;

@end
