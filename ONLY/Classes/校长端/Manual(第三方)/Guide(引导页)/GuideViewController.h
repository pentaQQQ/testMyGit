//
//  GuideViewController.h
//  Choose
//
//  Created by George on 16/11/11.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CALayer+Transition.h"

@interface GuideViewController : UIViewController

@property (nonatomic, copy) void(^lookButtonBlock)(void);          // 先去逛逛的按钮点击事件
@property (nonatomic, copy) void(^loginButtonBlock)(void);          // 登录按钮的点击事件

-(instancetype)initWithMainController:(UIViewController *)mainController loginController:(UIViewController *)loginController;

@end
