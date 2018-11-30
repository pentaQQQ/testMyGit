//
//  MineChangeMemController.h
//  ONLY
//
//  Created by 上海点硕 on 2017/3/8.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FreshMyControllerDelegate <NSObject>

- (void)Fresh:(NSString *)str;

@end

@interface MineChangeMemController : UIViewController
@property (nonatomic ,assign)NSInteger isType;
@property (nonatomic ,copy)NSString *myStr; //上个界面传过来的值
@property (nonatomic, weak)id<FreshMyControllerDelegate>delegate;
@property (nonatomic ,copy)NSString *keyName;
@property (nonatomic ,copy)NSString *person_id;
@end
