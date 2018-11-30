//
//  FilterCollectionViewCell.m
//  ONLY
//
//  Created by Dylan on 14/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "FilterCollectionViewCell.h"

@implementation FilterCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}


-(void)setItem:(FilterItem *)item{
    _item = item;
    self.titleLabel.text = item.type_name;
    if (item.isSelected) {
        self.bgImageView.image = [UIImage imageNamed:@"selected_search"];
    }else{
        self.bgImageView.image = nil;
    }
    
}
@end
