//
//  CompetitionEnrollCell_1.h
//  ONLY
//
//  Created by Dylan on 16/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompetitionEnrollCell_1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;

@property (weak, nonatomic) IBOutlet UITextField *nameTF;

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

@property (weak, nonatomic) IBOutlet UITextView *overviewTV;

@property (nonatomic, strong) UIImage * image;
@property (nonatomic, copy) void (^chooseHeadImage_block)();
@property (nonatomic, copy) void (^brief_block)(NSString * content);
@property (nonatomic, copy) void (^name_block)(NSString * content);
@property (nonatomic, copy) void (^phoneNum_block)(NSString * content);

@end
