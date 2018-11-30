//
//  MineCartCell.m
//  ONLY
//
//  Created by 上海点硕 on 2017/2/13.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineCartCell.h"

@implementation MineCartCell

- (void)awakeFromNib {
    [super awakeFromNib];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
   
}

- (IBAction)addBtn:(id)sender {
   
    if (self.AddBlock) {
        
        self.AddBlock();
    }

}


- (IBAction)reduceBtn:(id)sender {

    if (self.ReduceBlock) {
        
        self.ReduceBlock();
    }
    
}

@end
