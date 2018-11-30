//
//  CompetitionEnrollCell_1.m
//  ONLY
//
//  Created by Dylan on 16/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "CompetitionEnrollCell_1.h"
@interface CompetitionEnrollCell_1 ()<UITextViewDelegate,UITextFieldDelegate>

@end

@implementation CompetitionEnrollCell_1

- (void)awakeFromNib {
    [super awakeFromNib];
    self.overviewTV.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.headImageView.layer.cornerRadius = self.headImageView.size.height/2;
    self.headImageView.layer.masksToBounds = YES;
    
    
    self.phoneTF.keyboardType = UIKeyboardTypeNumberPad;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

-(void)setImage:(UIImage *)image{
    _image = image;
    
    if (image) {
        
        self.headImageView.image = image;
        
    }
}

- (IBAction)btnClicked:(UIButton *)sender {
    if (self.chooseHeadImage_block) {
        self.chooseHeadImage_block();
    }
}

-(void)textFieldDidChange:(NSNotification * )noti{
    NSLog(@"%@",noti);
    UITextField * tf = noti.object;
    if (tf.tag == 1) {
        if (self.name_block) {
            self.name_block(tf.text);
        }
    }else if (tf.tag == 2){
        if (self.phoneNum_block) {
            self.phoneNum_block(tf.text);
        }
    }
}

- (void)textViewDidChange:(UITextView *)textView
{
    
    UITableView *tableView = [self tableView];
    [tableView beginUpdates];
    [tableView endUpdates];
    
    if (self.brief_block) {
        self.brief_block(textView.text);
    }
    
    
    
    
    
//    CGRect bounds = textView.bounds;
    // 计算 text view 的高度
    
//    CGSize maxSize = CGSizeMake(bounds.size.width, CGFLOAT_MAX);
//    CGSize newSize = [textView sizeThatFits:maxSize];
//    
//    bounds.size = newSize;
//    NSLog(@"%@",NSStringFromCGRect(bounds));
    
    
//    if (bounds.size.height >67.5) {
//        textView.bounds = bounds;
//        UITableView *tableView = [self tableView];
//        [tableView beginUpdates];
//        [tableView endUpdates];
//        
//        textView.scrollEnabled = YES;
//        [textView setContentOffset:CGPointMake(0.f,textView.contentSize.height-textView.frame.size.height)];
//        
//    }else{
//        textView.scrollEnabled = NO;
//        
////        textView.bounds = bounds;
//        UITableView *tableView = [self tableView];
//        [tableView beginUpdates];
//        [tableView endUpdates];
//        
//    }
    
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
