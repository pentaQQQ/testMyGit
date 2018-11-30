//
//  MineAddressCell.m
//  ONLY
//
//  Created by 上海点硕 on 2017/2/9.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineAddressCell.h"

@implementation MineAddressCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}


//设置为默认地址
- (IBAction)selectedClick:(id)sender {
    if (self.defaultAddressBlock) {
        self.defaultAddressBlock();
    }
}

//编辑收获地址按钮
- (IBAction)edutBtnClick:(id)sender {
    if (self.editAddressBlock) {
        
        self.editAddressBlock();
    }
}


//删除收货地址
- (IBAction)deletedBtnClick:(id)sender {
    if (self.deleteAddressBlock) {
        
        self.deleteAddressBlock();
    }
}

@end
