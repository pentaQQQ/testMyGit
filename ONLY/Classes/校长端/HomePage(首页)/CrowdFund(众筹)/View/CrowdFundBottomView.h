//
//  CrowdFundBottomView.h
//  ONLY
//
//  Created by Dylan on 16/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrowdFundItem.h"
@interface CrowdFundBottomView : UIView
@property (weak, nonatomic) IBOutlet UIButton *bugBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *followBtn;

@property (weak, nonatomic) IBOutlet UIButton *cartBtn;
@property (weak, nonatomic) IBOutlet UIView *collectCountBGView;
@property (weak, nonatomic) IBOutlet UILabel *collectCountLabel;

@property (weak, nonatomic) IBOutlet UIView *cartCountBGView;
@property (weak, nonatomic) IBOutlet UILabel *cartCountLabel;
@property (nonatomic, copy) void (^btnAction_Block)(NSInteger index);
@property (nonatomic, strong)CrowdFundItem * item;

@end
