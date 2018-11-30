//
//  BLPopView.h
//  ONLY
//
//  Created by 上海点硕 on 2017/1/18.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BLPopView : UIView
@property(nonatomic,strong)UIView *bGView;

-(instancetype)initWithAlertViewHeight:(CGFloat)height name:(NSString *)name mudi:(NSString *)mudi time:(NSString *)time address:(NSString *)address;

- (void)show:(BOOL)animated;

- (void)hide:(BOOL)animated;
@end
