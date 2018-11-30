//
//  MineServerCell.h
//  ONLY
//
//  Created by 上海点硕 on 2017/1/19.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineServerCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *serverNum;
@property (weak, nonatomic) IBOutlet UILabel *serverStatus;
@property (weak, nonatomic) IBOutlet UILabel *serverType;
@property (weak, nonatomic) IBOutlet UILabel *Abc;
@property (weak, nonatomic) IBOutlet UIImageView *sex;
@property (weak, nonatomic) IBOutlet UILabel *range;
@property (weak, nonatomic) IBOutlet UILabel *serNum;
@property (weak, nonatomic) IBOutlet UILabel *serverPrice;
@property (weak, nonatomic) IBOutlet UIButton *serverOne;
@property (weak, nonatomic) IBOutlet UIButton *serverTwo;
@property (nonatomic, copy) void(^oneBlock)(void);        // 加号按钮的点击
@property (nonatomic, copy) void(^TwoBlock)(void);     // 减号按钮的点击
@end
