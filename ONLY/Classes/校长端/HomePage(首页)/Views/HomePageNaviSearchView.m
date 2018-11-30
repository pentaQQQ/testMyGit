//
//  HomePageNaviSearchView.m
//  ONLY
//
//  Created by Dylan on 12/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "HomePageNaviSearchView.h"
#import "PopoverView.h"
@implementation HomePageNaviSearchView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.bgView.layer.cornerRadius = self.bgView.height/2;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:CGRectMake(0, 0, self.superview.bounds.size.width, self.superview.bounds.size.height)];
}
- (IBAction)btnClick:(UIButton *)sender {
    if (self.btnAction_block) {
        self.btnAction_block(sender.tag);
    }
}


@end
