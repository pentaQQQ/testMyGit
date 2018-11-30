//
//  InterestModel.h
//  ONLY
//
//  Created by 上海点硕 on 2017/2/17.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InterestModel : NSObject
@property (nonatomic , copy)NSString *type_id;//兴趣id
@property (nonatomic , copy)NSString *type_name;//兴趣名称
@property (nonatomic , copy)NSString *type_img;//兴趣图片
@property (nonatomic , copy)NSString *picture;
@property (nonatomic , copy)NSString *selected;  //是否被选
@end
