//
//  MineOrder.h
//  ONLY
//
//  Created by 上海点硕 on 2017/1/16.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineOrder : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *OrderNumCode;
@property (weak, nonatomic) IBOutlet UILabel *OrderState;
@property (weak, nonatomic) IBOutlet UILabel *OrderPrice;
@property (weak, nonatomic) IBOutlet UILabel *OrderNum;
@property (weak, nonatomic) IBOutlet UILabel *OrderPayPrice;
@property (weak, nonatomic) IBOutlet UILabel *OrderPay;

@property (weak, nonatomic) IBOutlet UILabel *OrderName;
@property (weak, nonatomic) IBOutlet UIImageView *OrderImg;

@property (weak, nonatomic) IBOutlet UIButton *OrderBtnOne;

@property (weak, nonatomic) IBOutlet UIButton *OrderBtnTwo;

@property (nonatomic, copy) void(^oneBlock)(void);        // 加号按钮的点击
@property (nonatomic, copy) void(^TwoBlock)(void);     // 减号按钮的点击
@end
