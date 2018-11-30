//
//  PayCenterController.h
//  ONLY
//
//  Created by Dylan on 07/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayCenterController : UIViewController
@property(nonatomic,strong)NSString * price;
@property(nonatomic,strong)NSString * endTime;//时间戳
@property(nonatomic,strong)NSString * order_sn;//订单编号

/**
 0:众筹订单
 1:培训订单
 2:支持服务订单
 */
@property(nonatomic,strong)NSString * order_type;

@end
