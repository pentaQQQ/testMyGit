//
//  AddressModel.h
//  ONLY
//
//  Created by 上海点硕 on 2017/2/21.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressModel : NSObject

@property (nonatomic ,copy)NSString *address;
@property (nonatomic ,copy)NSString *area_name;
@property (nonatomic ,copy)NSString *city_name;
@property (nonatomic ,copy)NSString *consignee;  //收货人
@property (nonatomic ,copy)NSString *contact_phone;
@property (nonatomic ,copy)NSString *is_status;
@property (nonatomic ,copy)NSString *member_address_id;
@property (nonatomic ,copy)NSString *province_name;
@end
