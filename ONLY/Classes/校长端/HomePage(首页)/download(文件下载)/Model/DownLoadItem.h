//
//  DownLoadItem.h
//  ONLY
//
//  Created by Dylan on 20/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownLoadItem : NSObject
@property(nonatomic,strong)NSString * ID;
@property(nonatomic,strong)NSString * iconUrl;
@property(nonatomic,strong)NSString * name;
@property(nonatomic,strong)NSString * add_time;
@property(nonatomic,strong)NSMutableArray * content;

+(instancetype)itemWithDic:(NSDictionary * )dic;
@end
