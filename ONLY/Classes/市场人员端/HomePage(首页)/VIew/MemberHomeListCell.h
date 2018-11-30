//
//  MemberHomeListCell.h
//  ONLY
//
//  Created by zfd on 17/1/14.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface MemberHomeListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *orderNum;
@property (weak, nonatomic) IBOutlet UILabel *orderState;
@property (weak, nonatomic) IBOutlet UILabel *orderName;
@property (weak, nonatomic) IBOutlet UILabel *orderPhone;

//+(instancetype) memberHomeListCellWithTableView:(UITableView*) tableview;


@end
