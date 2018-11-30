//
//  FilterItem.h
//  ONLY
//
//  Created by Dylan on 23/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterItem : NSObject

@property (nonatomic, strong) NSString *type_id;

@property (nonatomic, strong) NSString *picture;

@property (nonatomic, strong) NSString *type_name;

@property (nonatomic, assign) BOOL isSelected;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSMutableArray *list;

+(instancetype)itemWithDic:(NSDictionary*)dic;

@end
