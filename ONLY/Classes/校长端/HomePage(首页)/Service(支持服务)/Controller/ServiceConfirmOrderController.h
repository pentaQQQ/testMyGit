//
//  ServiceConfirmOrderController.h
//  ONLY
//
//  Created by Dylan on 08/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServiceItem.h"
#import "ServiceManItem.h"
@interface ServiceConfirmOrderController : UIViewController
@property(nonatomic,strong)ServiceItem * serviceItem;
@property(nonatomic,strong)ServiceManItem * manItem;
@property(nonatomic,strong)NSString * selectedActivityDate;
@end

