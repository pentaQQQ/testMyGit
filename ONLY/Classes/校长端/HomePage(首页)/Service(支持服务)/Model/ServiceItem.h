//
//  ServiceItem.h
//  ONLY
//
//  Created by Dylan on 23/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ServiceItem : NSObject

@property (nonatomic, strong) NSString *service_type;

@property (nonatomic, strong) NSString *service_desc;

@property (nonatomic, strong) NSString *application_number;

@property (nonatomic, strong) NSString *service_name;

@property (nonatomic, strong) NSString *service_id;

@property (nonatomic, strong) NSArray  *activity_time;

@property (nonatomic, strong) NSString *type_id;

@property (nonatomic, strong) NSString *service_img;

@property (nonatomic, strong) NSString *service_brief;

@property (nonatomic, strong) NSString *add_time;

@property (nonatomic, strong) NSString *update_time;

@property (nonatomic, strong) NSString *is_hot;


@end
