//
//  ServiceConfirmOrderCell_3.m
//  ONLY
//
//  Created by Dylan on 08/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "ServiceConfirmOrderCell_3.h"
@interface ServiceConfirmOrderCell_3 ()<UITextViewDelegate>

@end
@implementation ServiceConfirmOrderCell_3

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentTV.textContainerInset = UIEdgeInsetsZero;
    
    
}
- (void)textViewDidChange:(UITextView *)textView
{
//    CGRect bounds = textView.bounds;
//    // 计算 text view 的高度
//    
//    CGSize maxSize = CGSizeMake(bounds.size.width, CGFLOAT_MAX);
//    CGSize newSize = [textView sizeThatFits:maxSize];
//   
//    bounds.size = newSize;
//    NSLog(@"%@",NSStringFromCGRect(bounds));
//    
//    
//    if (bounds.size.height >67.5) {
//        textView.bounds = bounds;
//        UITableView *tableView = [self tableView];
//        [tableView beginUpdates];
//        [tableView endUpdates];
//        
//        
//        textView.scrollEnabled = YES;
//        [textView setContentOffset:CGPointMake(0.f,textView.contentSize.height-textView.frame.size.height)];
//
//    }else{
//        textView.scrollEnabled = NO;
//        
//        textView.bounds = bounds;
//        UITableView *tableView = [self tableView];
//        [tableView beginUpdates];
//        [tableView endUpdates];
//        
//    }
    
    UITableView *tableView = [self tableView];
    [tableView beginUpdates];
    [tableView endUpdates];
//    [UIView animateWithDuration:0.5 delay:0.0 usingSpringWithDamping:0.0 initialSpringVelocity:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
//        
//        
//    } completion:^(BOOL finished) {
//        
//    }];
    
    if (textView.text.length>0) {
        self.placeHolderLabel.hidden = YES;
    }else{
        self.placeHolderLabel.hidden = NO;
    }
    if (self.textChanged_block) {
        self.textChanged_block(textView.text);
    }
}

- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}
@end
