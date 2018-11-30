//
//  DropMenuView.h
//  DorpMenuView
//
//  Created by George on 16/11/18.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropMenuView : UIView


@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, copy) void(^selectedBlock)(NSInteger index);          // <#name#>
@end
