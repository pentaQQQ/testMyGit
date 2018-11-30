//
//  ServerModel.h
//  ONLY
//
//  Created by 上海点硕 on 2017/2/28.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServerModel : NSObject

@property (nonatomic , copy)NSString *order_sn;
@property (nonatomic , copy)NSString *order_status;
@property (nonatomic , copy)NSString *status;
@property (nonatomic , copy)NSString *is_receive;
@property (nonatomic , copy)NSString *service_type;
@property (nonatomic , copy)NSString *service_type_name;
@property (nonatomic , copy)NSString *service_name;
@property (nonatomic , copy)NSString *order_amount;
@property (nonatomic , copy)NSString *pay_type;// 好像没有
@property (nonatomic , copy)NSString *member_name;
@property (nonatomic , copy)NSString *sex;
@property (nonatomic , copy)NSString *service_count;
@property (nonatomic , copy)NSString *level_name;
@property (nonatomic , copy)NSString *customer_service_phone;
@property (nonatomic , copy)NSString *start_date; //= 2017-02-01,
@property (nonatomic , copy)NSString *end_date; //= 2017-02-28,
@property (nonatomic , copy)NSString *support_time; //= 2017-02-01 - 2017-02-28,
@property (nonatomic , copy)NSString *address ;//= 11,
@property (nonatomic , copy)NSString *service_address ;//= 湖南省 湘潭市 雨湖区,
@property (nonatomic , copy)NSString *service_id;
@property (nonatomic , copy)NSString *expire_time;

@end
