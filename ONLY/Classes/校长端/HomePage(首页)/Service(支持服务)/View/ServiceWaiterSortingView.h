//
//  ServiceWaiterSortingView.h
//  ONLY
//
//  Created by Dylan on 08/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, sortType) {
    sortType_default,
    sortType_serviceCount,
    sortType_servicePrice,
};
typedef NS_ENUM(NSUInteger, sortOrder) {
    sortOrder_Up,
    sortOrder_Down,
};

@interface ServiceWaiterSortingView : UIView
@property (weak, nonatomic) IBOutlet UIButton *defaultBtn;
@property (weak, nonatomic) IBOutlet UIButton *serviceCountBtn;
@property (weak, nonatomic) IBOutlet UIButton *priceBtn;

@property(nonatomic, copy)void (^btnAction_block)(NSInteger index,sortType sortType,sortOrder sortOrder);

@end
