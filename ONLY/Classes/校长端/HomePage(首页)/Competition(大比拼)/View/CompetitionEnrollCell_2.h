//
//  CompetitionEnrollCell_2.h
//  ONLY
//
//  Created by Dylan on 16/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CompetitionEnrollCell_2 : UITableViewCell
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *photoIVArray;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *deleteBtnArray;

@property (nonatomic,strong) NSMutableArray * imageArray;
@property (copy, nonatomic) void (^deleteImage_block)(NSInteger index);
@end
