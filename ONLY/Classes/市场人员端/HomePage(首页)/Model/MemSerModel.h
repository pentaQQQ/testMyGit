//
//  MemSerModel.h
//  ONLY
//
//  Created by 上海点硕 on 2017/3/24.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemSerModel : NSObject
@property (nonatomic,copy)NSString * is_receive; //= -1,
@property (nonatomic,copy)NSString * order_status; //= 3,
@property (nonatomic,copy)NSString * service_type_name; //= 市场,
@property (nonatomic,copy)NSString * member_name;// = 午餐会,
@property (nonatomic,copy)NSString * status; //= 结束服务,
@property (nonatomic,copy)NSString * service_type; //= 0,
@property (nonatomic,copy)NSString * service_name; //= 淡季活动,
@property (nonatomic,copy)NSString * contact_phone ;//= 22,
@property (nonatomic,copy)NSString * order_sn; //= 1702277894840149
@end
