//
//  IdeaDetailCell_2.m
//  ONLY
//
//  Created by Dylan on 13/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "IdeaDetailCell_2.h"

@implementation IdeaDetailCell_2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    [self.imgBgView removeFromSuperview];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setItem:(IdeaItem *)item{
    _item = item;
    self.contentLabel.text = item.apply_desc;
    if (item.apply_img.count==0) {
        [self.imgBgView removeFromSuperview];
    }else{
        for (int i=0; i<3; i++) {
            UIImageView * imageView = self.imageArray[i];
            
            if (i<item.apply_img.count) {
                [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,item.apply_img[i]]]];
            }else{
                [imageView removeFromSuperview];
            }
        }
    }
}

@end
