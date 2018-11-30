//
//  ConferenceDetailFooterView.h
//  ONLY
//
//  Created by Dylan on 06/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HMSegmentedControl.h"
#import "TeacherItem.h"
#import "ConferenceItem.h"
@interface ConferenceDetailFooterView : UIView
@property (weak, nonatomic) IBOutlet UIView *segmentView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic,strong) NSMutableArray * dataArray;
@property (nonatomic,strong) HMSegmentedControl * segment;
@property (nonatomic,strong) ConferenceItem * item;


@property (nonatomic, copy) void (^reload_block)(ConferenceDetailFooterView * footerView);
@property (nonatomic, copy) void (^clicked_block)(TeacherItem * item);
@end
