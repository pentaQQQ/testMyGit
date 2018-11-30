//
//  CrowdFundDetailCell_3.m
//  ONLY
//
//  Created by Dylan on 16/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "CrowdFundDetailCell_3.h"

@implementation CrowdFundDetailCell_3

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NSLog(@"%@",NSStringFromCGRect( self.progress.frame));
//    [self resetProgress];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self performSelector:@selector(resetProgress) withObject:nil afterDelay:0.01];
//    [self resetProgress];
}

-(void)setItem:(CrowdFundItem *)item{
    _item = item ;
    NSArray * count = self.item.crowd_price[@"count"];
    self.greatCountLabel.text = item.crowd_num;
//    self.targetCountLabel.text = item.start_num;
    self.targetCountLabel.text = [NSString stringWithFormat:@"%@",count.firstObject];
    
}

-(void)resetProgress{
    NSArray * count = self.item.crowd_price[@"count"];
    NSArray * price = self.item.crowd_price[@"price"];
    CGFloat percent;
    CGFloat positionX;
    CGFloat length = self.progress.width*9/10;
    NSLog(@"length=%f",length);
    for (int i = 0; i<count.count; i++) {
        percent = [count[i]floatValue]/[count.lastObject floatValue];
        positionX = length*percent;
        
        UIView * line = [[UIView alloc]initWithFrame:CGRectMake(positionX, -20, 2, 20)];
        line.tag = i+100;
        line.backgroundColor = colorWithRGB(0xC2D6DF);
        [self.progress addSubview:line];
        
        UILabel * priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(positionX, -40, 20, 20)];
        priceLabel.text = [NSString stringWithFormat:@"¥%@",price[i]];
        priceLabel.textColor = lightGray_Color();
        priceLabel.font = [UIFont systemFontOfSize:12];
        [priceLabel jk_adjustLabelSizeWithMinimumFontSize:12];
        
        UILabel * countLabel = [[UILabel alloc]initWithFrame:CGRectMake(positionX, 20, 20, 20)];
        countLabel.text = [NSString stringWithFormat:@"%@%@",count[i],self.item.good_unit];
        countLabel.textColor = lightGray_Color();
        countLabel.font = [UIFont systemFontOfSize:12];
        [countLabel jk_adjustLabelSizeWithMinimumFontSize:12];
        countLabel.centerX = positionX;
        
        [self.progress addSubview:priceLabel];
        [self.progress addSubview:countLabel];
    }
    
    percent = [self.item.crowd_num floatValue]/[count.firstObject floatValue];
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 20)];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.centerY = 2.5;
    btn.layer.cornerRadius = btn.height/2;
    btn.backgroundColor = colorWithRGB(0x39A0D9);
    btn.userInteractionEnabled = NO;
    [btn setTitle:[NSString stringWithFormat:@"%.0f%%",percent*100] forState:UIControlStateNormal];
    [btn setTintColor:WhiteColor];
    [self.progress addSubview:btn];
    
    
    percent = [self.item.crowd_num floatValue]/([count.lastObject floatValue]*10/9);
    
    btn.centerX = self.progress.width*percent;
    self.progress.progress = percent;
    
    
}

@end
