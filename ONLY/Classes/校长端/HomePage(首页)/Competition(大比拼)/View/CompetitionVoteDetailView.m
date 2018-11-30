//
//  CompetitionVoteDetailView.m
//  ONLY
//
//  Created by Dylan on 15/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "CompetitionVoteDetailView.h"
#import "KrVideoPlayerController.h"
@interface CompetitionVoteDetailView()

@property (nonatomic, strong) KrVideoPlayerController  *videoController;

@end

@implementation CompetitionVoteDetailView
@synthesize photoArray = _photoArray;


-(NSMutableArray *)photoArray{
    if (!_photoArray) {
        _photoArray = [NSMutableArray new];
    }
    return _photoArray;
}

-(void)setPhotoArray:(NSMutableArray *)photoArray{
    _photoArray = photoArray;
    if (photoArray.count==0) {
        for (UIImageView * imageView in self.photoIVArray) {
            [imageView removeFromSuperview];
        }
    }else{
        for (int i=0; i<3; i++) {
            UIImageView * imageView = self.photoIVArray[i];
            if (i<photoArray.count) {
                [imageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,photoArray[i]]]];
            }else{
                [imageView removeFromSuperview];
            }
        }
    }
}
-(void)setVideoUrlStr:(NSString *)videoUrlStr{
    _videoUrlStr = videoUrlStr;
    if (videoUrlStr.length > 0) {
        [self playVideoWithUrlStr:videoUrlStr];
    }else{
        [self.videoBgView removeFromSuperview];
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self performSelector:@selector(resetVC) withObject:nil afterDelay:0.01];
    
}

-(void)resetVC{
    self.videoController.frame = CGRectMake(0, 0, self.videoBgView.width,self.videoBgView.height);
}

-(void)playVideoWithUrlStr:(NSString *)urlStr{
    NSURL *url = [NSURL URLWithString:urlStr];
    [self addVideoPlayerWithURL:url];
}

- (void)addVideoPlayerWithURL:(NSURL *)url{
    if (!self.videoController) {
        self.videoController = [[KrVideoPlayerController alloc] initWithFrame:CGRectMake(0, 0, self.videoBgView.width,self.videoBgView.height)];
        self.videoController.videoControl.topBar.hidden = YES;

        [self.videoBgView addSubview:self.videoController.view];
    }
    self.videoController.contentURL = url;
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
