//
//  BLPopView.m
//  ONLY
//
//  Created by 上海点硕 on 2017/1/18.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "BLPopView.h"

@implementation BLPopView

-(instancetype)initWithAlertViewHeight:(CGFloat)height name:(NSString *)name mudi:(NSString *)mudi time:(NSString *)time address:(NSString *)address
{
    self=[super init];
    if (self) {
        if (self.bGView==nil) {
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT)];
            view.backgroundColor = [UIColor blackColor];
            view.alpha = 0.5;
            
            [[UIApplication sharedApplication].keyWindow addSubview:view];
            self.bGView =view;
        }
        
        self.frame = CGRectMake(15*SCREEN_PRESENT,98*SCREEN_PRESENT,344*SCREEN_PRESENT,429*SCREEN_PRESENT);
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
        //中间弹框的view
        UIView *popView = [[UIView alloc] initWithFrame:CGRectMake(0,0,344*SCREEN_PRESENT,429*SCREEN_PRESENT)];
        popView.backgroundColor = [UIColor whiteColor];
        cornerRadiusView(popView, 5);
        [self addSubview:popView];
        
        UILabel *lab = [[UILabel alloc] init];
        lab.text = name;
        lab.textColor = colorWithRGB(0x333333);
        lab.font = [UIFont boldSystemFontOfSize:16];
        lab.textAlignment = NSTextAlignmentCenter;
        [popView addSubview:lab];
        lab.sd_layout.leftSpaceToView(popView,140*SCREEN_PRESENT).rightSpaceToView(popView,140*SCREEN_PRESENT).topSpaceToView(popView,23).heightIs(16);
        
        UIView *meetView =[[UIImageView alloc] init];
        meetView.backgroundColor = colorWithRGB(0x333333);
        [popView addSubview:meetView];
        meetView.alpha = 0.1;
        meetView.sd_layout.leftSpaceToView(popView,0).topSpaceToView(lab,25).rightSpaceToView(popView,0).heightIs(1);
        
        UILabel *addLabel = [UILabel new];
        addLabel.text = [NSString stringWithFormat:@"培训项目:%@",mudi];
        addLabel.textColor = colorWithRGB(0x333333) ;
        addLabel.font = [UIFont systemFontOfSize:14];
        [popView addSubview:addLabel];
        addLabel.textAlignment = NSTextAlignmentLeft;
        addLabel.sd_layout.leftSpaceToView(popView,34).rightSpaceToView(popView,15).topSpaceToView(meetView,24).heightIs(14);
        
        UILabel *lookLabel = [UILabel new];
        lookLabel.textColor = colorWithRGB(0x333333);
        lookLabel.text = [NSString stringWithFormat:@"培训时间:%@",time];
        lookLabel.font = [UIFont systemFontOfSize:14];
        [popView addSubview:lookLabel];
        lookLabel.textAlignment = NSTextAlignmentLeft;
        lookLabel.sd_layout.leftSpaceToView(popView,34).rightSpaceToView(popView,15).topSpaceToView(addLabel,6).heightIs(14);
        
        UILabel *addressLabel = [UILabel new];
        addressLabel.textColor = colorWithRGB(0x333333);
        addressLabel.text = [NSString stringWithFormat:@"培训地址:%@",address];
        addressLabel.font = [UIFont systemFontOfSize:14];
        [popView addSubview:addressLabel];
        addressLabel.textAlignment = NSTextAlignmentLeft;
        addressLabel.sd_layout.leftSpaceToView(popView,34).rightSpaceToView(popView,15).topSpaceToView(lookLabel,6).heightIs(14);
        
        UIImageView *codeImg = [UIImageView new];
        [popView addSubview:codeImg];
        codeImg.image = [UIImage imageNamed:@"Twocode"];
        codeImg.sd_layout.leftSpaceToView(popView,77*SCREEN_PRESENT).topSpaceToView(addressLabel,33).widthIs(192*SCREEN_PRESENT).heightIs(194);
        
        UIButton *backBtn = [UIButton new];
        [popView addSubview:backBtn];
        backBtn.sd_layout.rightSpaceToView(popView,24).topSpaceToView(popView,24).widthIs(15).heightIs(15);
        [backBtn setTitle:@"X" forState:UIControlStateNormal];
        [backBtn setTitleColor:colorWithRGB(0x999999) forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self show:YES];
        
    }
    return self;
}
-(void)buttonClick:(UIButton*)button
{
    [self hide:YES];
   
}

- (void)show:(BOOL)animated
{
    if (animated)
    {
        self.transform = CGAffineTransformScale(self.transform,0,0);
        __weak BLPopView *weakSelf = self;
        [UIView animateWithDuration:.3 animations:^{
            weakSelf.transform = CGAffineTransformScale(weakSelf.transform,1.2,1.2);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:.3 animations:^{
                weakSelf.transform = CGAffineTransformIdentity;
            }];
        }];
    }
}

- (void)hide:(BOOL)animated
{
    [self endEditing:YES];
    if (self.bGView != nil) {
        __weak BLPopView *weakSelf = self;
        
        [UIView animateWithDuration:animated ?0.3: 0 animations:^{
            weakSelf.transform = CGAffineTransformScale(weakSelf.transform,1,1);
            
        } completion:^(BOOL finished) {
            [UIView animateWithDuration: animated ?0.3: 0 animations:^{
                weakSelf.transform = CGAffineTransformScale(weakSelf.transform,0.2,0.2);
            } completion:^(BOOL finished) {
                [weakSelf.bGView removeFromSuperview];
                [weakSelf removeFromSuperview];
                weakSelf.bGView=nil;
            }];
        }];
    }
    
}

@end
