//
//  CommentInputView.m
//  ONLY
//
//  Created by Dylan on 13/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "CommentInputView.h"

@interface CommentInputView()
@property (weak, nonatomic) IBOutlet UITextView *commentTV;

@end

@implementation CommentInputView

- (void)show{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    self.alpha = 0;
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        [self.commentTV becomeFirstResponder];
    }];
}
-(void)dismiss{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self.commentTV resignFirstResponder];
        [weakSelf removeFromSuperview];
    }];
}

- (IBAction)btnClicked:(UIButton *)sender {
    
    if (sender.tag == 1) {
        [self dismiss];
    }else if (sender.tag == 2){
        [self dismiss];
    }else if (sender.tag == 3){//提交
        
    }
}


@end
