//
//  BlockButton.h
//  Choose
//
//  Created by zfd on 16/11/22.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlockButton : UIButton


/**
 按钮以block的形式返回的触发方法

 @param controlevents  UIControlEvents
 @param completion     相应的回调
 */
-(void) addActionforControlEvents:(UIControlEvents)controlevents respond:(void(^)(void)) completion;

@end
