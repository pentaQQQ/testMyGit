//
//  BasePlusButton.m
//  ONLY
//
//  Created by 上海点硕 on 2016/12/19.
//  Copyright © 2016年 cbl－　点硕. All rights reserved.
//

#import "BasePlusButton.h"
#import "VTingSeaPopView.h"
#import "CustomAlertView.h"
#import "AddViewController.h"
#import "AwesomeMenu.h"
#import "AwesomeMenuItem.h"
#import "GoodIdeaController.h"
#import "ServerViewController.h"
@interface BasePlusButton ()<CYLPlusButtonSubclassing,VTingPopItemSelectDelegate,AwesomeMenuDelegate>

@end
@implementation BasePlusButton
{
    NSMutableArray *images;
    NSMutableArray *titles;
    VTingSeaPopView *pop;
    AwesomeMenu *popmenu;

}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
//        self.titleLabel.textAlignment = NSTextAlignmentCenter;
//        self.adjustsImageWhenHighlighted = NO;
        
        images = [NSMutableArray array];
        titles = [NSMutableArray arrayWithObjects:@"录音",@"拍照",@"标签",@"微博",@"微博",@"更多", nil];
        
        for (int i = 0; i<4; i++) {
            
         [images addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d",i+1]]];
        }
    }
    return self;
}

//上下结构的 button
//- (void)layoutSubviews {
//    [super layoutSubviews];
//    
//    // 控件大小,间距大小
//    // 注意：一定要根据项目中的图片去调整下面的0.7和0.9，Demo之所以这么设置，因为demo中的 plusButton 的 icon 不是正方形。
//    CGFloat const imageViewEdgeWidth   = self.bounds.size.width * 0.7;
//    CGFloat const imageViewEdgeHeight  = imageViewEdgeWidth * 0.9;
//    
//    CGFloat const centerOfView    = self.bounds.size.width * 0.5;
//    CGFloat const labelLineHeight = self.titleLabel.font.lineHeight;
//    CGFloat const verticalMargin  = (self.bounds.size.height - labelLineHeight - imageViewEdgeHeight) * 0.5;
//    
//    // imageView 和 titleLabel 中心的 Y 值
//    CGFloat const centerOfImageView  = verticalMargin + imageViewEdgeHeight * 0.5;
//    CGFloat const centerOfTitleLabel = imageViewEdgeHeight  + verticalMargin * 2 + labelLineHeight * 0.5 + 5;
//    
//    //imageView position 位置
//    self.imageView.bounds = CGRectMake(0, 0, imageViewEdgeWidth, imageViewEdgeHeight);
//    self.imageView.center = CGPointMake(centerOfView, centerOfImageView);
//    
//    //title position 位置
//    self.titleLabel.bounds = CGRectMake(0, 0, self.bounds.size.width, labelLineHeight);
//    self.titleLabel.center = CGPointMake(centerOfView, centerOfTitleLabel);
//}

