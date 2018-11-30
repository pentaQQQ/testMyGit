//
//  CourseModel.h
//  ONLY
//
//  Created by 上海点硕 on 2017/3/6.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseModel : NSObject
//status = 待付款,
//order_status = 0,
//course_img = /uploads/pics/l/20170306-02-32-193.png,
//train_id = 6,
//order_amount = 1000.00,
//unit_price = 1000.00,
//customer_service_phone = 18502104324,
//person_num = 1,
//order_sn = 1702233321440988,
//course_title = 2017管理终极职称考试,
//course_id = 1

@property (nonatomic , copy)NSString *status;
@property (nonatomic , copy)NSString *order_status;
@property (nonatomic , copy)NSString *course_img;
@property (nonatomic , copy)NSString *train_id;
@property (nonatomic , copy)NSString *order_amount;
@property (nonatomic , copy)NSString *unit_price;
@property (nonatomic , copy)NSString *customer_service_phone;
@property (nonatomic , copy)NSString *person_num;
@property (nonatomic , copy)NSString *order_sn;
@property (nonatomic , copy)NSString *course_title;
@property (nonatomic , copy)NSString *course_id;
@property (nonatomic , copy)NSString *expire_time;
@property (nonatomic , copy)NSString *service_time;
@property (nonatomic , copy)NSString *add_time;
@end
