//
//  CompetitionEnrollCell_4.m
//  ONLY
//
//  Created by Dylan on 08/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "CompetitionEnrollCell_4.h"
#import "KrVideoPlayerController.h"
#import "ISVideoPlayer.h"
@interface CompetitionEnrollCell_4()
@property (nonatomic, strong) KrVideoPlayerController  *videoController;
@property (nonatomic, strong)ISVideoPlayer * player;
@end
@implementation CompetitionEnrollCell_4

- (void)awakeFromNib {
    [super awakeFromNib];

}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self performSelector:@selector(resetVC) withObject:nil afterDelay:0.01];
    
}

-(void)resetVC{
    self.videoController.frame = CGRectMake(0, 0, self.bgView.width,self.bgView.height);
    _player.frame = CGRectMake(0, 0, self.bgView.width,self.bgView.height);
}

-(void)playVideoWithUrlStr:(NSString *)urlStr{
    NSURL *url = [NSURL URLWithString:urlStr];
    [self addVideoPlayerWithURL:url];
}

- (void)addVideoPlayerWithURL:(NSURL *)url{
    if (!self.videoController) {
//        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        self.videoController = [[KrVideoPlayerController alloc] initWithFrame:CGRectMake(0, 0, self.bgView.width,self.bgView.height)];
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
            if (weakSelf.deleteVideo_block) {
                weakSelf.deleteVideo_block();
            }
        }];
        [self.videoController setWillBackOrientationPortrait:^{

        }];
        [self.videoController setWillChangeToFullscreenMode:^{

        }];
        [self.bgView addSubview:self.videoController.view];
    }
    self.videoController.contentURL = url;
    [self.videoController stop];
    
}
- (UITableView *)tableView
{
    UIView *tableView = self.superview;
    while (![tableView isKindOfClass:[UITableView class]] && tableView) {
        tableView = tableView.superview;
    }
    return (UITableView *)tableView;
}
-(void)dealloc{
    [self.videoController pause];
    self.videoController = nil;
}

@end
