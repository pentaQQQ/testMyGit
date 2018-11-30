//
//  MineAddressCell.h
//  ONLY
//
//  Created by 上海点硕 on 2017/2/9.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineAddressCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *namePhone;
@property (weak, nonatomic) IBOutlet UILabel *detailAddress;
@property (weak, nonatomic) IBOutlet UIImageView *selectedImg;

@property (weak, nonatomic) IBOutlet UIButton *selectedBtn;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@property (weak, nonatomic) IBOutlet UIButton *deletedBtn;

@property (nonatomic, copy) void(^defaultAddressBlock)(void);          // 设置默认地址的回调事件
@property (nonatomic, copy) void(^editAddressBlock)(void);          // 编辑默认地址的回调事件
@property (nonatomic, copy) void(^deleteAddressBlock)(void);          // 删除默认地址的回调事件

@end
