//
//  ConferenceTeacherDetailController.m
//  ONLY
//
//  Created by Dylan on 21/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "ConferenceTeacherDetailController.h"

@interface ConferenceTeacherDetailController ()
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextView *briefTV;

@end

@implementation ConferenceTeacherDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"讲师详情";
    self.view.backgroundColor = AppBackColor;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,self.item.teacher_img]]];
    self.nameLabel.text = self.item.teacher_name;
    self.briefTV.text = self.item.teacher_desc;
}


@end





