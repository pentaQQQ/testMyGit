//
//  ClassDetailModel.h
//  ONLY
//
//  Created by 上海点硕 on 2017/3/7.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassDetailModel : NSObject
//end = 17:00,
//course_class_id = 7,
//start = 06:00,
//class_date = 2017年02月11日,
//class_addres = 222,
//teacher_name = 王老师,
//teacher_id = 1,
//class_name = 222,
//course_id = 1


@property(nonatomic , copy)NSString *end;

@property(nonatomic , copy)NSString *course_class_id;

@property(nonatomic , copy)NSString *start;

@property(nonatomic , copy)NSString *class_date;

@property(nonatomic , copy)NSString *class_addres;

@property(nonatomic , copy)NSString *teacher_name;

@property(nonatomic , copy)NSString *teacher_id;

@property(nonatomic , copy)NSString *class_name;

@property(nonatomic , copy)NSString *course_id;
@property (nonatomic ,assign)BOOL isExpand;
@end
