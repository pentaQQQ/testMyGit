//
//  CBLSelectView.m
//  Choose
//
//  Created by 上海点硕 on 2016/12/1.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import "CBLSelectView.h"

@implementation CBLSelectView

- (instancetype)initWithTitle:(NSArray *)titleArr setFrame:(CGRect)frame setIndex:(NSArray *)boolArray
{
    if (self = [super init]) {
        self.frame = frame;
        self.backgroundColor = colorWithRGB(0x00A9EB);
        [self makeUI:titleArr setIndex:boolArray];
        
    }
    
    return self;
}

- (void)makeUI :(NSArray *)arr setIndex:(NSArray *)boolArray

{
    //3个按钮的创建
    self.teachBtn = [UIButton new];
    self.classBtn = [UIButton new];
    self.pinglunBtn = [UIButton new];
    self.receiveBtn = [UIButton new];
    self.discussBtn = [UIButton new];
    
    [self addSubview:self.teachBtn];
    [self addSubview:self.pinglunBtn];
    [self addSubview:self.classBtn];
    [self addSubview:self.receiveBtn];
    [self addSubview:self.discussBtn];
    
    self.teachBtn.sd_layout.leftSpaceToView(self,0).topSpaceToView(self,0).widthIs(SCREEN_WIDTH/5).heightIs(44);
    self.classBtn.sd_layout.leftSpaceToView(self,SCREEN_WIDTH/5).topSpaceToView(self,0).widthIs(SCREEN_WIDTH/5).heightIs(44);
    self.pinglunBtn.sd_layout.leftSpaceToView(self,SCREEN_WIDTH*2/5).topSpaceToView(self,0).widthIs(SCREEN_WIDTH/5).heightIs(44);
    self.receiveBtn.sd_layout.leftSpaceToView(self,SCREEN_WIDTH*3/5).topSpaceToView(self,0).widthIs(SCREEN_WIDTH/5).heightIs(44);
    self.discussBtn.sd_layout.leftSpaceToView(self,SCREEN_WIDTH*4/5).topSpaceToView(self,0).widthIs(SCREEN_WIDTH/5).heightIs(44);
    
    [self.teachBtn setTitle:arr[0] forState:UIControlStateNormal];
    [self.classBtn setTitle:arr[1] forState:UIControlStateNormal];
    [self.pinglunBtn setTitle:arr[2] forState:UIControlStateNormal];
    [self.receiveBtn setTitle:arr[3] forState:UIControlStateNormal];
    [self.discussBtn setTitle:arr[4] forState:UIControlStateNormal];
    
    self.teachBtn.selected = [boolArray[0] integerValue];
    self.classBtn.selected = [boolArray[1] integerValue];
    self.pinglunBtn.selected = [boolArray[2] integerValue];
    self.receiveBtn.selected = [boolArray[3] integerValue];
    self.discussBtn.selected = [boolArray[4] integerValue];
    
    
    self.teachBtn.titleLabel.font = font(14);
    self.pinglunBtn.titleLabel.font = font(14);
    self.classBtn.titleLabel.font = font(14);
    self.receiveBtn.titleLabel.font = font(14);
    self.discussBtn.titleLabel.font = font(14);
    
    
    self.line1 = [UIView new];
    self.line2 = [UIView new];
    self.line3 = [UIView new];
    self.line4 = [UIView new];
    self.line5 = [UIView new];
    
    [self.teachBtn addSubview:self.line1];
    [self.classBtn addSubview:self.line2];
    [self.pinglunBtn addSubview:self.line3];
    [self.receiveBtn addSubview:self.line4];
    [self.discussBtn addSubview:self.line5];
    
    if(self.teachBtn.selected ==YES)
    {
    [self.teachBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
     self.line1.backgroundColor = WhiteColor;
    }
    else
    {
     [self.teachBtn setTitleColor:colorWithRGB(0xBFDDE9) forState:UIControlStateNormal];
     self.line1.backgroundColor = colorWithRGBA(0xFFFFFF, 0);
    }
    if(self.classBtn.selected ==YES)
    {
        [self.classBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        self.line2.backgroundColor = WhiteColor;
    }
    else
    {
        [self.classBtn setTitleColor:colorWithRGB(0xBFDDE9) forState:UIControlStateNormal];
        self.line2.backgroundColor = colorWithRGBA(0xFFFFFF, 0);
    
    }
    if(self.pinglunBtn.selected ==YES)
    {
        [self.pinglunBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        self.line3.backgroundColor = WhiteColor;
    }
    else
    {
    [self.pinglunBtn setTitleColor:colorWithRGB(0xBFDDE9) forState:UIControlStateNormal];
    self.line3.backgroundColor = colorWithRGBA(0xFFFFFF, 0);
    }
    if(self.receiveBtn.selected ==YES)
    {
        [self.receiveBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        self.line4.backgroundColor = WhiteColor;
    }
    else
    {
     [self.receiveBtn setTitleColor:colorWithRGB(0xBFDDE9) forState:UIControlStateNormal];
        self.line4.backgroundColor = colorWithRGBA(0xFFFFFF, 0);
    }
    if(self.discussBtn.selected ==YES)
    {
        [self.discussBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        self.line5.backgroundColor = WhiteColor;
    }
    else
    {
       [self.discussBtn setTitleColor:colorWithRGB(0xBFDDE9) forState:UIControlStateNormal];
        self.line5.backgroundColor = colorWithRGBA(0xFFFFFF, 0);
    }
    
    self.line1.sd_layout.leftSpaceToView(self.teachBtn,10).rightSpaceToView(self.teachBtn,10).heightIs(2).bottomSpaceToView(self.teachBtn,0);
    self.line2.sd_layout.leftSpaceToView(self.classBtn,10).rightSpaceToView(self.classBtn,10).heightIs(2).bottomSpaceToView(self.classBtn,0);
    self.line3.sd_layout.leftSpaceToView(self.pinglunBtn,10).rightSpaceToView(self.pinglunBtn,10).heightIs(2).bottomSpaceToView(self.pinglunBtn,0);
    self.line4.sd_layout.leftSpaceToView(self.receiveBtn,10).rightSpaceToView(self.receiveBtn,10).heightIs(2).bottomSpaceToView(self.receiveBtn,0);
    self.line5.sd_layout.leftSpaceToView(self.discussBtn,10).rightSpaceToView(self.discussBtn,10).heightIs(2).bottomSpaceToView(self.discussBtn,0);
    
    [self.teachBtn addTarget:self action:@selector(teachBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.classBtn addTarget:self action:@selector(classBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.pinglunBtn addTarget:self action:@selector(pinglunBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.receiveBtn addTarget:self action:@selector(receiveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.discussBtn addTarget:self action:@selector(discussBtnClick) forControlEvents:UIControlEventTouchUpInside];

}
- (void)teachBtnClick
{
    self.teachBtn.selected = YES;
    self.classBtn.selected = NO;
    self.pinglunBtn.selected = NO;
    self.receiveBtn.selected = NO;
    self.discussBtn.selected = NO;
    
    [self.teachBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [self.classBtn setTitleColor:colorWithRGB(0xBFDDE9) forState:UIControlStateNormal];
    [self.pinglunBtn setTitleColor:colorWithRGB(0xBFDDE9) forState:UIControlStateNormal];
    [self.receiveBtn setTitleColor:colorWithRGB(0xBFDDE9) forState:UIControlStateNormal];
    [self.discussBtn setTitleColor:colorWithRGB(0xBFDDE9) forState:UIControlStateNormal];
    
    self.line1.backgroundColor = WhiteColor;
    self.line2.backgroundColor = colorWithRGBA(0xFFFFFF, 0);
    self.line3.backgroundColor = colorWithRGBA(0xFFFFFF, 0);
    self.line4.backgroundColor = colorWithRGBA(0xFFFFFF, 0);
    self.line5.backgroundColor = colorWithRGBA(0xFFFFFF, 0);
    
    [self.delegate btnClickIndex:7];
    
}
- (void)classBtnClick
{
    self.teachBtn.selected = NO;
    self.classBtn.selected = YES;
    self.pinglunBtn.selected = NO;
    self.receiveBtn.selected = NO;
    self.discussBtn.selected = NO;
    
    [self.teachBtn setTitleColor:colorWithRGB(0xBFDDE9) forState:UIControlStateNormal];
    [self.classBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [self.pinglunBtn setTitleColor:colorWithRGB(0xBFDDE9) forState:UIControlStateNormal];
    [self.receiveBtn setTitleColor:colorWithRGB(0xBFDDE9) forState:UIControlStateNormal];
    [self.discussBtn setTitleColor:colorWithRGB(0xBFDDE9) forState:UIControlStateNormal];
    
    self.line1.backgroundColor = colorWithRGBA(0xFFFFFF, 0);
    self.line2.backgroundColor = WhiteColor;
    self.line3.backgroundColor = colorWithRGBA(0xFFFFFF, 0);
    self.line4.backgroundColor = colorWithRGBA(0xFFFFFF, 0);
    self.line5.backgroundColor = colorWithRGBA(0xFFFFFF, 0);

    
    [self.delegate btnClickIndex:0];
    
}
- (void)pinglunBtnClick
{
    self.teachBtn.selected = NO;
    self.classBtn.selected = NO;
    self.pinglunBtn.selected = YES;
    self.receiveBtn.selected = NO;
    self.discussBtn.selected = NO;
    
    [self.teachBtn setTitleColor:colorWithRGB(0xBFDDE9) forState:UIControlStateNormal];
    [self.classBtn setTitleColor:colorWithRGB(0xBFDDE9) forState:UIControlStateNormal];
    [self.pinglunBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [self.receiveBtn setTitleColor:colorWithRGB(0xBFDDE9) forState:UIControlStateNormal];
    [self.discussBtn setTitleColor:colorWithRGB(0xBFDDE9) forState:UIControlStateNormal];
    
    self.line1.backgroundColor = colorWithRGBA(0xFFFFFF, 0);
    self.line2.backgroundColor = colorWithRGBA(0xFFFFFF, 0);
    self.line3.backgroundColor = WhiteColor;
    self.line4.backgroundColor = colorWithRGBA(0xFFFFFF, 0);
    self.line5.backgroundColor = colorWithRGBA(0xFFFFFF, 0);

    [self.delegate btnClickIndex:1];
    
}

- (void)receiveBtnClick
{
    self.teachBtn.selected = NO;
    self.classBtn.selected = NO;
    self.pinglunBtn.selected = NO;
    self.receiveBtn.selected = YES;
    self.discussBtn.selected = NO;
    
    [self.teachBtn setTitleColor:colorWithRGB(0xBFDDE9) forState:UIControlStateNormal];
    [self.classBtn setTitleColor:colorWithRGB(0xBFDDE9) forState:UIControlStateNormal];
    [self.pinglunBtn setTitleColor:colorWithRGB(0xBFDDE9) forState:UIControlStateNormal];
    [self.receiveBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [self.discussBtn setTitleColor:colorWithRGB(0xBFDDE9) forState:UIControlStateNormal];
    
    self.line1.backgroundColor = colorWithRGBA(0xFFFFFF, 0);
    self.line2.backgroundColor = colorWithRGBA(0xFFFFFF, 0);
    self.line3.backgroundColor = colorWithRGBA(0xFFFFFF, 0);
    self.line4.backgroundColor = WhiteColor;
    self.line5.backgroundColor = colorWithRGBA(0xFFFFFF, 0);
    
    [self.delegate btnClickIndex:2];


}

- (void)discussBtnClick
{
    self.teachBtn.selected = NO;
    self.classBtn.selected = NO;
    self.pinglunBtn.selected = NO;
    self.receiveBtn.selected = NO;
    self.discussBtn.selected = YES;
    
    [self.teachBtn setTitleColor:colorWithRGB(0xBFDDE9) forState:UIControlStateNormal];
    [self.classBtn setTitleColor:colorWithRGB(0xBFDDE9) forState:UIControlStateNormal];
    [self.pinglunBtn setTitleColor:colorWithRGB(0xBFDDE9) forState:UIControlStateNormal];
    [self.receiveBtn setTitleColor:colorWithRGB(0xBFDDE9) forState:UIControlStateNormal];
    [self.discussBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    
    self.line1.backgroundColor = colorWithRGBA(0xFFFFFF, 0);
    self.line2.backgroundColor = colorWithRGBA(0xFFFFFF, 0);
    self.line3.backgroundColor = colorWithRGBA(0xFFFFFF, 0);
    self.line4.backgroundColor = colorWithRGBA(0xFFFFFF, 0);
    self.line5.backgroundColor = WhiteColor;
    
    [self.delegate btnClickIndex:3];


}


@end
