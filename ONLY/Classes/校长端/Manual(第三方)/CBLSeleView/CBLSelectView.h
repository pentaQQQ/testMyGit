//
//  CBLSelectView.h
//  Choose
//
//  Created by 上海点硕 on 2016/12/1.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CBLSelectViewDelegate <NSObject>
- (void)btnClickIndex:(NSInteger)index;
@end

@interface CBLSelectView : UIView
@property (nonatomic,strong)UIButton *teachBtn;
@property (nonatomic,strong)UIButton *pinglunBtn;
@property (nonatomic,strong)UIButton *classBtn;
@property (nonatomic,strong)UIButton * receiveBtn;
@property (nonatomic,strong)UIButton *discussBtn;

@property (nonatomic,strong)UIView *line1;
@property (nonatomic,strong)UIView *line2;
@property (nonatomic,strong)UIView *line3;
@property (nonatomic,strong)UIView *line4;
@property (nonatomic,strong)UIView *line5;

@property (nonatomic,assign)id<CBLSelectViewDelegate>delegate;
- (instancetype)initWithTitle:(NSArray *)titleArr setFrame:(CGRect)frame  setIndex:(NSArray *)boolArray;
@end
