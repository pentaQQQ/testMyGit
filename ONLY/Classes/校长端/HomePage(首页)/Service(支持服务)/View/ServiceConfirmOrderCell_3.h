//
//  ServiceConfirmOrderCell_3.h
//  ONLY
//
//  Created by Dylan on 08/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServiceConfirmOrderCell_3 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UITextView *contentTV;
@property (weak, nonatomic) IBOutlet UILabel *placeHolderLabel;
@property (nonatomic,strong)NSIndexPath * indexPath;
@property (nonatomic,copy) void(^textChanged_block)(NSString * text);

@end
