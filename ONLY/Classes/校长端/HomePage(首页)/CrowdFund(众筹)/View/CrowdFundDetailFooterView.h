//
//  CrowdFundDetailFooterView.h
//  ONLY
//
//  Created by Dylan on 28/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"
#import "CrowdFundItem.h"
@interface CrowdFundDetailFooterView : UIView

@property (weak, nonatomic) IBOutlet HMSegmentedControl *segmentView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic, strong) CrowdFundItem * item;

@property (nonatomic, copy) void (^reload_block)(CrowdFundDetailFooterView * footerView);

@end
