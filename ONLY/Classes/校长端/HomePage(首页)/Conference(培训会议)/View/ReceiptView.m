//
//  ReceiptView.m
//  ONLY
//
//  Created by Dylan on 06/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "ReceiptView.h"

@interface ReceiptView ()<UITextViewDelegate>
@property(nonatomic, strong)NSString * receiptType;//保存发票类型，公司还是个人
@end

@implementation ReceiptView
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initDefaultData];
    }
    return self;
}
- (void)setDataWithReceiptType:(NSString *)receiptTpye companyName:(NSString *)companyName identity:(NSString *)identity{
    self.receiptType = receiptTpye;
    self.companyNameTV.text = companyName;
    self.identityTV.text = identity;
    if ([receiptTpye isEqualToString:@"0"]) {
        self.personalBtn.selected = YES;
    }else if ([receiptTpye isEqualToString:@"1"]){
        self.companyBtn.selected = YES;
    }
}
- (void)show{
    
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    self.alpha = 0;

    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        [self.companyNameTV becomeFirstResponder];
    }];
}
-(void)dismiss{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self.companyNameTV resignFirstResponder];
        [weakSelf removeFromSuperview];
    }];
}




- (IBAction)btnAction:(UIButton *)sender {
    if (sender.tag == 1 || sender.tag == 2) {
        [self dismiss];
    }
    else if (sender.tag == 3){
        NSLog(@"确定");
        if (![self checkData]) {
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"请添加完整信息" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
        
        if (self.btnAction_block) {
            self.btnAction_block(sender.tag,self.companyNameTV.text,self.identityTV.text,self.receiptType);
        }
        [self dismiss];
    }
    else if (sender.tag == 4){
        NSLog(@"不要发票");
        if (self.btnAction_block) {
            self.btnAction_block(sender.tag,@"不开发票",@"",@"-1");
        }
        [self dismiss];
    }
    else if (sender.tag == 5){//个人
        self.receiptType = @"0";
        sender.selected = !sender.selected;
        if (sender.selected) {
            self.companyBtn.selected = NO;
        }
    }
    else if (sender.tag == 6){
        self.receiptType = @"1";
        sender.selected = !sender.selected;
        if (sender.selected) {
            self.personalBtn.selected = NO;
        }
    }
}

-(void)textViewDidChange:(UITextView *)textView{

    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.33 initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [self setNeedsLayout];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
    }];

}


-(BOOL)checkData{
    if ([self.receiptType isEqualToString:@"-1"]) {
        return NO;
    }else if (self.companyNameTV.text.length == 0){
        return NO;
    }else if (self.identityTV.text.length == 0){
        return NO;
    }
    return YES;
}

-(void)initDefaultData{
    self.receiptType = @"-1";
}
@end
