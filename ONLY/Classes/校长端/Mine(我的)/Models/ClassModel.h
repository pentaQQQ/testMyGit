//
//  ClassModel.h
//  ONLY
//
//  Created by 上海点硕 on 2017/3/6.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassModel : NSObject

//name = 第1天,
//date = 2017年02月10日,
//son  =
@property (nonatomic , copy)NSString *name;

@property (nonatomic ,copy)NSString *date;

@property (nonatomic , strong) NSArray *son;

@end
