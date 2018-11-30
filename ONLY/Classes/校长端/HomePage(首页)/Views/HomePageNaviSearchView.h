//
//  HomePageNaviSearchView.h
//  ONLY
//
//  Created by Dylan on 12/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageNaviSearchView : UIView
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *typeBtn;
@property (weak, nonatomic) IBOutlet UITextField *searchTF;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (copy, nonatomic) void (^btnAction_block)(NSInteger index);
@end
