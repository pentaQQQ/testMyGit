//
//  KrVideoPlayerControlView.h
//  KrVideoPlayerPlus
//
//  Created by JiaHaiyang on 15/6/19.
//  Copyright (c) 2015年 JiaHaiyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KrVideoPlayerControlView : UIView
//头部尾部工具条
@property (nonatomic, strong, readonly) UIView *topBar;
@property (nonatomic, strong, readonly) UIView *bottomBar;

//开始播放 暂停
@property (nonatomic, strong, readonly) UIButton *playButton;
@property (nonatomic, strong, readonly) UIButton *pauseButton;

//全屏 半瓶 按钮
@property (nonatomic, strong, readonly) UIButton *fullScreenButton;
@property (nonatomic, strong, readonly) UIButton *shrinkScreenButton;

//进度条
@property (nonatomic, strong, readonly) UISlider *progressSlider;
@property (nonatomic, strong, readonly) UILabel *timeLabel;

//让播放控件消失的按钮
@property (nonatomic, strong, readonly) UIButton *closeButton;

//返回按钮 喜欢按钮 分享按钮
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic ,strong) UIButton *likeButton;
@property (nonatomic ,strong) UIButton *shareButton;
@property (nonatomic ,strong) UILabel *titleLabel; //视频的标题
//系统菊花
@property (nonatomic, strong, readonly) UIActivityIndicatorView *indicatorView;


- (void)animateHide;
- (void)animateShow;
- (void)autoFadeOutControlBar;
- (void)cancelAutoFadeOutControlBar;

@end
