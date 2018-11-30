//
//  KrVideoPlayerController.h
//  KrVideoPlayerPlus
//
//  Created by JiaHaiyang on 15/6/19.
//  Copyright (c) 2015年 JiaHaiyang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KrVideoPlayerControlView.h"
@import MediaPlayer;

@interface KrVideoPlayerController : MPMoviePlayerController
/** video.view 消失 */
@property (nonatomic, copy)void(^dimissCompleteBlock)(void);
/** 进入最小化状态 */
@property (nonatomic, copy)void(^willBackOrientationPortrait)(void);
/** 进入全屏状态 */
@property (nonatomic, copy)void(^willChangeToFullscreenMode)(void);

//点击喜欢按钮
@property (nonatomic,copy)void(^shareBtnClick)(void);
@property (nonatomic,copy)void(^likeBtnClick)(void);
@property (nonatomic,copy)void(^backBtnClick)(void);

@property (nonatomic, strong) KrVideoPlayerControlView *videoControl;
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, copy ) NSString *title;
@property (nonatomic,assign)BOOL hidden;
- (instancetype)initWithFrame:(CGRect)frame;
- (void)showInWindow;
- (void)dismiss;
/**
 *  获取视频截图
 */
+ (UIImage*) thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time;
- (void)shrinkScreenButtonClick;

@end
