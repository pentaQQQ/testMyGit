//
//  HomeBannerDetailViewController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/7/7.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "HomeBannerDetailViewController.h"

@interface HomeBannerDetailViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView * webView;

@end

@implementation HomeBannerDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    self.webView = [[UIWebView alloc]initWithFrame:CGRectZero];
    
    self.webView.delegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    [self.view addSubview:self.webView];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
}


#pragma --mark - UIWebView Delegate Methods
-(void)webViewDidFinishLoad:(UIWebView *)webView
{

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    return YES;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

@end
