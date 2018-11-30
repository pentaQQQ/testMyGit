//
//  HomePageHeaderView.h
//  ONLY
//
//  Created by Dylan on 27/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageHeaderView : UITableViewHeaderFooterView
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UIButton * allBtn;

@property(nonatomic,copy)void (^btnAction_block)();

@end
