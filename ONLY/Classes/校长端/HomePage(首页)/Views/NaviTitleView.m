//
//  NaviTitleView.m
//  ONLY
//
//  Created by Dylan on 13/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "NaviTitleView.h"

@implementation NaviTitleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)btnClicked:(UIButton *)sender {
    if (self.btnAction_block) {
        self.btnAction_block();
    }
}

@end
