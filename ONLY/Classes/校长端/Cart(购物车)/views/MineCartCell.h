//
//  MineCartCell.h
//  ONLY
//
//  Created by 上海点硕 on 2017/2/13.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MineCartCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *selectedImg;
@property (weak, nonatomic) IBOutlet UIImageView *cartImg;
@property (weak, nonatomic) IBOutlet UILabel *cartTitle;
@property (weak, nonatomic) IBOutlet UILabel *cartPrice;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *reduceBtn;
@property (weak, nonatomic) IBOutlet UITextField *numText;
@property (nonatomic ,assign)BOOL isSelected;
@property (nonatomic,assign)NSInteger num;


@property (nonatomic, copy) void(^AddBlock)(void);        // 加号按钮的点击
@property (nonatomic, copy) void(^ReduceBlock)(void);     // 减号按钮的点击
@end
