//
//  CrowdFundDetailController.h
//  ONLY
//
//  Created by Dylan on 14/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CrowdFundController.h"
#import "CrowdFundItem.h"

@interface CrowdFundDetailController : UIViewController

@property (nonatomic, assign) CrowdFundStatus status;

@property (nonatomic, strong) CrowdFundItem * item;


@end
