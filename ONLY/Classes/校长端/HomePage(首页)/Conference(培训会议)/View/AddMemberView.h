//
//  AddMemberView.h
//  ONLY
//
//  Created by Dylan on 06/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddMemberView : UIView

@property(nonatomic,strong)NSMutableArray * dataArray;

@property(nonatomic,copy)void (^btnAction_block)(NSArray * choosedArray);

-(void)show;
-(void)dismiss;

@end
