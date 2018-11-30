//
//  BaseTabBarController.h
//  ONLY
//
//  Created by 上海点硕 on 2016/12/17.
//  Copyright © 2016年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddViewController.h"
#import "HomePageController.h"
#import "NewsViewController.h"
#import "MineViewController.h"
#import "CartViewController.h"
#import "BaseNavigationController.h"
#import "CYLTabBarController.h"

@interface BaseTabBarController : CYLTabBarController

@property (nonatomic , strong)CYLTabBarController *tabBarController;

@end
