//
//  DropMenuCollectionViewCell.h
//  DorpMenuView
//
//  Created by George on 16/11/18.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropMenuCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIView *underLine;

-(void)displaySeparator;

@end
