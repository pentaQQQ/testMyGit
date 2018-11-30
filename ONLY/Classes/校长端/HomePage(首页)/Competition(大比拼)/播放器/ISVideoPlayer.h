//
//  ISVideoPlayer.h
//  ISWorldCollege
//
//  Created by Dylan on 8/31/16.
//  Copyright © 2016 IdeaSource. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ISVideoPlayerView.h"
@class ISVideoPlayer;

@protocol ISVideoPlayerDelegate<NSObject>
-(void)playerWillEnterFullScreen:(ISVideoPlayer *)player;
-(void)playerWillEnterSmallScreen:(ISVideoPlayer *)player;
@end
@interface ISVideoPlayer : UIView

/** 视频URL */
@property (nonatomic, strong) NSURL   *videoURL;
@property (nonatomic, strong) NSString * videoName;
@property(nonatomic,strong)ISVideoPlayerView *maskView;
@property (nonatomic, weak) id<ISVideoPlayerDelegate>delegate;
-(void)play;
-(void)stopPlay;
-(void)recycle;
@end
