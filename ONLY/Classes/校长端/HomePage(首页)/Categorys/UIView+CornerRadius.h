//
//  UIView+CornerRadius.h
//  ONLY
//
//  Created by Dylan on 05/04/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE

@interface UIView (CornerRadius)

@property (nonatomic, assign) IBInspectable CGFloat cornerRadius;
@property (nonatomic, assign) IBInspectable CGFloat borderWidth;
@property (nonatomic, assign) IBInspectable BOOL masksToBounds;
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

@end
