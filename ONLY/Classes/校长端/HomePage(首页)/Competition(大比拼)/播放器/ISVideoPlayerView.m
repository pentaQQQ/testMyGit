//
//  ISVideoPlayerView.m
//  ISWorldCollege
//
//  Created by Dylan on 8/31/16.
//  Copyright © 2016 IdeaSource. All rights reserved.
//

#import "ISVideoPlayerView.h"
#import <AVFoundation/AVFoundation.h>


@interface ISVideoPlayerView()
/** bottom渐变层*/
@property (nonatomic, strong) CAGradientLayer *bottomGradientLayer;
/** top渐变层 */
@property (nonatomic, strong) CAGradientLayer *topGradientLayer;
/** bottomView*/
@property (strong, nonatomic  )  UIImageView     *bottomImageView;
/** topView */
@property (strong, nonatomic  )  UIImageView     *topImageView;

@end
@implementation ISVideoPlayerView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupTopView];
        [self setupBottomView];
        // 初始化渐变层
        [self initCAGradientLayer];
        self.isTopBottomViewHidden = NO;
        self.isAnimating = NO;
        
        
    }
    return self;
}
-(void)setupTopView{
    self.topImageView = [[UIImageView alloc]init];
    self.topImageView.userInteractionEnabled =YES;
    self.topImageView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    
    [self.backBtn setImage:[UIImage imageNamed:@"视频_视频详情_返回"] forState:UIControlStateNormal];
    self.rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(self.bounds.size.width-44, 0, 44, 44)];
    [self.rightBtn setImage:[UIImage imageNamed:@"视频_视频详情_分享_icon"] forState:UIControlStateNormal];
    self.rightBtn.hidden = YES;
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(44, 0, SCREEN_WIDTH-88, 44)];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [self.topImageView addSubview:self.backBtn];
    [self.topImageView addSubview:self.titleLabel];
    [self.topImageView addSubview:self.rightBtn];
    [self addSubview:self.topImageView];
    
}
-(void)setupBottomView{
    //        self.topImageView.backgroundColor = [UIColor redColor];
    self.bottomImageView = [[UIImageView alloc]init];
    self.bottomImageView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.bottomImageView.userInteractionEnabled = YES;
    
    self.startBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,50,50)];
    [self.startBtn setImage:[UIImage imageNamed:@"视频_视频详情_播放_iocn"] forState:UIControlStateNormal];
    [self.startBtn setImage:[UIImage imageNamed:@"视频_视频详情_暂停_iocn"] forState:UIControlStateSelected];
//    self.startBtn.backgroundColor = [UIColor redColor];
    
    self.fullScreenBtn = [[UIButton alloc]init];
    [self.fullScreenBtn setImage:[UIImage imageNamed:@"视频_视频详情_全屏_icon"] forState:UIControlStateNormal];
    [self.fullScreenBtn setImage:[UIImage imageNamed:@"视频_视频详情_关闭全屏_icon"] forState:UIControlStateSelected];
    
    
    self.currentTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 10,60, 30)];
    self.currentTimeLabel.text = @"00:00";
    self.currentTimeLabel.textColor = [UIColor whiteColor];
    self.currentTimeLabel.textAlignment = NSTextAlignmentCenter;
    self.currentTimeLabel.font = [UIFont systemFontOfSize:15];
    self.totalTimeLabel = [[UILabel alloc]init];
    self.totalTimeLabel.textAlignment = NSTextAlignmentCenter;
    self.totalTimeLabel.font = [UIFont systemFontOfSize:15];
    self.totalTimeLabel.textColor = [UIColor whiteColor];
    self.totalTimeLabel.text = @"00:00";
    
    
    self.progressView = [[UIProgressView alloc]init];
    self.progressView.progressTintColor    = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
    self.progressView.trackTintColor       = [UIColor clearColor];
    
    
    
    // 设置slider
    self.videoSlider = [[UISlider alloc]init];
//    [self.videoSlider setThumbImage:[UIImage imageNamed:@"slider"] forState:UIControlStateNormal];
    self.videoSlider.minimumTrackTintColor = [UIColor whiteColor];
    self.videoSlider.maximumTrackTintColor = [UIColor colorWithRed:0.3 green:0.3 blue:0.3 alpha:0.3];
    
    [self.bottomImageView addSubview:self.startBtn];
    [self.bottomImageView addSubview:self.fullScreenBtn];
    [self.bottomImageView addSubview:self.currentTimeLabel];
    [self.bottomImageView addSubview:self.totalTimeLabel];
    [self.bottomImageView addSubview:self.progressView];
    [self.bottomImageView addSubview:self.videoSlider];
    
    [self addSubview:self.bottomImageView];
    
    
    self.activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [self addSubview:self.activity];
    
    self.volumeProgress = [[UIProgressView alloc]init];
    self.volumeProgress.transform = CGAffineTransformMakeRotation(-M_PI_2);
    self.volumeProgress.progressTintColor    = [UIColor whiteColor];
    self.volumeProgress.trackTintColor       = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.3];
