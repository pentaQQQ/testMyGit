//
//  BlockButton.m
//  Choose
//
//  Created by zfd on 16/11/22.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import "BlockButton.h"
#import <objc/runtime.h>

static void *buttonClickKey = @"buttonClickKey";

@implementation BlockButton

-(void) addActionforControlEvents:(UIControlEvents)controlevents respond:(void(^)(void)) completion
{
    [self addTarget:self action:@selector(clickButton) forControlEvents:controlevents];
    void (^block)(void) = ^{
        completion();
    };
    objc_setAssociatedObject(self, buttonClickKey, block, OBJC_ASSOCIATION_COPY);
}


-(void) clickButton
{
    void (^block)(void) = objc_getAssociatedObject(self, buttonClickKey);
    block();
}


@end
