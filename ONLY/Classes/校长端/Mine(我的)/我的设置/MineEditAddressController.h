//
//  MineEditAddressController.h
//  ONLY
//
//  Created by 上海点硕 on 2017/2/9.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyDelegate <NSObject>
-(void)AddressCresh;
@end


@interface MineEditAddressController : UIViewController

@property (nonatomic,weak)id<MyDelegate>delegate;

@property (nonatomic ,copy)NSString *myName;

@property (nonatomic ,copy)NSString *myPhone;
@property (nonatomic ,copy)NSString *myprovince;
@property (nonatomic ,copy)NSString *myCity;
@property (nonatomic ,copy)NSString *myArea;
@property (nonatomic ,copy)NSString *myCs;
@property (nonatomic ,copy)NSString *myAdress;

@property (nonatomic ,copy)NSString *myAdressId;

@property (nonatomic ,copy)NSString *myStause;

@property (nonatomic,assign)BOOL myType;



@end
