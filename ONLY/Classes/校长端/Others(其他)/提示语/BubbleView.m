//
//  BubbleView.m
//  Choose
//
//  Created by George on 16/11/30.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import "BubbleView.h"


@interface BubbleView ()
{
    CGFloat baseHeight;
    CGFloat textHeight;
    CGFloat margin;
    CGFloat padding;
    NSString *title;
    
}
@property (nonatomic, strong) UILabel *tipLabel;

@end

@implementation BubbleView



-(instancetype)init {
    self = [super init];
    if (self) {
        baseHeight = 72;
        margin = 20;
        padding = 22;
    }
    return self;
}


+(instancetype)showWithText:(NSString *)text {
    
    BubbleView *bubble = [self bubbleView];
    if (bubble == nil) {
        bubble = [BubbleView new];
        bubble.frame = [UIScreen mainScreen].bounds;
        
        bubble.tipLabel = ({
            UILabel *label = [UILabel new];
            label.font = font(13);
            label.textColor = [UIColor whiteColor];
            label.textAlignment = NSTextAlignmentCenter;
            label.attributedText = [[NSAttributedString alloc] initWithString:text attributes:[bubble attributes]];
            label.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
            label.layer.cornerRadius = 5;
            label.layer.masksToBounds = YES;
            [bubble addSubview:label];
            
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(bubble);
                make.size.mas_equalTo(CGSizeMake([bubble textWidth:text].width+2*bubble->padding, bubble->baseHeight+[bubble textWidth:text].height));
            }];
            
            label;
        });
        
        UIWindow *win = [UIApplication sharedApplication].keyWindow;
        [win addSubview:bubble];
        [self dismissAfterDelay:1.5];
    }
    //重新设值并布局
    
    return bubble;
}

+(void)dismissAfterDelay:(CGFloat)delay {
    BubbleView *bubble = [self bubbleView];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [bubble removeFromSuperview];
    });
}

-(CGSize)textWidth:(NSString *)text {
    return [text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width-2*(margin+padding), 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:[self attributes] context:nil].size;
}

-(NSDictionary *)attributes {
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineSpacing = 6;
    style.alignment = NSTextAlignmentCenter;
    return @{NSFontAttributeName:font(13), NSParagraphStyleAttributeName: style};
}

+(BubbleView *)bubbleView {
    UIWindow *win = [UIApplication sharedApplication].keyWindow;
    
    for (UIView *obj in win.subviews) {
        if ([obj isKindOfClass:[BubbleView class]]) {
            return (BubbleView *)obj;
        }
    }
    return nil;
}

@end















