//
//  ZCModel.h
//  ONLY
//
//  Created by 上海点硕 on 2017/2/24.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCModel : NSObject

@property (nonatomic , copy)NSString *apply_id; //

@property (nonatomic , copy)NSString *add_time; //

@property (nonatomic , copy)NSString *status;   //

@property (nonatomic , copy)NSString *picture;  //

@property (nonatomic ,copy)NSString  *apply_name; //

//下面没用的参数 也不知道干啥
@property (nonatomic ,copy)NSString  *comment_count;
@property (nonatomic ,copy)NSString  *apply_img;
@property (nonatomic ,copy)NSString  *member_name;
@property (nonatomic ,copy)NSString  *goods_count;
@property (nonatomic ,copy)NSString  *portrait;
@property (nonatomic ,copy)NSString  *keywords;
@property (nonatomic ,copy)NSString  *type_id;
@property (nonatomic ,copy)NSString  *apply_desc;
@property (nonatomic ,copy)NSString  *apply_price;
@property (nonatomic ,copy)NSString  *update_time;

@end
