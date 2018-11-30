//
//  ConferenceDetailBottomView.h
//  ONLY
//
//  Created by Dylan on 07/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConferenceItem.h"
@interface ConferenceDetailBottomView : UIView
@property (weak, nonatomic) IBOutlet UIButton *followBtn;
@property (nonatomic,strong) ConferenceItem * item;
@property(nonatomic,copy) void (^btnAction_block)(NSInteger index);
@end
