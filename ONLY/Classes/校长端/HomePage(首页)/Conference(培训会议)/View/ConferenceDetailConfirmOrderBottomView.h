//
//  ConferenceDetailConfirmOrderBottomView.h
//  ONLY
//
//  Created by Dylan on 06/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConferenceItem.h"
@interface ConferenceDetailConfirmOrderBottomView : UIView
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;



@property(nonatomic,strong)ConferenceItem * item;
@property(nonatomic,copy) void (^btnAction_block)(NSInteger index);
@end
