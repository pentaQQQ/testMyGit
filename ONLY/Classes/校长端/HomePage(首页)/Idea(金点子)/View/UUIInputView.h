//
//  UUIInputView.h
//  ISWorldCollege
//
//  Created by George on 16/10/28.
//  Copyright © 2016年 IdeaSource. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIAppearance.h"
#import "Masonry.h"

@interface UUIInputView : UIView

@property (nonatomic, assign) NSInteger inputLimit;                  //default is 20;
@property (nonatomic, copy)   NSString *title;                  //标题

@property (nonatomic, copy)   NSString *Ename;                  //英文名称

-(void)show;
-(void)inputDidFinished:(void (^)(NSString *inputStr))completeBlock;


@end
