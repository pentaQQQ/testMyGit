//
//  ConferenceDetailConfirmOrderCell_2.h
//  ONLY
//
//  Created by Dylan on 06/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConferenceDetailConfirmOrderCell_2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *operateBtn;
@property (nonatomic, copy) void (^btnAction_block)(NSInteger index);
@end
