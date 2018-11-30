//
//  CompetitionEnrollCell_4.h
//  ONLY
//
//  Created by Dylan on 08/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompetitionEnrollCell_4 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic,copy)void (^deleteVideo_block)();
-(void)playVideoWithUrlStr:(NSString *)urlStr;
@end
