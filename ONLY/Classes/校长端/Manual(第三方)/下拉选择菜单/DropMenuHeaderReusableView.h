//
//  DropMenuHeaderReusableView.h
//  DorpMenuView
//
//  Created by George on 16/11/18.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropMenuHeaderReusableView : UICollectionReusableView

@property (nonatomic, copy) void(^DropMenuHeaderButtonClickedBlock)(void);          // <#name#>

@end
