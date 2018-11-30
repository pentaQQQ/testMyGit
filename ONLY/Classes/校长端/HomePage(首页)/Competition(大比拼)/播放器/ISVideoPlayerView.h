//
//  ISVideoPlayerView.h
//  ISWorldCollege
//
//  Created by Dylan on 8/31/16.
//  Copyright © 2016 IdeaSource. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ISVideoPlayerView : UIView
/** 视频标题 */
@property (strong, nonatomic)  UILabel       *titleLabel;
/** 返回按钮 */
@property (strong, nonatomic)  UIButton       *backBtn;
/** 右上角自定义按钮 */
@property (strong, nonatomic)  UIButton       *rightBtn;

/** 开始播放按钮 */
@property (strong, nonatomic)  UIButton       *startBtn;
/** 当前播放时长label */
@property (strong, nonatomic)  UILabel        *currentTimeLabel;
/** 视频总时长label */
@property (strong, nonatomic)  UILabel        *totalTimeLabel;
/** 缓冲进度条 */
@property (strong, nonatomic)  UIProgressView *progressView;
/** 滑杆 */
@property (strong, nonatomic)  UISlider       *videoSlider;
/** 全屏按钮 */
@property (strong, nonatomic)  UIButton       *fullScreenBtn;
@property (strong, nonatomic)  UIButton       *lockBtn;
/** 音量进度 */
@property (nonatomic,strong) UIProgressView   *volumeProgress;

/** 系统菊花 */
@property (nonatomic,strong)UIActivityIndicatorView *activity;

@property (nonatomic,assign)BOOL isTopBottomViewHidden;
@property (nonatomic,assign)BOOL isAnimating;

-(void)hideTopBottomView;
-(void)showTopBottomView;

@end
