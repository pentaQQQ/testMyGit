//
//  HomePageCollectionCell_3.m
//  ONLY
//
//  Created by Dylan on 17/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "HomePageCollectionCell_3.h"

@implementation HomePageCollectionCell_3

- (void)awakeFromNib {
    [super awakeFromNib];
    CGAffineTransform transform=CGAffineTransformMakeRotation(0.78);
    self.statusLabel.transform = transform;
}

-(void)setServiceItem:(ServiceItem *)serviceItem{
    _serviceItem = serviceItem;
    self.bottomFirstLabel.hidden = NO;
    self.bottomSecondLabel.hidden = NO;
    self.bottomThirdLabel.hidden = NO;
    self.bottomFirstIV.hidden = NO;
    self.bottomSecondIV.hidden = NO;
    self.bottomThirdIV.hidden = NO;
    
    
    self.bottomSecondIV.hidden = YES;
    self.bottomSecondLabel.hidden = YES;
    self.bottomThirdIV.hidden = YES;
    self.bottomThirdLabel.hidden = YES;
    
    [self.photoIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,serviceItem.service_img]]];
    self.titleLabel.text = serviceItem.service_name;
    
    self.bottomFirstIV.image = [UIImage imageNamed:@"支持服务_人员列表_mine"];
    self.bottomFirstLabel.text = [NSString stringWithFormat:@"已申请:%@",serviceItem.application_number];

}

@end
