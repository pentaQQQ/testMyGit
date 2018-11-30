//
//  ConferenceDetailBottomView.m
//  ONLY
//
//  Created by Dylan on 07/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "ConferenceDetailBottomView.h"

@implementation ConferenceDetailBottomView

-(void)awakeFromNib{
    [super awakeFromNib];
    [self.followBtn jk_setImagePosition:LXMImagePositionTop spacing:5];
    
    [self.followBtn setImage:[UIImage imageNamed:@"产品众筹_详情_众筹中_attention"] forState:UIControlStateNormal];
    
    [self.followBtn setImage:[UIImage imageNamed:@"产品众筹_详情_众筹中_attention"] forState:UIControlStateHighlighted];
    
    [self.followBtn setImage:[UIImage imageNamed:@"产品众筹_详情_众筹中_attention_selected"] forState:UIControlStateSelected];
    
    [self.followBtn setImage:[UIImage imageNamed:@"产品众筹_详情_众筹中_attention_selected"] forState:UIControlStateSelected|UIControlStateHighlighted];
    
    
}
- (IBAction)btnClicked:(UIButton *)sender {
    if (self.btnAction_block) {
        self.btnAction_block(sender.tag);
    }
}

-(void)setItem:(ConferenceItem *)item{
    _item = item;
    if ([item.is_focus integerValue]==1) {
        self.followBtn.selected = YES;
//        self.followBtn.userInteractionEnabled = NO;
    }else{
        self.followBtn.selected = NO;
    }
    [self.followBtn setTitle:[NSString stringWithFormat:@"关注(%@)",item.focus_count] forState:UIControlStateNormal];
}

@end
