//
//  ChooseCountView.m
//  ONLY
//
//  Created by Dylan on 17/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "ChooseCountView.h"

@implementation ChooseCountView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.subtractionBtn.layer.borderWidth = 1.0f;
    self.subtractionBtn.layer.borderColor = colorWithRGB(0xCCCCCC).CGColor;
    self.additionBtn.layer.borderWidth = 1.0f;
    self.additionBtn.layer.borderColor = colorWithRGB(0xCCCCCC).CGColor;
    self.currentCountTV.layer.borderWidth = 1.0f;
    self.currentCountTV.layer.borderColor = colorWithRGB(0xCCCCCC).CGColor;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)setItem:(CrowdFundItem *)item{
    _item = item;
    self.num = 0 ;
    self.startNum = [item.start_num integerValue];
    self.baseNum = self.startNum;
    [self refreshViewData];
    
    self.titleLabel.text = @"选择数量";
    self.nameLabel.text = item.good_name;
    self.priceLabel.text = item.unit_price;
    [self.photoIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,item.picture]]];
    
}

- (void)show{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    
   
    self.contentViewBottomConstraint.constant = -self.contentView.height;
    [self layoutIfNeeded];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.bgBtn.backgroundColor = colorWithRGBA(0x000000, 0.67);
        self.contentViewBottomConstraint.constant = 0;
        [self layoutIfNeeded];
        
    } completion:^(BOOL finished) {
        
    }];
    
}
-(void)dismiss{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        self.bgBtn.backgroundColor = colorWithRGBA(0x000000, 0.0);
        self.contentViewBottomConstraint.constant = -self.contentView.height;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        
        [weakSelf removeFromSuperview];
    }];
}
- (IBAction)cancelBtnClicked:(UIButton *)sender {
    [self dismiss];
}

- (IBAction)btnClicked:(UIButton *)sender {
    if (sender.tag == 1) {//减
        [self subtraction];
        [self refreshViewData];
    }else if (sender.tag == 2){//加
        [self addition];
        [self refreshViewData];
    }else if (sender.tag == 3){//确认
        NSInteger count = [self.currentCountTV.text integerValue];
        if (count < self.startNum) {
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"数量小于起购量，无法下单" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        if ((count%self.baseNum)!=0) {
            
            UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"提示" message:[NSString stringWithFormat:@"数量需为 %ld 整数倍",(long)self.baseNum] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            return;
        }
        
        [self dismiss];
        if (self.btnAction_block) {
            self.btnAction_block([self.currentCountTV.text integerValue]);
        }
        
    }
}


-(void)subtraction{
    if (self.num > 0) {
        self.num--;
        if (self.num == 0) {
            self.subtractionBtn.userInteractionEnabled = NO;
        }
    }
}

-(void)addition{
    self.num++;
    if (self.num > 0) {
        self.subtractionBtn.userInteractionEnabled = YES;
    }
}

-(void)refreshViewData{
    self.currentCountTV.text = [NSString stringWithFormat:@"%ld",(long)(self.num*self.baseNum+self.startNum)];
}

- (void)textViewDidChange:(UITextView *)textView{
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)keyboardWillShow:(NSNotification *)notification{
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat height = keyboardFrame.size.height;
    self.contentViewBottomConstraint.constant = height;
    [self layoutIfNeeded];
}
- (void)keyboardWillHide:(NSNotification *)notification {
    self.contentViewBottomConstraint.constant = 0;
    [self layoutIfNeeded];
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
