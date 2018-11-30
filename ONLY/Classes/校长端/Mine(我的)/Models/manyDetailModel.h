//
//  manyDetailModel.h
//  ONLY
//
//  Created by 上海点硕 on 2017/2/27.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface manyDetailModel : NSObject

@property (nonatomic , assign)NSInteger service_time;
@property (nonatomic , copy)NSString *invoice_title;
@property (nonatomic , copy)NSString *consignee_address;
@property (nonatomic , copy)NSString *add_time_str;
@property (nonatomic , copy)NSString *status;
@property (nonatomic , copy)NSString *consignee;
@property (nonatomic , assign)NSInteger order_status;
@property (nonatomic , copy)NSString *goods_name;
@property (nonatomic , copy)NSString *pay_type;
@property (nonatomic , copy)NSString *contact_phone;
@property (nonatomic , assign)NSInteger expire_time;
@property (nonatomic , copy)NSString *goods_img;
@property (nonatomic , assign)BOOL has_invoice;
@property (nonatomic , copy)NSString *invoice_type;
@property (nonatomic , copy)NSString *order_sn;
@property (nonatomic , assign)NSInteger add_time;
@property (nonatomic , assign)float goods_price;
@property (nonatomic , assign)float goods_number;
@property (nonatomic , copy)NSString *has_pay_amount;
@property (nonatomic , copy)NSString *remark;
@property (nonatomic , assign)NSInteger order_type;
@property (nonatomic , copy)NSString *goods_amount;
@property (nonatomic , copy)NSString *customer_service_phone;



@end
