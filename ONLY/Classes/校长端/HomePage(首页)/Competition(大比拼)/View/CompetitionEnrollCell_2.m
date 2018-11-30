//
//  CompetitionEnrollCell_2.m
//  ONLY
//
//  Created by Dylan on 16/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "CompetitionEnrollCell_2.h"

@implementation CompetitionEnrollCell_2
@synthesize imageArray = _imageArray;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray new];
    }
    return _imageArray;
}

-(void)setImageArray:(NSMutableArray *)imageArray{
    _imageArray = imageArray;
    
    for (int i=0; i<self.photoIVArray.count; i++) {
        UIImageView * imageView = self.photoIVArray[i];
        UIButton * btn = self.deleteBtnArray[i];
        if (i < imageArray.count) {
            [imageView setImage:imageArray[i]];
            btn.hidden = NO;
        }else{
            imageView.image = [UIImage imageNamed:@"上传照片"];
            btn.hidden = YES;
        }
    }
    
 
}

- (IBAction)btnClicked:(UIButton *)sender {
    sender.hidden = YES;
    if (self.deleteImage_block) {
        self.deleteImage_block(sender.tag);
    }
}

@end
