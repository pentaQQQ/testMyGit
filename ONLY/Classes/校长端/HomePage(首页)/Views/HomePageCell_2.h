//
//  HomePageCell_2.h
//  ONLY
//
//  Created by Dylan on 11/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageCell_2 : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreBtn;


@property (nonatomic, strong)NSMutableArray * dataArray;
@property(nonatomic,copy) void (^btnAction_block)(NSInteger index);
@property(nonatomic,copy) void (^newsDetail_block)(NSInteger index);

@property(nonatomic,strong)NSIndexPath * indexPath;
@end
