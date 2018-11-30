//
//  HomePageHeaderView.m
//  ONLY
//
//  Created by Dylan on 27/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "HomePageHeaderView.h"

@implementation HomePageHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, 40)];
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textColor = [UIColor lightGrayColor];
        
        [self addSubview:self.titleLabel];
        
        self.allBtn = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth()-50, 0, 50, 40)];
        self.allBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.allBtn setTitle:@"全部" forState:UIControlStateNormal];
        [self.allBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.allBtn jk_addActionHandler:^(NSInteger tag) {
            if (self.btnAction_block) {
                self.btnAction_block();
            }
        }];
        [self addSubview:self.allBtn];
    }
    
    return self;
}

@end
