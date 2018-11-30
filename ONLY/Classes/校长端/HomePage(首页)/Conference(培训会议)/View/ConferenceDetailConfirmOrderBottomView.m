//
//  ConferenceDetailConfirmOrderBottomView.m
//  ONLY
//
//  Created by Dylan on 06/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "ConferenceDetailConfirmOrderBottomView.h"

@implementation ConferenceDetailConfirmOrderBottomView

- (IBAction)btnClicked:(UIButton *)sender {
    if (self.btnAction_block) {
        self.btnAction_block(sender.tag);
    }
}

-(void)setItem:(ConferenceItem *)item{
    _item = item;
    
}
@end
