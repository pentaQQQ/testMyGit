//
//  MineAddressController.h
//  ONLY
//
//  Created by 上海点硕 on 2017/2/9.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressModel;
@protocol sendModelDelegate <NSObject>

- (void)sendAddressModel:(AddressModel *)model;

@end

@interface MineAddressController : UIViewController
@property(nonatomic , assign)BOOL whoCome;
@property (nonatomic , weak)id <sendModelDelegate>delegate;
@end
