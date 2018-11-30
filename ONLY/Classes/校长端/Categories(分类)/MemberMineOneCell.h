//
//  MemberMineOneCell.h
//  ONLY
//
//  Created by zfd on 17/1/13.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MineOneCellclickDelegate <NSObject>

-(void) clickWithTag:(NSInteger) tag;

@end

@interface MemberMineOneCell : UITableViewCell

@property (nonatomic,assign) id<MineOneCellclickDelegate> delegate;

/*进行中number*/
@property (weak, nonatomic) IBOutlet UILabel *pending_order_label;

/*进行中*/
@property (weak, nonatomic) IBOutlet UILabel *pendind_order_name;

/*竖线*/
@property (weak, nonatomic) IBOutlet UILabel *shuxian_label;

/*历史订单number*/
@property (weak, nonatomic) IBOutlet UILabel *history_order_label;

/*历史订单*/
@property (weak, nonatomic) IBOutlet UILabel *history_order_name;



@end
