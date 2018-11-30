//
//  DropMenuCollectionViewCell.m
//  DorpMenuView
//
//  Created by George on 16/11/18.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import "DropMenuCollectionViewCell.h"

@implementation DropMenuCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.textLabel = ({
            UILabel *label = [UILabel new];
            label.frame = self.bounds;
            label.font = [UIFont systemFontOfSize:14 weight:UIFontWeightLight];
            label.textAlignment = NSTextAlignmentCenter;
            [self.contentView addSubview:label];
            label;
        });
    
        self.underLine = ({
            UIView *view = [UIView new];
            view.backgroundColor = [UIColor redColor];
            [self.contentView addSubview:view];
            view.frame = CGRectMake(0, self.bounds.size.height-2, self.bounds.size.width, 2);
            view;
        });
    }
    return self;
}

-(void)displaySeparator {
    ({
        UIView *line = [UIView new];
        line.backgroundColor = colorWithRGB(0xe6e6e6);
        [self.contentView addSubview:line];
        line.frame = CGRectMake(self.bounds.size.width-0.5, 0, 0.5, self.bounds.size.height);
    });
    
    ({
        UIView *line = [UIView new];
        line.backgroundColor = colorWithRGB(0xe6e6e6);
        [self.contentView addSubview:line];
        line.frame = CGRectMake(0, self.bounds.size.height-0.5, self.bounds.size.width, 0.5);
    });
}

@end
