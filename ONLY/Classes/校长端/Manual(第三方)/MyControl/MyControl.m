//
//  MyControl.m
//  Choose
//
//  Created by zfd on 16/11/22.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import "MyControl.h"
#import <CoreText/CoreText.h>

@implementation MyControl

/**
 *  CATextLayer
 */
+(CATextLayer*) createTextlayerWithFrame:(CGRect) frame TextColor:(UIColor*) textColor Font:(float) font Text:(NSString*) text textAlignmentType:(textAlignmentType) textAlignmentType
{
    CATextLayer* textLayer_positon = [CATextLayer layer];
    textLayer_positon.frame = frame;
    textLayer_positon.foregroundColor = textColor.CGColor;
    textLayer_positon.wrapped = YES;
    textLayer_positon.contentsScale = [UIScreen mainScreen].scale;
    CFStringRef fontname = (__bridge CFStringRef)([UIFont systemFontOfSize:font].fontName);
    CGFontRef fontRef = CGFontCreateWithFontName(fontname);
    textLayer_positon.font = fontRef;
    textLayer_positon.fontSize = [UIFont systemFontOfSize:font].pointSize;
    textLayer_positon.string = text;
    switch (textAlignmentType) {
        case textAlignmentTypeLeft:
            textLayer_positon.alignmentMode = kCAAlignmentLeft;
            break;
        case textAlignmentTypeRight:
            textLayer_positon.alignmentMode = kCAAlignmentRight;
            break;
        case textAlignmentTypeCenter:
            textLayer_positon.alignmentMode = kCAAlignmentCenter;
            break;
        default:
            break;
    }
    CFRelease(fontRef);
    
    return textLayer_positon;
}

/**
 *  UILabel类方法
 */
+ (UILabel *)titleLabelWithText:(NSString *)text textColor:(UIColor*) textColor bgColor:(UIColor*)bgColor Font:(float) font TextAlignmentType:(textAlignmentType) textAlignmentType
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = bgColor;
    titleLabel.textColor = textColor;
    titleLabel.text = text;
    titleLabel.font = [UIFont systemFontOfSize:font];
    
    switch (textAlignmentType)
    {
        case textAlignmentTypeLeft:
            titleLabel.textAlignment = NSTextAlignmentLeft;
            break;
        case textAlignmentTypeRight:
            titleLabel.textAlignment = NSTextAlignmentRight;
            break;
        case textAlignmentTypeCenter:
            titleLabel.textAlignment = NSTextAlignmentCenter;
            break;
            
        default:
            break;
    }
    
    return titleLabel;
}

/**
 *  UILabel类方法 
 */
+ (UILabel *)titleLabelWithFrame:(CGRect)frame Text:(NSString *)text textColor:(UIColor*) textColor bgColor:(UIColor*)bgColor Font:(float) font TextAlignmentType:(textAlignmentType) textAlignmentType
{
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.frame = frame;
    titleLabel.backgroundColor = bgColor;
    titleLabel.textColor = textColor;
    titleLabel.text = text;
    titleLabel.font = [UIFont systemFontOfSize:font];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    switch (textAlignmentType)
    {
        case textAlignmentTypeLeft:
            titleLabel.textAlignment = NSTextAlignmentLeft;
            break;
        case textAlignmentTypeRight:
            titleLabel.textAlignment = NSTextAlignmentRight;
            break;
        case textAlignmentTypeCenter:
            titleLabel.textAlignment = NSTextAlignmentCenter;
            break;
            
        default:
            break;
    }
    
    return titleLabel;
}


/**
 *  UILabel类方法(可定义行间距)
 */
+(UILabel*)titleLabelWithFrame:(CGRect)frame Font:(float)font Text:(NSString*)text LineSpacing:(float) LineSpacing
{
    UILabel*label = [[UILabel alloc]initWithFrame:frame];
    //设置字体
    label.font=[UIFont systemFontOfSize:font];
    //设置折行方式 NSLineBreakByTruncatingTail是按照单词"abcd..."
    label.lineBreakMode = NSLineBreakByTruncatingTail;
    //折行限制 0时候是不限制行数
    label.numberOfLines = 0;
    //对齐方式
    label.textAlignment = NSTextAlignmentLeft;
    //设置背景颜色
    label.backgroundColor = [UIColor clearColor];
    //设置文字
    label.text = text;
    //自适应
    //label.adjustsFontSizeToFitWidth=YES;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //调整行间距
    [paragraphStyle setLineSpacing:LineSpacing];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    label.attributedText = attributedString;
    
    [label sizeToFit];
    
    
    return label;
}

/**
 * UILabel的Attribute(设置UILabel中文字的不同颜色和字体字号)
 */
+(NSAttributedString*) attributeText:(NSString*) text colorValue:(UIColor*) colorValue fontValue:(CGFloat) fontValue range:(NSRange)range
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
    [string addAttribute:NSForegroundColorAttributeName value:colorValue range:range];
    [string addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial" size:fontValue] range:range];
    return string;
}

/**
 *  UIButton类方法
 */
+ (UIButton *)buttonWithFrame:(CGRect)frame Title:(NSString *)title bgColor:(UIColor *)bgColor titleColor:(UIColor*) titleColor Font:(float) font TextAlignmentType:(textAlignmentType) textAlignmentType target:(id)target sel:(SEL)method
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = bgColor;
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    
    switch (textAlignmentType)
    {
        case textAlignmentTypeLeft:
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            break;
        case textAlignmentTypeRight:
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
            break;
        case textAlignmentTypeCenter:
            button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
            break;
            
        default:
            break;
    }
    
    [button addTarget:target action:method forControlEvents:UIControlEventTouchUpInside];
    return button;
}



/**
 *  计算字符串的height和width
 */
+(CGFloat) contentStr:(NSString*)contentStr boundingRectWithSize:(CGSize)size font:(CGFloat) font type:(boundingRectType) boundingRectType
{
    CGRect rect = [contentStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil];
    
    switch (boundingRectType) {
        case boundingRectTypeHeight:{
             CGFloat height = rect.size.height;
             return height;
        }
            break;
        case boundingRectTypeWidth:{
             CGFloat width = rect.size.width;
             return width;
        }
            break;
        default:
            break;
    }
}




@end
