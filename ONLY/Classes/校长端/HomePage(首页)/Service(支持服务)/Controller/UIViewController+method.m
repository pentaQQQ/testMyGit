//
//  UIViewController+method.m
//  DoveERP
//
//  Created by Dylan on 8/8/16.
//  Copyright © 2016 time-share. All rights reserved.
//

#import "UIViewController+method.h"

@implementation UIViewController (method)

- (BOOL)isBlankString:(NSString *)string{
    
    if (string == nil) {
        return YES;
    }
    if (string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string respondsToSelector:@selector(stringByTrimmingCharactersInSet:)]) {
        if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]==0) {
            return YES;
        }
    }
    
    return NO;
}
- (void)showAlertViewWithMessage:(NSString *)message{
    UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}
@end
