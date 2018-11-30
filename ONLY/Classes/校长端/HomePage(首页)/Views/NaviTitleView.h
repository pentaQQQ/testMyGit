//
//  NaviTitleView.h
//  ONLY
//
//  Created by Dylan on 13/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NaviTitleView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;

@property (nonatomic,copy)void (^btnAction_block)();

@end
