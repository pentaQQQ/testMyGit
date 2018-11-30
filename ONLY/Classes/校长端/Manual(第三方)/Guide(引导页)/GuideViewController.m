//
//  GuideViewController.m
//  Choose
//
//  Created by George on 16/11/11.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController ()<UIScrollViewDelegate>
{
    UIScrollView *scrollview;
    UIPageControl *pageControl;
//    BFPaperButton *lookButton;
//    BFPaperButton *loginButton;
    CGFloat width;
    CGFloat hight;
    NSArray *dataSource;
}

@property (nonatomic, strong) UIViewController *mainController;
@property (nonatomic, strong) UIViewController *loginController;
@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self prefersStatusBarHidden];
    width=self.view.bounds.size.width;
    hight=self.view.bounds.size.height;
    scrollview=[[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollview.userInteractionEnabled = YES;
    [scrollview setDelegate:self];
    dataSource = @[@"bg1", @"bg2", @"bg3"];
    
    for (int i=0; i<dataSource.count; i++) {
        UIImageView *imageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:dataSource[i]]];
        [imageView setFrame:CGRectMake(i*width, 0, width, hight)];
        imageView.userInteractionEnabled = YES;
        imageView.tag = 100+i;
        [scrollview  addSubview:imageView];
        
        UIButton *jumpBtn  = [UIButton new];
        [jumpBtn setTitle:@"跳过" forState:UIControlStateNormal];
        [imageView addSubview:jumpBtn];
        [jumpBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
        jumpBtn.sd_layout.rightSpaceToView(imageView,20).topSpaceToView(imageView,20).heightIs(33).widthIs(33);
        jumpBtn.titleLabel.font = font(14);
        jumpBtn.layer.borderWidth = 1;
        jumpBtn.layer.borderColor = WhiteColor.CGColor;
        jumpBtn.layer.cornerRadius = 16.5;
        jumpBtn.layer.masksToBounds = YES;
        if(i == 2)
        {
            [jumpBtn setHidden:YES];
            
            UIButton *Btn  = [UIButton new];
            [Btn setTitle:@"立即体验" forState:UIControlStateNormal];
            [imageView addSubview:Btn];
            [Btn setTitleColor:WhiteColor forState:UIControlStateNormal];
            Btn.sd_layout.rightSpaceToView(imageView,143*SCREEN_PRESENT).bottomSpaceToView(imageView,95).heightIs(32).widthIs(90);
            Btn.titleLabel.font = font(14);
            Btn.layer.borderWidth = 1;
            Btn.layer.borderColor = WhiteColor.CGColor;
            Btn.layer.cornerRadius = 3;
            Btn.layer.masksToBounds = YES;
            [Btn jk_addActionHandler:^(NSInteger tag) {
                
                [self enterLogin];
                
            }];
        }
        
        [jumpBtn jk_addActionHandler:^(NSInteger tag) {
            
            [self enterLogin];
            
        }];
    }
    [scrollview setContentSize:CGSizeMake(width*dataSource.count, hight)];
    [scrollview setBounces:NO];
    
    //滚动时是否水平显示滚动条
    [scrollview setShowsHorizontalScrollIndicator:NO];
    //分页显示
    [scrollview setPagingEnabled:YES];
    
    
    pageControl = [UIPageControl new];
    [pageControl setBackgroundColor:[UIColor clearColor]];
    pageControl.currentPage = 0;
    pageControl.numberOfPages = dataSource.count;
    
    [pageControl addTarget:self action:@selector(click) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:scrollview];
    [self.view addSubview:pageControl];
    
//最后一页佳按钮的地方
    for (UIView *image in scrollview.subviews) {
        if (image.tag == 102) {
            
            //[self addButtonInSuperView:(UIImageView *)image];
            
            break;
        }
    }
    
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        make.centerX.equalTo(self.view);
    }];
}

- (void) click{
    NSLog(@"xxx");
}

//减速停止了时执行，手触摸时执行执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int index= scrollview.contentOffset.x/width;
    [pageControl setCurrentPage:index];
}

-(instancetype)initWithMainController:(UIViewController *)mainController loginController:(UIViewController *)loginController {
    self = [super init];
    if (self) {
        self.mainController = mainController;
        self.loginController = loginController;
    }
    return self;
}


- (void)enterLogin
{
    [self loginTransition:TransitionAnimTypeReveal];
}

-(void)enterLook {
    [self lookTransition:TransitionAnimTypeSuckEffect];
}

- (void)loginTransition:(TransitionAnimType)type
{
    [UIApplication sharedApplication].delegate.window.rootViewController = self.loginController;
    [[UIApplication sharedApplication].delegate.window.layer transitionWithAnimType:type subType:TransitionSubtypesFromRight curve:TransitionCurveLinear duration:0.6f];
}

- (void)lookTransition:(TransitionAnimType)type
{
    [UIApplication sharedApplication].delegate.window.rootViewController = self.mainController;
    [[UIApplication sharedApplication].delegate.window.layer transitionWithAnimType:type subType:TransitionSubtypesFromRight curve:TransitionCurveLinear duration:0.6f];
}

- (BOOL)prefersStatusBarHidden { //设置隐藏显示
    return YES;
}
@end
