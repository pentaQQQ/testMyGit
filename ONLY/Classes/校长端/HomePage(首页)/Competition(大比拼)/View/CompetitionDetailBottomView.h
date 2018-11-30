//
//  CompetitionDetailBottomView.h
//  ONLY
//
//  Created by Dylan on 15/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompetitionDetailBottomView : UIView
@property(nonatomic,copy) void (^btnAction_block)(NSInteger index);
@end
