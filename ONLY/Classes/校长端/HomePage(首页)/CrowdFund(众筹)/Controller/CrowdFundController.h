//
//  CrowdFundController.h
//  ONLY
//
//  Created by Dylan on 13/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CrowdFundSortType) {
    CrowdFundSortType_Time,
    CrowdFundSortType_Hot,
};
typedef NS_ENUM(NSUInteger, CrowdFundStatus) {
    CrowdFundStatus_Requset,
    CrowdFundStatus_Progressing,
    CrowdFundStatus_Failure,
    CrowdFundStatus_Finish = 3,
};

@interface CrowdFundController : UIViewController
@property(nonatomic,assign)BOOL isSearch;
@property (nonatomic, strong)NSString * keyword;
@end
