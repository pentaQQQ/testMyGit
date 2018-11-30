//
//  ServiceWaiterSortingView.m
//  ONLY
//
//  Created by Dylan on 08/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "ServiceWaiterSortingView.h"

@interface ServiceWaiterSortingView()
@property(nonatomic,assign)sortType sortType;
@property(nonatomic,assign)sortOrder sortOrder;

@end

@implementation ServiceWaiterSortingView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.sortType = sortType_default;
    self.sortOrder = sortOrder_Up;
    
    [self.serviceCountBtn jk_setImagePosition:LXMImagePositionRight spacing:10];
    [self.priceBtn jk_setImagePosition:LXMImagePositionRight spacing:10];
    
}

- (IBAction)btnClicked:(UIButton *)sender {
    
    if (sender.tag == 1) {
        [self changeSortOrderWithNewType:sortType_default];
        self.sortType = sortType_default;
        
    }else if (sender.tag == 2){
        [self changeSortOrderWithNewType:sortType_serviceCount];
        self.sortType = sortType_serviceCount;
    }else if (sender.tag == 3){
        [self changeSortOrderWithNewType:sortType_servicePrice];
        self.sortType = sortType_servicePrice;
    }
    [self resetBtnImg];
    if (self.btnAction_block) {
        self.btnAction_block(sender.tag,self.sortType,self.sortOrder);
    }
}

-(void)changeSortOrderWithNewType:(sortType)type{
    if (self.sortType == type) {
        if (self.sortOrder == sortOrder_Up) {
            self.sortOrder = sortOrder_Down;
        }else{
            self.sortOrder = sortOrder_Up;
        }
    }else{
        self.sortOrder = sortOrder_Up;
    }
}
-(void)resetBtnImg{
    [self.defaultBtn setImage:nil forState:UIControlStateNormal];
    [self.serviceCountBtn setImage:nil forState:UIControlStateNormal];
    [self.priceBtn setImage:nil forState:UIControlStateNormal];
    
    if (self.sortType == sortType_servicePrice) {
        if (self.sortOrder == sortOrder_Up) {
            [self.priceBtn setImage:[UIImage imageNamed:@"支持服务_详情_up-active"] forState:UIControlStateNormal];
        }else{
            [self.priceBtn setImage:[UIImage imageNamed:@"支持服务_详情_down-active"] forState:UIControlStateNormal];
        }
    }else if (self.sortType == sortType_serviceCount){
        if (self.sortOrder == sortOrder_Up) {
            [self.serviceCountBtn setImage:[UIImage imageNamed:@"支持服务_详情_up-active"] forState:UIControlStateNormal];
        }else{
            [self.serviceCountBtn setImage:[UIImage imageNamed:@"支持服务_详情_down-active"] forState:UIControlStateNormal];
        }
    }
}

@end
