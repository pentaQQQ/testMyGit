//
//  GoodIdeaModel.h
//  ONLY
//
//  Created by 上海点硕 on 2017/3/8.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodIdeaModel : NSObject
//        apply_id = 6,
//        apply_name = string啊,
//        thumbs = 0,
//        apply_desc = string啊啊啊啊啊啊,
//        apply_img = 0,
//        status = 2,
//        member_name = 午餐会,
//        comment_count = 0,
//        portrait = /uploads/u/18353130882/2017/0303/c43c7987-fec1-7e88-2633-9a61e46ef311.jpg,
//        add_time = 1487656830

@property (nonatomic , copy)NSString *apply_id;
@property (nonatomic , copy)NSString *apply_name;
@property (nonatomic , strong)NSArray *apply_img;
@property (nonatomic , copy)NSString *member_name;
@property (nonatomic , copy)NSString *thumbs;
@property (nonatomic , copy)NSString *portrait;
@property (nonatomic , copy)NSString *comment_count;
@property (nonatomic , copy)NSString *type_id;
@property (nonatomic , copy)NSString *apply_desc;
@property (nonatomic , copy)NSString *status;
@property (nonatomic , copy)NSString *add_time;
@end
