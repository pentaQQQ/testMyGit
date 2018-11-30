//
//  UUIInputView.m
//  ISWorldCollege
//
//  Created by George on 16/10/28.
//  Copyright © 2016年 IdeaSource. All rights reserved.
//

#import "UUIInputView.h"


@interface UUIInputView ()<UITextViewDelegate>
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UILabel *limitLabel;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *sureButton;

//字体颜色
@property (nonatomic, strong) UIColor *titleTextColor;
@property (nonatomic, strong) UIColor *textViewTextColor;
@property (nonatomic, strong) UIColor *tipTextColor;
@property (nonatomic, strong) UIColor *cancelTitleColor;
@property (nonatomic, strong) UIColor *sureTitleColor;
@property (nonatomic, strong) UIColor *sureEnableBackgroundColor;
@property (nonatomic, strong) UIColor *sureDisableBackgroundColor;

//字体大小
@property (nonatomic, strong) UIFont *titleTextFont;
@property (nonatomic, strong) UIFont *textViewTextFont;
@property (nonatomic, strong) UIFont *tipTextFont;
@property (nonatomic, strong) UIFont *buttonTitleFont;

//输入完成后的block的回调
@property (nonatomic, copy  ) void (^inputComplete)(NSString *inputStr);

@end

@implementation UUIInputView


-(instancetype)init {
    self = [super init];
    if (self) {
        [self setFrame:[UIScreen mainScreen].bounds];
        
    }
    return self;
}


-(void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    
//    [self initlizer];
//    
//    [self addBlackView];

//    [self addSubviews];
}


-(void)initlizer {
    self.inputLimit = 20;

    
    self.titleTextColor = colorWithRGB(0x000000);
    self.textViewTextColor = colorWithRGB(0x333333);
    self.tipTextColor = colorWithRGB(0xB3B3B3);
    self.cancelTitleColor = colorWithRGB(0xB3B3B3);
    self.sureTitleColor = colorWithRGB(0xffffff);
    self.sureEnableBackgroundColor = colorWithRGB(0x43C877);
    self.sureDisableBackgroundColor = colorWithRGB(0xA3A3A3);
    
    self.titleTextFont = font(14);
    self.textViewTextFont = font(16);
    self.tipTextFont = font(10);
    self.buttonTitleFont = font(14);
    
    _titleLabel = [UILabel new];
    _textView = [UITextView new];
    _tipLabel = [UILabel new];
    _limitLabel = [UILabel new];
    _cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //_sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
}

#pragma mark - 黑色半透明层
-(void)addBlackView {
    UIView *blackView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    blackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    [self insertSubview:blackView atIndex:0];
    
    [blackView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        [self dismiss];
    }];
}

