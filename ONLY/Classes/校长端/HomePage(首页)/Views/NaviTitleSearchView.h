//
//  NaviTitleSearchView.h
//  ONLY
//
//  Created by Dylan on 21/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NaviTitleSearchView : UIView
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (nonatomic,copy)void (^btnAction_block)();
@end
