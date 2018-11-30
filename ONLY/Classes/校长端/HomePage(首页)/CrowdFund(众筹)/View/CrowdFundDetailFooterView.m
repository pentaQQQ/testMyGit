//
//  CrowdFundDetailFooterView.m
//  ONLY
//
//  Created by Dylan on 28/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "CrowdFundDetailFooterView.h"
@interface CrowdFundDetailFooterView()<UIWebViewDelegate>

@end
@implementation CrowdFundDetailFooterView

-(void)awakeFromNib{
    [super awakeFromNib];
   
    
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.scalesPageToFit = YES;

    self.segmentView.sectionTitles = @[@"产品详情", @"产品规格"];
    self.segmentView.selectedSegmentIndex = 0;
    self.segmentView.backgroundColor = [UIColor clearColor];
    self.segmentView.titleTextAttributes = @{NSForegroundColorAttributeName : colorWithRGB(0x333333),NSFontAttributeName:[UIFont systemFontOfSize:16]};
    self.segmentView.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : colorWithRGB(0x008CCF)};
    self.segmentView.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.segmentView.selectionIndicatorColor = colorWithRGB(0x008CCF);
    
    __weak typeof(self) weakSelf = self;
    [self.segmentView setIndexChangeBlock:^(NSInteger index) {
        if (index == 0) {
            [weakSelf.webView stopLoading];
            [weakSelf.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.item.good_desc]]];
        }else if (index == 1){
            [weakSelf.webView stopLoading];
            [weakSelf.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.item.good_specifications]]];
        }
    }];

}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.segmentView.selectionIndicatorHeight = 1;
    self.segmentView.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentView.selectionIndicatorBoxOpacity = 1;
}

-(void)setItem:(CrowdFundItem *)item{
    _item = item;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.item.good_desc]]];
}

#pragma --mark - UIWebView Delegate Methods
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    //获取到webview的高度
    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.offsetHeight"] floatValue];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, screenWidth(), height+50);
    self.reload_block(self);
    self.segmentView.userInteractionEnabled = YES;

    
}
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    return YES;
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    self.segmentView.userInteractionEnabled = YES;
}
@end