#pragma mark - 添加子视图
-(void)addSubviews {
    
    UITextField *textField = [UITextField new];
    [textField becomeFirstResponder];
    [self addSubview:textField];
    
    
    UIView *whiteBG = [UIView new];
    whiteBG.backgroundColor = [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    whiteBG.frame = CGRectMake(0, 0, 0, 160);
    textField.inputAccessoryView = whiteBG;
    
//    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(20, 100, 280, 60)];
//    self.textView.backgroundColor = [UIColor redColor];
//    [self.textView becomeFirstResponder];
//    textField.inputAccessoryView = self.textView;
    
    
    [whiteBG addSubview:_titleLabel];
    [whiteBG addSubview:_textView];
    [whiteBG addSubview:_tipLabel];
    [whiteBG addSubview:_limitLabel];
    [whiteBG addSubview:_cancelButton];
    [whiteBG addSubview:self.sureButton];
    
    //布局
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(whiteBG).insets(UIEdgeInsetsMake(0, 20, 0, 20));
        make.top.equalTo(whiteBG).offset(13);
    }];
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(whiteBG).insets(UIEdgeInsetsMake(0, 14, 0, 14));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(11);
        make.bottom.equalTo(self.cancelButton.mas_top).offset(-6);
    }];
    
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(whiteBG).offset(25);
        make.bottom.equalTo(self.cancelButton.mas_top).offset(-16);
    }];
    
    [_limitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tipLabel.mas_right).offset(10);
        make.right.equalTo(whiteBG.mas_right).offset(-21);
        make.centerY.equalTo(self.tipLabel);
    }];
    
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(56, 24));
        make.right.equalTo(self.sureButton.mas_left).offset(-8);
        make.bottom.equalTo(whiteBG.mas_bottom).offset(-6);
    }];
    
    [_sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(56, 24));
        make.right.equalTo(self.textView.mas_right);
        make.bottom.equalTo(whiteBG.mas_bottom).offset(-6);
    }];
    
    
    self.titleLabel.font = self.titleTextFont;
    self.titleLabel.textColor = self.titleTextColor;
    self.textView.font = self.textViewTextFont;
    self.textView.textColor = self.textViewTextColor;
    self.textView.delegate = self;
    [self.textView becomeFirstResponder];
    self.tipLabel.font = self.tipTextFont;
    self.tipLabel.textColor = self.tipTextColor;
    self.limitLabel.font = self.tipTextFont;
    self.limitLabel.textColor = self.tipTextColor;
    self.cancelButton.titleLabel.font = self.buttonTitleFont;
    [self.cancelButton setTitleColor:self.cancelTitleColor forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    self.sureButton.titleLabel.font = self.buttonTitleFont;
    [self.sureButton setTitleColor:self.sureTitleColor forState:UIControlStateNormal];
    [self.sureButton jk_setBackgroundColor:self.sureEnableBackgroundColor forState:UIControlStateNormal];
    [self.sureButton jk_setBackgroundColor:self.sureDisableBackgroundColor forState:UIControlStateDisabled];
    [self.sureButton addTarget:self action:@selector(handleSureButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.sureButton.enabled = NO;
    
    self.titleLabel.text = self.title; //@"请输入英文名";
//    self.tipLabel.text = @"2-20个英文单词，支持英文、数字、“_”"; // @"2-20个中文字，支持中文、英文、数字、“_”和减号";
//    self.limitLabel.text = @"20";
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [self.sureButton setTitle:@"确认" forState:UIControlStateNormal];
    
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(UIButton *)sureButton {
    if (!_sureButton) {
        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _sureButton;
}

-(void)setTitle:(NSString *)title {
    
    _title = title;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //   self.titleLabel.text = title;
        //[self.textView jk_addPlaceHolder:@"反馈内容"];
        [self.textView becomeFirstResponder];
    });
}

-(void)setEname:(NSString *)Ename {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.textView.text = Ename;
        [self.textView becomeFirstResponder];
    });
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
        
    } else {
//        if ([text isEqualToString:@""]) {
//            return YES;
//        } else if (textView.text.length + text.length > 20) {
//            return NO;
//        } else {
            return YES;
//        }
    }
}

-(void)textViewDidChange:(UITextView *)textView {
    
//    if (textView.text.length > 20) {
//        textView.text = [textView.text substringToIndex:20];
//    }
    //    self.limitLabel.text = [NSString stringWithFormat:@"%ld/%ld", textView.text.length ,(long)self.inputLimit];
//    self.limitLabel.text = [NSString stringWithFormat:@"%ld", self.inputLimit-textView.text.length];
    if (textView.text.length >= 2) {
        self.sureButton.enabled = YES;
    } else {
        self.sureButton.enabled = NO;
    }
}

-(void)inputDidFinished:(void (^)(NSString *inputStr))completeBlock {
    self.inputComplete = completeBlock;
}

-(void)handleSureButtonClicked:(UIButton *)button {
    if (self.inputComplete) {
        self.inputComplete(self.textView.text);
    }
    [self dismiss];
}



-(void)show {
    
    [self initlizer];
    
    [self addBlackView];
    
    [self addSubviews];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

-(void)dismiss {
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    [self removeFromSuperview];
}



@end
