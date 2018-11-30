//
//  MineChangeNameController.h
//  ONLY
//
//  Created by 上海点硕 on 2017/2/20.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol reFreshMyControllerDelegate <NSObject>

- (void)reFresh:(NSString *)str;

@end

@interface MineChangeNameController : UIViewController

@property (nonatomic, weak)id<reFreshMyControllerDelegate>delegate;

@property (nonatomic ,assign)NSInteger isType;

@property (nonatomic ,copy)NSString *myStr; //上个界面传过来的值

@end
