//
//  ManyOrderModel.h
//  ONLY
//
//  Created by 上海点硕 on 2017/2/27.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ManyOrderModel : NSObject
//order_sn	string	订单编号
//order_type	int	订单类型
//0：预付款订单
//1：尾款订单
//order_status	Int	订单状态，详见请求参数
//status	string	订单状态的中文解释
//goods_id	int	商品ID
//goods_img	string	商品图片，可能为空
//goods_name	string	商品名称
//goods_price	float	商品单价
//goods_number	int	商品数量
//goods_amount	float	订单金额
//has_pay_amount	float	已付金额，只有在尾款订单中才会有值， 预付款订单中显示为0.00

@property (nonatomic , copy)NSString *order_sn;
@property (nonatomic , copy)NSString *order_type;
@property (nonatomic , copy)NSString *order_status;
@property (nonatomic , copy)NSString *status;
@property (nonatomic , copy)NSString *goods_id;
@property (nonatomic , copy)NSString *goods_img;
@property (nonatomic , copy)NSString *goods_name;
@property (nonatomic , copy)NSString *goods_price;
@property (nonatomic , copy)NSString *goods_number;
@property (nonatomic , copy)NSString *goods_amount;
@property (nonatomic , copy)NSString *has_pay_amount;
@property (nonatomic , copy)NSString *good_img;
@property (nonatomic , copy)NSString *customer_service_phone;
@property (nonatomic , copy)NSString *expire_time;
@end
