//
//  MineDownLoadDetailController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/7/17.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineDownLoadDetailController.h"

@interface MineDownLoadDetailController ()

@end

@implementation MineDownLoadDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = WhiteColor;
    self.title = @"下载到百度云";
    UIWebView *web = [[UIWebView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:web];
    [web loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.downloadUrl]]];
    
}


@end
