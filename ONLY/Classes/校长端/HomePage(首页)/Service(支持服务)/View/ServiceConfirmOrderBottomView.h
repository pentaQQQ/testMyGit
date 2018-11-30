//
//  ServiceConfirmOrderBottomView.h
//  ONLY
//
//  Created by Dylan on 09/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceManItem.h"
@interface ServiceConfirmOrderBottomView : UIView

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (nonatomic,strong) ServiceManItem * serviceManItem;
@property(nonatomic, copy) void (^btnAction_block)(NSInteger index);
@end
