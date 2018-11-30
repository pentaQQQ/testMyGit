//
//  HomePageCell_1.h
//  ONLY
//
//  Created by Dylan on 11/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HomePageCell_1 : UITableViewCell

@property(nonatomic,strong)NSIndexPath * indexPath;
@property(nonatomic,copy) void (^btnAction_block)(NSInteger index);
@end
