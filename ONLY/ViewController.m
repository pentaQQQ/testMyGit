//
//  ViewController.m
//  ONLY
//
//  Created by 上海点硕 on 2016/12/17.
//  Copyright © 2016年 cbl－　点硕. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    UIButton *btn = [UIButton new];
    [self.view addSubview:btn];
    btn.backgroundColor =BlackColor;
    btn.frame = CGRectMake(100, 100, 100, 100);
    
    [btn jk_addActionHandler:^(NSInteger tag) {
       
    }];
   
}

@end
