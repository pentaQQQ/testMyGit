//
//  IdeaDetailBottomView.h
//  ONLY
//
//  Created by Dylan on 31/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IdeaItem.h"
@interface IdeaDetailBottomView : UIView
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *collectionBtn;
@property (weak, nonatomic) IBOutlet UIButton *greatBtn;

@property (nonatomic, strong) IdeaItem * item;
@property (nonatomic, copy) void (^btnAction_block)(NSInteger index);
@end
