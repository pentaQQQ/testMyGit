//
//  ComplainModel.h
//  ONLY
//
//  Created by 上海点硕 on 2017/3/13.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ComplainModel : NSObject

@property (nonatomic , copy) NSString *synopsis;

@property (nonatomic , copy) NSString *add_date;

@property (nonatomic , copy) NSString *complaint_id;

@property (nonatomic , copy) NSString *position_name;

@property (nonatomic , copy) NSString *portrait;

@property (nonatomic , assign) NSInteger status;

@end
