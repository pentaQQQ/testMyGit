//
//  IdeaDetailBottomView.m
//  ONLY
//
//  Created by Dylan on 31/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "IdeaDetailBottomView.h"

@implementation IdeaDetailBottomView

-(void)awakeFromNib{
    [super awakeFromNib];
    //    [self addConstraint];

}

-(void)setItem:(IdeaItem *)item{
    _item = item;
    [self.commentBtn setTitle:[NSString stringWithFormat:@"评论(%@)",item.comment_count] forState:UIControlStateNormal];
    [self.collectionBtn setTitle:[NSString stringWithFormat:@"收藏(%@)",item.collect_count] forState:UIControlStateNormal];
    
    [self.commentBtn jk_setImagePosition:LXMImagePositionTop spacing:5];
    [self.collectionBtn jk_setImagePosition:LXMImagePositionTop spacing:5];
}

- (IBAction)btnClicked:(UIButton *)sender {
    if (self.btnAction_block) {
        self.btnAction_block(sender.tag);
    }
}


@end