+ (id)plusButton {
    
//    BasePlusButton *button = [[BasePlusButton alloc] init];
//    UIImage *buttonImage = [UIImage imageNamed:@"post_normal"];
//    [button setImage:buttonImage forState:UIControlStateNormal];
//    [button setTitle:@"发布" forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    
//    [button setTitle:@"选中" forState:UIControlStateSelected];
//    [button setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
//    
//    button.titleLabel.font = [UIFont systemFontOfSize:9.5];
//    [button sizeToFit];
//    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    
    UIImage *buttonImage = [UIImage imageNamed:@"ADD"];
    UIImage *highlightImage = [UIImage imageNamed:@"ADD"];
    UIImage *iconImage = [UIImage imageNamed:@"ADD"];
    UIImage *highlightIconImage = [UIImage imageNamed:@"ADD"];
    
    BasePlusButton *button = [BasePlusButton buttonWithType:UIButtonTypeCustom];
    
    button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(0.0, 0.0, buttonImage.size.width, buttonImage.size.height);
    [button setImage:iconImage forState:UIControlStateNormal];
    [button setImage:highlightIconImage forState:UIControlStateHighlighted];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:highlightImage forState:UIControlStateHighlighted];
    [button addTarget:button action:@selector(clickPublish) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

//中间按钮的点击事件
- (void)clickPublish {
    
//    CYLTabBarController *tabBarController = [self cyl_tabBarController];
//    UIViewController *viewController = tabBarController.selectedViewController;
    [popmenu removeFromSuperview];
    [self setupAwesomeMenu];
//    [pop removeFromSuperview];
//    pop = [[VTingSeaPopView alloc] initWithButtonBGImageArr:images andButtonBGT:titles];
//    [[UIApplication sharedApplication].keyWindow addSubview:pop];
//    pop.delegate = self;
//    [pop show];

}


- (void)setupAwesomeMenu
{
    
    UIImage *storyMenuItemImage = [UIImage imageNamed:@"发布"];
    UIImage *storyMenuItemImagePressed = [UIImage imageNamed:@""];
    
    UIImage *starImage = [UIImage imageNamed:@""];
    
    // Default Menu
    
    AwesomeMenuItem *starMenuItem1 = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"icon1"]
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem2 = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"icon2"]
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem3 = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"icon3"]
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];
    AwesomeMenuItem *starMenuItem4 = [[AwesomeMenuItem alloc] initWithImage:[UIImage imageNamed:@"icon4"]
                                                           highlightedImage:storyMenuItemImagePressed
                                                               ContentImage:starImage
                                                    highlightedContentImage:nil];

    
    NSArray *menuItems = [NSArray arrayWithObjects:starMenuItem1, starMenuItem2, starMenuItem3, starMenuItem4, nil];
    
    AwesomeMenuItem *startItem = [[AwesomeMenuItem alloc] initWithImage:storyMenuItemImage
                                                       highlightedImage:storyMenuItemImagePressed
                                                           ContentImage:storyMenuItemImage
                                                highlightedContentImage:storyMenuItemImage];
    
     popmenu = [[AwesomeMenu alloc] initWithFrame:self.window.bounds startItem:startItem menuItems:menuItems];
    
    popmenu.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    // 设置菜单的活动范围
    //         #define M_PI
    //         #define M_PI_2
    //         #define M_PI_4
    //         #define M_1_PI
    //         #define M_2_PI
    
    //整个菜单设置角度
     popmenu.menuWholeAngle =M_PI;
    
    //设置旋转角度
     popmenu.rotateAngle = M_PI*1.5;
    
    // 设置开始按钮的位置
    popmenu.startPoint = CGPointMake(190*SCREEN_PRESENT, 620*SCREEN_PRESENT);
    // 设置代理
    popmenu.delegate=self;
    
    // 不要旋转中间按钮
    popmenu.rotateAddButton = NO;
   
   [[UIApplication sharedApplication].keyWindow addSubview:popmenu];
     [popmenu open];
    
}

- (void)awesomeMenu:(AwesomeMenu *)menu didSelectIndex:(NSInteger)idx
{
    NSLog(@"%ld",idx);
    [popmenu removeFromSuperview];
    CYLTabBarController *tabBarController = [self cyl_tabBarController];
    UIViewController *viewController = tabBarController.selectedViewController;
    if (idx==0) {
        AddViewController *vc = [[AddViewController alloc] init];
        vc.idx = idx;
        [viewController presentViewController:vc animated:YES completion:nil];
    }
    
    else if (idx==1||idx==3)
    {
        ServerViewController *vc  = [[ServerViewController alloc] init];
        vc.idx = idx;
        [viewController presentViewController:vc animated:YES completion:nil];
    }
    
    else
    {
        GoodIdeaController *vc  = [[GoodIdeaController alloc] init];
        [viewController presentViewController:vc animated:YES completion:nil];
        
    }
    
}

- (void)awesomeMenuWillAnimateClose:(AwesomeMenu *)menu
{
   
    [popmenu removeFromSuperview];
}

#pragma mark delegate
-(void)itemDidSelected:(NSInteger)index {
    NSLog(@"点击了%ld:item",index);
   CYLTabBarController *tabBarController = [self cyl_tabBarController];
   UIViewController *viewController = tabBarController.selectedViewController;
   AddViewController *vc = [[AddViewController alloc] init];
   [viewController presentViewController:vc animated:YES completion:nil];
}

+ (CGFloat)multiplierOfTabBarHeight:(CGFloat)tabBarHeight {
    return  0.3;
}

+ (CGFloat)constantOfPlusButtonCenterYOffsetForTabBarHeight:(CGFloat)tabBarHeight {
    return  -10;
}
@end
