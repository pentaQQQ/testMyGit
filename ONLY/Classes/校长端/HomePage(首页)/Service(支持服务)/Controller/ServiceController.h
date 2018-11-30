//
//  ServiceController.h
//  ONLY
//
//  Created by Dylan on 16/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, ServiceType) {
    ServiceType_Market,//市场
    ServiceType_Education,//教学
    ServiceType_Training,//培训
    ServiceType_Operation,//运营
};
@interface ServiceController : UIViewController
@property(nonatomic , assign)BOOL isSearch;
@property (nonatomic, strong)NSString * keyword;
@end
