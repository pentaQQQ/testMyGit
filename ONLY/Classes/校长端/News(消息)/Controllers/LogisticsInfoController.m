//
//  LogisticsInfoController.m
//  ONLY
//
//  Created by Dylan on 20/04/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "LogisticsInfoController.h"

@interface LogisticsInfoController ()
@property (nonatomic,strong)UIWebView * webView;
@end

@implementation LogisticsInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
    [self setupUI];
}

-(void)setupNavi{
    self.title = @"物流信息";
}

-(void)setupUI{
    self.webView = [[UIWebView alloc]initWithFrame:self.view.frame];
    [self.webView loadHTMLString:[NSString stringWithFormat:@"https://m.kuaidi100.com/index_all.html?type=%@&postid=%@",self.item.gd_no,self.item.gd_sn] baseURL:nil];
    [self.view addSubview:self.webView];
}

@end
