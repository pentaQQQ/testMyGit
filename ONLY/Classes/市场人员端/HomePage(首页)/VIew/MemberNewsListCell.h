//
//  MemberNewsListCell.h
//  ONLY
//
//  Created by zfd on 17/1/14.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberNewsListCell : UITableViewCell

/*时间圆角view*/
@property (weak, nonatomic) IBOutlet UIView *time_mask_bg_view;

/*内容的view*/
@property (weak, nonatomic) IBOutlet UIView *content_view;

/*时间label*/
@property (weak, nonatomic) IBOutlet UILabel *time_label;

/*消息支付状态*/
@property (weak, nonatomic) IBOutlet UILabel *order_state_label;

/*消息读取状态*/
@property (weak, nonatomic) IBOutlet UILabel *news_read_state_label;


/*消息内容*/
@property (weak, nonatomic) IBOutlet UILabel *news_content_label;

/*订单号*/
@property (weak, nonatomic) IBOutlet UILabel *order_number_label;


+(instancetype) memberNewsListCellWithTableview:(UITableView*) tableview;


@end
