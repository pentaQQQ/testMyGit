//
//  CrowdFundBottomView.m
//  ONLY
//
//  Created by Dylan on 16/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "CrowdFundBottomView.h"

@implementation CrowdFundBottomView

-(void)awakeFromNib{
    [super awakeFromNib];
//    [self addConstraint];
    [self.followBtn jk_setImagePosition:LXMImagePositionTop spacing:3];
    [self.cartBtn jk_setImagePosition:LXMImagePositionTop spacing:3];
    
}

-(void)setItem:(CrowdFundItem *)item{
    _item = item;
    self.collectCountBGView.hidden = NO;
    self.cartCountBGView.hidden = NO;
    if ([item.focusCount integerValue]>999) {
        self.collectCountLabel.text = @"999+";
    }else if ([item.focusCount integerValue]>0){
        self.collectCountLabel.text = [NSString stringWithFormat:@"%@",item.focusCount];
    }else{
        self.collectCountBGView.hidden = YES;
    }
    
    if ([item.cartCount integerValue]>999) {
        self.cartCountLabel.text = @"999+";
    }else if ([item.cartCount integerValue]>0){
        self.cartCountLabel.text = [NSString stringWithFormat:@"%@",item.cartCount];
    }else{
        self.cartCountBGView.hidden = YES;
    }
    
    if (item.is_focused > 0) {
        self.followBtn.selected = YES;
        self.followBtn.userInteractionEnabled = NO;
    }

}


-(void)addConstraint {
    /*
     @property (weak, nonatomic) IBOutlet UIButton *bugBtn;
     @property (weak, nonatomic) IBOutlet UIButton *addBtn;
     
     @property (weak, nonatomic) IBOutlet UIButton *followBtn;
     @property (weak, nonatomic) IBOutlet UIButton *cartBtn;
     */
    
    //获取父视图
    UIView *superView = self.bugBtn.superview;
    
    
    [self.bugBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_lessThanOrEqualTo(108).priorityMedium();
        make.width.mas_greaterThanOrEqualTo(90).priorityHigh();
        make.top.bottom.equalTo(superView).insets(UIEdgeInsetsMake(10, 0, 10, 0));
        make.right.equalTo(superView).offset(-16);
    }];
    
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.centerY.equalTo(self.bugBtn);
        make.right.equalTo(self.bugBtn.mas_left).offset(-16);
    }];
    
    [self.cartBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_greaterThanOrEqualTo(80);
        make.width.mas_lessThanOrEqualTo(90);
        make.top.bottom.equalTo(superView);
        make.right.equalTo(self.addBtn.mas_left).offset(0);
    }];
    [self.followBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.cartBtn);
        make.left.top.bottom.equalTo(superView);
        make.right.equalTo(self.cartBtn.mas_left);
    }];
}

- (IBAction)btnClicked:(UIButton *)sender {
    if (self.btnAction_Block) {
        self.btnAction_Block(sender.tag);
    }
}


@end
