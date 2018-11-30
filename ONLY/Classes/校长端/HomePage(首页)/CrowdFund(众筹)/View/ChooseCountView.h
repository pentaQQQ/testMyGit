//
//  ChooseCountView.h
//  ONLY
//
//  Created by Dylan on 17/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrowdFundItem.h"
@interface ChooseCountView : UIView <UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *bgBtn;
@property (weak, nonatomic) IBOutlet UIButton *subtractionBtn;
@property (weak, nonatomic) IBOutlet UIButton *additionBtn;

@property (weak, nonatomic) IBOutlet UIView *contentView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UITextView *currentCountTV;

@property (weak, nonatomic) IBOutlet UIImageView *photoIV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentViewBottomConstraint;
@property (nonatomic, strong) CrowdFundItem * item;

@property (nonatomic, assign) NSInteger num;//点击次数
@property (nonatomic, assign) NSInteger baseNum;
@property (nonatomic, assign) NSInteger startNum;
@property (nonatomic, copy) void (^btnAction_block)(NSInteger num);

-(void)show;
-(void)dismiss;
@end
