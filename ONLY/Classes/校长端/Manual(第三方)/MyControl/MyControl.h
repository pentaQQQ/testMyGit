//
//  MyControl.h
//  Choose
//
//  Created by zfd on 16/11/22.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, textAlignmentType) {
    
    textAlignmentTypeLeft    = 0,
    textAlignmentTypeRight   = 1,
    textAlignmentTypeCenter  = 2,
};

typedef NS_ENUM(NSInteger, boundingRectType) {
    
    boundingRectTypeHeight  = 0,
    boundingRectTypeWidth   = 1,
};

@interface MyControl : NSObject

@property (nonatomic,assign) textAlignmentType textAlignmentType;
@property (nonatomic,assign) boundingRectType boundingRectType;



/**
 CATextLayer类方法 －－ 工厂模式

 @param frame frame
 @param font  字体font
 @param text  text

 @return CATextLayer
 */
+(CATextLayer*) createTextlayerWithFrame:(CGRect) frame TextColor:(UIColor*) textColor Font:(float) font Text:(NSString*) text textAlignmentType:(textAlignmentType) textAlignmentType;



/**
 UILabel类方法 －－ 工厂模式(针对sd_layout)
 
 @param text               text
 @param textColor          textColor
 @param bgColor            bgColor
 @param font               font
 @param textAlignmentType  textAlignmentType
 
 @return UILabel
 */
+ (UILabel *)titleLabelWithText:(NSString *)text textColor:(UIColor*) textColor bgColor:(UIColor*)bgColor Font:(float) font TextAlignmentType:(textAlignmentType) textAlignmentType;


/**
 UILabel类方法(可定义行间距)
 
 @param text               text
 @param font               font
 @param LineSpacing        LineSpacing
 
 @return UILabel
 */
+(UILabel*)titleLabelWithFrame:(CGRect)frame Font:(float)font Text:(NSString*)text LineSpacing:(float) LineSpacing;

/**
  UILabel类方法 －－ 工厂模式

 @param frame              frame
 @param text               text
 @param textColor          textColor
 @param bgColor            bgColor
 @param font               font
 @param textAlignmentType  textAlignmentType

 @return UILabel
 */
+ (UILabel *)titleLabelWithFrame:(CGRect)frame Text:(NSString *)text textColor:(UIColor*) textColor bgColor:(UIColor*)bgColor Font:(float) font TextAlignmentType:(textAlignmentType) textAlignmentType;


/**
 * UILabel的Attribute(设置UILabel中文字的不同颜色和字体字号)
 */

/**
 设置UILabel中文字的不同颜色和字体字号

 @param text        text
 @param colorValue  需要设置的字体颜色
 @param fontValue   需要设置的字体大小
 @param range       range范围

 @return NSAttributedString
 */
+(NSAttributedString*) attributeText:(NSString*) text colorValue:(UIColor*) colorValue fontValue:(CGFloat) fontValue range:(NSRange)range;

/**
  UIButton类方法 －－ 工厂模式

 @param frame             frame
 @param title             title
 @param bgColor           bgColor
 @param titleColor        titleColor
 @param font              font
 @param textAlignmentType textAlignmentType
 @param target            target
 @param method            method

 @return UIButton
 */
+ (UIButton *)buttonWithFrame:(CGRect)frame Title:(NSString *)title bgColor:(UIColor *)bgColor titleColor:(UIColor*) titleColor Font:(float) font TextAlignmentType:(textAlignmentType) textAlignmentType target:(id)target sel:(SEL)method;


/**
 计算字符串的height和width

 @param contentStr       contentStr
 @param size             size
 @param font             font
 @param boundingRectType 宽／高

 @return CGFloat
 */
+(CGFloat) contentStr:(NSString*)contentStr boundingRectWithSize:(CGSize)size font:(CGFloat) font type:(boundingRectType) boundingRectType;





@end
