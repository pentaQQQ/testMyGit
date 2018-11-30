//
//  UIBarButtonItem+Extension.m
//  InnoSpace
//
//  Created by zfd on 16/5/26.
//  Copyright © 2016年 zfd. All rights reserved.
//  BarButtonItem

#import "UIBarButtonItem+Extension.h"
#import <objc/runtime.h>


@implementation UIBarButtonItem (Extension)

/**
 *  创建一个item
 *
 *  @param target    点击item后调用哪个对象的方法
 *  @param action    点击item后调用target的哪个方法
 *  @param image     图片
 *  @param highImage 高亮的图片
 *
 *  @return 创建完的item
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target action:(SEL)action image:(NSString *)image highImage:(NSString *)highImage
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    // 设置图片
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    // 设置尺寸
    //btn.size = btn.currentImage.size;
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

/**
 *  创建一个item
 *
 *  @param frame         frame
 *  @param title         title
 *  @param bgColor       背景颜色
 *  @param textColor     字体颜色
 *  @param font          字体大小
 *  @param TextAlignment 位置
 *  @param target        target
 *  @param action        action
 *
 *  @return UIBarButtonItem
 */
+(UIBarButtonItem *)itemWithframe:(CGRect) frame Title:(NSString *)title bgColor:(UIColor*) bgColor textColor:(UIColor*) textColor font:(CGFloat) font TextAlignment:(NSTextAlignment) TextAlignment Target:(id)target Action:(SEL)action
{
   return [self itemWithframe:frame Title:title leftEdge:12 bgColor:bgColor textColor:textColor font:font TextAlignment:TextAlignment Target:target Action:action];
}

/**
 *  创建一个item
 *
 *  @param frame         frame
 *  @param title         title
 *  @param leftEdge      距离左边的距离
 *  @param bgColor       背景颜色
 *  @param textColor     字体颜色
 *  @param font          字体大小
 *  @param TextAlignment 位置
 *  @param target        target
 *  @param action        action
 *
 *  @return UIBarButtonItem
 */
+(UIBarButtonItem *)itemWithframe:(CGRect) frame Title:(NSString *)title leftEdge:(CGFloat)leftEdge bgColor:(UIColor*) bgColor textColor:(UIColor*) textColor font:(CGFloat) font TextAlignment:(NSTextAlignment) TextAlignment Target:(id)target Action:(SEL)action
{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    btn.frame = frame;
    btn.backgroundColor = bgColor;
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, leftEdge, 0, 0)];
    
    if (TextAlignment == NSTextAlignmentLeft)
    {
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    }
    else if (TextAlignment == NSTextAlignmentRight)
    {
         btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }
    else
    {
         btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

/**
 *  UIBarButtonSystemItemFixedSpace
 *
 *  @return UIBarButtonItem
 */
+(UIBarButtonItem*) itemFixedSpace
{
    return [self itemFixedSpace:-15];
}

/**
 *  UIBarButtonSystemItemFixedSpace
 *
 *  @param space 边距的距离
 *
 *  @return UIBarButtonItem
 */
+(UIBarButtonItem*) itemFixedSpace:(NSInteger) space
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem : UIBarButtonSystemItemFixedSpace target : nil action : nil ];
    negativeSpacer. width = space ;
    return negativeSpacer;
}












@end
