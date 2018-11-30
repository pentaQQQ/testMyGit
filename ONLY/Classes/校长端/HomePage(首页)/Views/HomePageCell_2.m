//
//  HomePageCell_2.m
//  ONLY
//
//  Created by Dylan on 11/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "HomePageCell_2.h"

#import "OnlyNewsItem.h"
#import "CCPScrollView.h"

#import "SXMarquee.h"
#import "SXHeadLine.h"
@interface HomePageCell_2 ()
@property(nonatomic,assign)NSInteger titleIndex;
@property(nonatomic,assign)NSInteger index;

@property(nonatomic,strong)SXHeadLine * adText;
@property(nonatomic,strong)CCPScrollView * runText;
@end

@implementation HomePageCell_2
@synthesize dataArray = _dataArray;

-(void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    NSMutableArray * array = [NSMutableArray new];
    for (OnlyNewsItem * item in dataArray) {
        [array addObject:item.title];
    }
//    self.adText.messageArray = array;
//    [self.adText stop];
//    [self.adText start];
    if (array.count>0) {
        self.runText.titleArray = array;
        _runText.titleFont = 14;
        _runText.titleColor = [UIColor lightGrayColor];
        _runText.BGColor = [UIColor whiteColor];
    }
    
    
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



- (IBAction)btnClicked:(UIButton *)sender {
    if (self.btnAction_block) {
        self.btnAction_block(sender.tag);
    }
}
-(void)dealloc{
    NSLog(@"xiaohuile");
//    [self.adText stop];
}


#pragma mark - setter/getter

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
//-(SXHeadLine *)adText{
//    kWeakSelf(self);
//    if (!_adText) {
//        _adText = [[SXHeadLine alloc]initWithFrame:CGRectMake(80, 6.5, 220 * SCREEN_PRESENT, 35)];
//        [_adText setBgColor:[UIColor whiteColor] textColor:[UIColor lightGrayColor] textFont:[UIFont systemFontOfSize:13]];
//        [_adText setScrollDuration:0.5 stayDuration:3];
//        _adText.hasGradient = YES;
//        [_adText changeTapMarqueeAction:^(NSInteger index) {
//            NSLog(@"你点击了第 %ld 个button！内容：%@", index, _adText.messageArray[index]);
//            if (weakself.newsDetail_block) {
//                weakself.newsDetail_block(index);
//            }
//        }];
//        [self.contentView addSubview:_adText];
//        
//    }
//    return _adText;
//}

-(CCPScrollView *)runText{
    kWeakSelf(self);
    if (!_runText) {
        _runText = [[CCPScrollView alloc]initWithFrame:CGRectMake(80, 6.5, 220 * SCREEN_PRESENT, 35)];
        
        
        
        [_runText clickTitleLabel:^(NSInteger index,NSString *titleString) {
            
            NSLog(@"你点击了第 %ld 个button！内容：%@", index, _adText.messageArray[index]);
            if (weakself.newsDetail_block) {
                weakself.newsDetail_block(index);
            }
        }];
        
        [self.contentView addSubview:_runText];
    }
    return _runText;
}

@end
