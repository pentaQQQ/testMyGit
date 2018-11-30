//
//  DownLoadItem.m
//  ONLY
//
//  Created by Dylan on 20/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "DownLoadItem.h"
#import "DataItem.h"
@implementation DownLoadItem
-(NSMutableArray *)content{
    if (!_content) {
        _content = [NSMutableArray new];
    }
    return _content;
}
+(instancetype)itemWithDic:(NSDictionary * )dic{
    DownLoadItem * item = [DownLoadItem new];
    item.ID = dic[@"id"];
    item.name = dic[@"name"];
    item.add_time = dic[@"add_time"];
    item.iconUrl = dic[@"iconUrl"];
    
    for (NSDictionary * dic1 in dic[@"content"]) {
        DataItem * dataItem = [DataItem new];
        [dataItem setValuesForKeysWithDictionary:dic1];
        [item.content addObject:dataItem];
    }
    
    return item;
}
@end
