//
//  IdeaDetailCell_2.h
//  ONLY
//
//  Created by Dylan on 13/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IdeaItem.h"
@interface IdeaDetailCell_2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIView *imgBgView;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageArray;


@property(nonatomic,strong)IdeaItem * item;
@end