//    [self addSubview:self.volumeProgress];
    
    
    NSError *error;
    
    [[AVAudioSession sharedInstance] setActive:YES error:&error];
    
    // add event handler, for this example, it is `volumeChange:` method
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeChanged:) name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
    

}
- (void)volumeChanged:(NSNotification *)notification
{
    // service logic here.
    NSLog(@"%@",notification.userInfo);
    NSString *valueStr = notification.userInfo[@"AVSystemController_AudioVolumeNotificationParameter"];
    self.volumeProgress.progress = [valueStr floatValue];
    
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    self.topImageView.frame = CGRectMake(0, 0,width, 44);
    self.titleLabel.frame = CGRectMake(44, 0, width-88, 44);
    self.bottomImageView.frame = CGRectMake(0,height-50, width, 50);
    self.bottomGradientLayer.frame = self.bottomImageView.bounds;
    self.topGradientLayer.frame    = self.topImageView.bounds;
    
    self.fullScreenBtn.frame = CGRectMake(width-50,0,50,50);
    self.rightBtn.frame = CGRectMake(width-44, 0, 44, 44);
    
    CGFloat progressWidth = width-2*(self.startBtn.frame.size.width+self.currentTimeLabel.frame.size.width);
    
    self.progressView.frame = CGRectMake(0,0,progressWidth,20);
    self.progressView.center = CGPointMake(width/2, 25);
    self.totalTimeLabel.frame = CGRectMake(width-110,10,60,30);
    self.videoSlider.frame = self.progressView.frame;
    self.activity.center = CGPointMake(width/2, height/2);
    self.volumeProgress.bounds = CGRectMake(0, 0,100,30);
    self.volumeProgress.center = CGPointMake(40,height/2);
    
}

- (void)initCAGradientLayer
{
//    //初始化Bottom渐变层
//    self.bottomGradientLayer            = [CAGradientLayer layer];
//    [self.bottomImageView.layer addSublayer:self.bottomGradientLayer];
//    //设置渐变颜色方向
//    self.bottomGradientLayer.startPoint = CGPointMake(0, 0);
//    self.bottomGradientLayer.endPoint   = CGPointMake(0, 1);
//    //设定颜色组
//    self.bottomGradientLayer.colors     = @[(__bridge id)[UIColor clearColor].CGColor,
//                                            (__bridge id)[UIColor blackColor].CGColor];
//    //设定颜色分割点
//    self.bottomGradientLayer.locations  = @[@(0.0f) ,@(1.0f)];
//    
    
    //初始Top化渐变层
    self.topGradientLayer               = [CAGradientLayer layer];
    [self.topImageView.layer addSublayer:self.topGradientLayer];
    //设置渐变颜色方向
    self.topGradientLayer.startPoint    = CGPointMake(1, 0);
    self.topGradientLayer.endPoint      = CGPointMake(1, 1);
    //设定颜色组
    self.topGradientLayer.colors        = @[ (__bridge id)[UIColor blackColor].CGColor,
                                             (__bridge id)[UIColor clearColor].CGColor];
    //设定颜色分割点
    self.topGradientLayer.locations     = @[@(0.0f) ,@(1.0f)];
    
}

-(void)showTopBottomView{
    if (!self.isTopBottomViewHidden) {
        return;
    }
    if (self.isAnimating) {
        return;
    }
    self.isAnimating = YES;
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    [UIView animateWithDuration:0.5 animations:^{
        self.topImageView.frame = CGRectMake(0, 0,width, 44);
        self.topImageView.alpha = 1;
        
        self.bottomImageView.frame = CGRectMake(0,height-50, width, 50);
        self.bottomImageView.alpha = 1;
    } completion:^(BOOL finished) {
        self.isTopBottomViewHidden = NO;
        self.isAnimating = NO;
    }];
}
-(void)hideTopBottomView{
    if (self.isAnimating) {
        return;
    }
    self.isAnimating = YES;
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    [UIView animateWithDuration:1 animations:^{
        self.topImageView.frame = CGRectMake(0, -44,width, 44);
        self.topImageView.alpha = 0;
        
        self.bottomImageView.frame = CGRectMake(0,height, width, 50);
        self.bottomImageView.alpha = 0;
    } completion:^(BOOL finished) {
        self.isTopBottomViewHidden = YES;
        self.isAnimating = NO;
    }];
     
}


-(void)dealloc{
    NSLog(@"%s",__func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
}


@end
