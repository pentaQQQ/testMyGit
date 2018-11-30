//
//  FilterItem.m
//  ONLY
//
//  Created by Dylan on 23/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "FilterItem.h"

@implementation FilterItem

-(NSMutableArray *)list{
    if (!_list) {
        _list = [NSMutableArray new];
    }
    return _list;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(id)init{
    self = [super init];
    if (self) {
        self.isSelected = NO;
    }
    return self;
}

+(instancetype)itemWithDic:(NSDictionary*)dic{
    FilterItem * filterItem = [FilterItem new];
    filterItem.name = dic[@"name"];
    
    for (NSDictionary * dic1 in dic[@"list"]) {
        FilterItem * item = [FilterItem new];
        [item setValuesForKeysWithDictionary:dic1];
        [filterItem.list addObject:item];
    }
    return filterItem;
}


@end
