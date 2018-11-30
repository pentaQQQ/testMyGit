//
//  HomePageSearchController.m
//  ONLY
//
//  Created by Dylan on 12/01/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "HomePageSearchController.h"
#import "HomePageNaviSearchView.h"
#import "PopoverView.h"
@interface HomePageSearchController ()

@end

@implementation HomePageSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
    [self setupUI];
}
-(void)setupNavi{
    self.title = @"";
    self.navigationItem.titleView = [self setupSearchView];
    self.navigationItem.hidesBackButton = YES;
//    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
//    [btn setTitle:@"caca" forState:UIControlStateNormal];
//    [btn jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
//        PopoverView *popoverView = [PopoverView popoverView];
//        [popoverView showToView:btn withActions:[self QQActions]];
//    }];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:btn];
}
-(void)setupUI{
    self.view.backgroundColor = [UIColor whiteColor];
}
-(UIView *)setupSearchView{
    HomePageNaviSearchView * view = [[[NSBundle mainBundle]loadNibNamed:@"HomePageNaviSearchView" owner:nil options:nil]lastObject];
    view.frame = CGRectMake(0, 0, screenWidth(), 40);
    kWeakSelf(view);
    view.btnAction_block = ^(NSInteger index){
        if (index == 1) {
            PopoverView *popoverView = [PopoverView popoverView];
            [popoverView showToView:weakview.typeBtn withActions:[self QQActions]];
            popoverView.style = PopoverViewStyleDark;
        }else if (index == 2){
            [self.navigationController popViewControllerAnimated:YES];
        }
    };
    return view;
}

- (NSArray<PopoverAction *> *)QQActions {
    // 加好友 action
    PopoverAction *productAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_addFri"] title:@"产品" handler:^(PopoverAction *action) {
        
    }];
    // 扫一扫 action
    PopoverAction *serviceAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_QR"] title:@"服务" handler:^(PopoverAction *action) {
        
    }];
    // 面对面快传 action
    PopoverAction *trainAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_facetoface"] title:@"培训" handler:^(PopoverAction *action) {
        
    }];
    // 付款 action
    PopoverAction *ideaAction = [PopoverAction actionWithImage:[UIImage imageNamed:@"right_menu_payMoney"] title:@"金点子" handler:^(PopoverAction *action) {
        
    }];
    
    return @[productAction, serviceAction, trainAction, ideaAction];
}

@end
