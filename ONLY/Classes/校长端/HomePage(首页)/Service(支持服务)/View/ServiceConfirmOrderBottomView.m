//
//  ServiceConfirmOrderBottomView.m
//  ONLY
//
//  Created by Dylan on 09/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "ServiceConfirmOrderBottomView.h"

@implementation ServiceConfirmOrderBottomView

-(void)setServiceManItem:(ServiceManItem *)serviceManItem{
    _serviceManItem = serviceManItem;
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@(不含差旅费)",serviceManItem.service_price];
}
- (IBAction)btnClicked:(UIButton *)sender {
    if (self.btnAction_block) {
        self.btnAction_block(sender.tag);
    }
}


@end
