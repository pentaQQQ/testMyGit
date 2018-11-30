//
//  MemberHomeDetailCell.h
//  ONLY
//
//  Created by zfd on 17/1/15.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberHomeDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *order_sn;

@property (weak, nonatomic) IBOutlet UILabel *order_status;
@property (weak, nonatomic) IBOutlet UILabel *order_begin;
@property (weak, nonatomic) IBOutlet UILabel *order_end;

@end
