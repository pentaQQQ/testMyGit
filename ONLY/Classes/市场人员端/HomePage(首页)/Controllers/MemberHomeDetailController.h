//
//  MemberHomeDetailController.h
//  ONLY
//
//  Created by zfd on 17/1/15.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MemberBasicController.h"

@interface MemberHomeDetailController : MemberBasicController

@property (nonatomic,assign) NSInteger type; /*0: 支付成功界面  1:是否接单  3:什么都没有*/
@property (nonatomic ,copy) NSString *order_sn;
@end
