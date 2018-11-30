//
//  CrowdFundDetailHeadView.m
//  ONLY
//
//  Created by Dylan on 14/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "CrowdFundDetailHeadView.h"

@implementation CrowdFundDetailHeadView

- (IBAction)btnClicked:(UIButton *)sender {
    [UIView animateWithDuration:0.5 animations:^{
        self.bottomView.alpha = 0;
    } completion:^(BOOL finished) {
        self.bottomView.hidden = YES;
    }];
}

@end




