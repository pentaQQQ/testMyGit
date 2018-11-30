//
//  OnlyNewsDetailController.m
//  ONLY
//
//  Created by Dylan on 20/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "OnlyNewsDetailController.h"

@interface OnlyNewsDetailController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView * webView;

@end

@implementation OnlyNewsDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"详情";
    self.webView = [[UIWebView alloc]initWithFrame:CGRectZero];
    self.webView.delegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,self.item.detailUrl] relativeToURL:[[NSBundle mainBundle] bundleURL]]]];
    
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
