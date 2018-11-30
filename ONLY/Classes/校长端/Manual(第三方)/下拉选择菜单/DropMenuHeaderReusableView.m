//
//  DropMenuHeaderReusableView.m
//  DorpMenuView
//
//  Created by George on 16/11/18.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import "DropMenuHeaderReusableView.h"

@implementation DropMenuHeaderReusableView


-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        ({
            UILabel *label = [UILabel new];
            label.text = @"全部分类";
            label.textColor = colorWithRGB(0x666666);
            label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightRegular];
            label.frame = CGRectMake(20, 0, 100, 44);
            [self addSubview:label];
        });
        
        ({
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            [button setImage:[UIImage imageNamed:@"market_up_arrow"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(closeDropButtonClicked) forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectMake(self.frame.size.width-40, 0, 40, self.frame.size.height);
            button.tag = 20;
            [self addSubview:button];
        });
        
        self.backgroundColor = colorWithRGB(0xf7f7f7);
    }
    return self;
}

-(void)closeDropButtonClicked {
    if (self.DropMenuHeaderButtonClickedBlock) {
        self.DropMenuHeaderButtonClickedBlock();
    }
}

@end
