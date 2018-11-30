//
//  StarView.h
//  EvaluationStar
//
//  Created by 赵贺 on 15/11/26.
//  Copyright © 2015年 赵贺. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StarView;
@protocol StarViewDelegate <NSObject>

- (void)SGActionSheet:(StarView *)StarView index:(NSInteger)index;

@end

@interface StarView : UIView
@property (nonatomic,weak)id<StarViewDelegate>delegate;
- (id)initWithFrame:(CGRect)frame EmptyImage:(NSString *)Empty StarImage:(NSString *)Star;
@end
