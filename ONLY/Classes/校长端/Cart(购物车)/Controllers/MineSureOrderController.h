//
//  MineSureOrderController.h
//  ONLY
//
//  Created by 上海点硕 on 2017/2/13.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineSureOrderController : UIViewController

@property (nonatomic , copy)NSString *cart_ids;   //首页过来的就是good ID
@property (nonatomic , copy)NSString *goodPrice;   //都要传价格
@property (nonatomic , assign)BOOL whoCome;        //首页过来的传1
@property (nonatomic,  assign)NSInteger num;       //首页过来的传数量

@end

