//
//  HomePageController.m
//  ONLY
//
//  Created by 上海点硕 on 2016/12/17.
//  Copyright © 2016年 cbl－　点硕. All rights reserved.
//

#import "HomePageController.h"
#import "SearchController.h"
#import "CrowdFundDetailController.h"
#import "ConferenceController.h"
#import "ConferenceDetailController.h"
#import "ServiceDetailController.h"
#import "OnlyNewsListController.h"
#import "OnlyNewsDetailController.h"

#import "HomePageHeaderView.h"
#import "HomePageCell_1.h"
#import "HomePageCell_2.h"
#import "HomePageCell_3.h"
#import "XRCarouselView.h"

#import "CrowdFundItem.h"
#import "ServiceItem.h"
#import "ConferenceItem.h"
#import "OnlyNewsItem.h"

#import "UIBarButtonItem+Create.h"
#import "HomeBannerDetailViewController.h"


#import "PaySuccessController.h"


@interface HomePageController ()<UITableViewDelegate,UITableViewDataSource,XRCarouselViewDelegate>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)XRCarouselView * bannerView;
@property(nonatomic,strong)NSMutableArray * crowdFundArray;
@property(nonatomic,strong)NSMutableArray * conferenceArray;
@property(nonatomic,strong)NSMutableArray * serviceArray;
@property(nonatomic,strong)NSMutableArray * bannerImageArray;
@property(nonatomic,strong)NSMutableArray * bannerUrlArray;
@property(nonatomic,strong)NSMutableArray * onlyNewsArray;
@end

@implementation HomePageController
-(NSMutableArray *)crowdFundArray{
    if (!_crowdFundArray) {
        _crowdFundArray = [NSMutableArray new];
    }
    return _crowdFundArray;
}
-(NSMutableArray *)conferenceArray{
    if (!_conferenceArray) {
        _conferenceArray = [NSMutableArray new];
    }
    return _conferenceArray;
}
-(NSMutableArray *)serviceArray{
    if (!_serviceArray) {
        _serviceArray = [NSMutableArray new];
    }
    return _serviceArray;
}
-(NSMutableArray *)bannerImageArray{
    if (!_bannerImageArray) {
        _bannerImageArray = [NSMutableArray new];
    }
    return _bannerImageArray;
}
-(NSMutableArray *)bannerUrlArray{
    if (!_bannerUrlArray) {
        _bannerUrlArray = [NSMutableArray new];
    }
    return _bannerUrlArray;
}
-(NSMutableArray *)onlyNewsArray{
    if (!_onlyNewsArray) {
        _onlyNewsArray = [NSMutableArray new];
    }
    return _onlyNewsArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
    [self setupUI];
    [self getData];
}

-(void)setupNavi{
    self.view.backgroundColor = WhiteColor;
    self.navigationItem.title = @"首页";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:@"HomePage_Search" complete:^{
         [SearchController presentToSearchControllerWithContext:self type:SearchTypeGoods];
    }];
}

-(void)setupUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, screenWidth(), screenHeight()-Nav) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.tableHeaderView = [self setupBannerView];
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self getData];
    }];
    [self.view addSubview:self.tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"HomePageCell_1" bundle:nil] forCellReuseIdentifier:@"HomePageCell_1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomePageCell_2" bundle:nil] forCellReuseIdentifier:@"HomePageCell_2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HomePageCell_3" bundle:nil] forCellReuseIdentifier:@"HomePageCell_3"];
}

-(UIView *)setupBannerView{
    self.bannerView = [[XRCarouselView alloc]initWithFrame:CGRectMake(0, 0, screenWidth(), 225*SCREEN_PRESENT)];
    self.bannerView.delegate = self;
    self.bannerView.contentMode = UIViewContentModeScaleAspectFill;
    UIImage * image = [UIImage imageNamed:@"blank"];
    [self.bannerView setImageArray:@[image,image]];
    [self.bannerView setPageImage:[UIImage imageNamed:@"empty_oval"] andCurrentPageImage:[UIImage imageNamed:@"solid_oval"]];
    return self.bannerView;
}

//轮播图的点击事件
- (void)carouselView:(XRCarouselView *)carouselView clickImageAtIndex:(NSInteger)index
{
    HomeBannerDetailViewController *vc  = [HomeBannerDetailViewController new];
    vc.url = self.bannerUrlArray[index];
    [self.navigationController pushViewController:vc animated:YES];
    
//    PaySuccessController *vc  = [PaySuccessController new];
//    [self.navigationController pushViewController:vc animated:YES];
}

-(void)reloadData{
    [self.bannerView setImageArray:self.bannerImageArray];
    [self.tableView reloadData];
}

-(void)getData{
    kWeakSelf(self);
    [DataSourceTool homePageWithParam:nil toViewController:weakself success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"errcode"]integerValue]==0) {
            [weakself.tableView.mj_header endRefreshing];
            [weakself.serviceArray removeAllObjects];
            [weakself.crowdFundArray removeAllObjects];
            [weakself.conferenceArray removeAllObjects];
            [weakself.bannerImageArray removeAllObjects];
            [weakself.onlyNewsArray removeAllObjects];
            
            NSArray * crowdFundArray = json[@"good"];
            for (NSDictionary * dic in crowdFundArray) {
                CrowdFundItem * item = [CrowdFundItem new];
                [item setValuesForKeysWithDictionary:dic];
                [weakself.crowdFundArray addObject:item];
            }
            
            
            NSArray * serviceArray = json[@"service"];
            for (NSDictionary * dic in serviceArray) {
                ServiceItem * item = [ServiceItem new];
                [item setValuesForKeysWithDictionary:dic];
                [weakself.serviceArray addObject:item];
            }
            
            for (NSDictionary * dic in json[@"course"]) {
                ConferenceItem * item = [ConferenceItem new];
                [item setValuesForKeysWithDictionary:dic];
                [weakself.conferenceArray addObject:item];
            }
            
            for (NSDictionary * dic in json[@"banner"]) {
                NSString * urlStr = [NSString stringWithFormat:@"%@%@",Choose_Base_URL,dic[@"ad_img"]];
                NSString *tempStr = [NSString stringWithFormat:@"%@",dic[@"ad_url"]];
                [weakself.bannerImageArray addObject:urlStr];
                [weakself.bannerUrlArray addObject:tempStr];
            }
            
            for (NSDictionary * dic in json[@"news"]) {
                OnlyNewsItem * item = [OnlyNewsItem new];
                [item setValuesForKeysWithDictionary:dic];
                [weakself.onlyNewsArray addObject:item];
            }
            [weakself reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
        [weakself.tableView.mj_header endRefreshing];
    }];
}

#pragma mark -UITbleViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 5;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section>1) {
        return 40;
    }else{
        return 0.01;
    }
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section < 2) {
        return nil;
    }
    
    static NSString *viewIdentfier = @"headView";
    
    HomePageHeaderView * sectionHeadView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewIdentfier];
    kWeakSelf(self);
    if(!sectionHeadView){
        
        sectionHeadView = [[HomePageHeaderView alloc] initWithReuseIdentifier:viewIdentfier];
        [sectionHeadView setBtnAction_block:^{
            if (section == 2) {
                [weakself.navigationController pushViewController:[NSClassFromString(@"CrowdFundController") new] animated:YES];
            }else if (section == 3){
                [weakself.navigationController pushViewController:[NSClassFromString(@"ConferenceController") new] animated:YES];
            }else if (section == 4){
                [weakself.navigationController pushViewController:[NSClassFromString(@"ServiceController") new] animated:YES];
            }

        }];
    }
    if (section == 2) {
        sectionHeadView.titleLabel.text = @"热门众筹";
    }
    if (section == 3) {
        sectionHeadView.titleLabel.text = @"热门培训";
    }
    if (section == 4) {
        sectionHeadView.titleLabel.text = @"热门服务";
    }
    
    return sectionHeadView;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    kWeakSelf(self);
    if (indexPath.section == 0) {
        HomePageCell_1 * cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageCell_1"];
        cell.indexPath = indexPath;
        cell.btnAction_block = ^(NSInteger index){
            [weakself pushToController:index indexPath:indexPath];
        };
        return cell;
    }
    else if (indexPath.section == 1){
        HomePageCell_2 * cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageCell_2"];
        cell.indexPath = indexPath;
        cell.dataArray = self.onlyNewsArray;
        [cell setNewsDetail_block:^(NSInteger index) {
            OnlyNewsItem * item = weakself.onlyNewsArray[index];
            OnlyNewsDetailController * vc = [OnlyNewsDetailController new];
            vc.item = item;
            [weakself.navigationController pushViewController:vc animated:YES];
        }];
        cell.btnAction_block = ^(NSInteger index){
            if (index == 1) {
                
            }else{
                OnlyNewsListController * vc = [OnlyNewsListController new];
                [self.navigationController pushViewController:vc animated:YES];
            }
        };
        return cell;
    }
    else{
        HomePageCell_3 * cell = [tableView dequeueReusableCellWithIdentifier:@"HomePageCell_3"];
        cell.indexPath = indexPath;
        cell.btnAction_block = ^(id item){
            [weakself pushToDetailControllerWithItem:item];
        };
        if (indexPath.section == 2) {
            cell.dataArray = self.crowdFundArray;
        }
        if (indexPath.section == 3) {
            cell.dataArray = self.conferenceArray;
        }
        if (indexPath.section == 4) {
            cell.dataArray = self.serviceArray;
        }
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 2) {
        [self.navigationController pushViewController:[NSClassFromString(@"CrowdFundController") new] animated:YES];
    }
    if (indexPath.section == 4) {
        [self.navigationController pushViewController:[NSClassFromString(@"ServiceController") new] animated:YES];
    }
    
}
#pragma mark 私有方法
-(void)pushToController:(NSInteger)index indexPath:(NSIndexPath*)indexPath{
    if (indexPath.section == 0) {
        switch (index) {
            case 1:{
                [self.navigationController pushViewController:[NSClassFromString(@"CrowdFundController") new] animated:YES];
                break;
            }
            case 2:{
                [self.navigationController pushViewController:[NSClassFromString(@"ConferenceController") new] animated:YES];
                break;
            }
            case 3:{
                [self.navigationController pushViewController:[NSClassFromString(@"ServiceController") new] animated:YES];
                break;
            }
            case 4:{
                [self.navigationController pushViewController:[NSClassFromString(@"CompetitionListController") new] animated:YES];
                break;
            }
            case 5:{
                [self.navigationController pushViewController:[NSClassFromString(@"IdeaController") new] animated:YES];
                break;
            }
            case 6:{
                [self.navigationController pushViewController:[NSClassFromString(@"DownloadController") new] animated:YES];
                break;
            }
            default:
                break;
        }
    }
}

-(void)pushToDetailControllerWithItem:(id)item {
    kWeakSelf(self);
    if ([item isKindOfClass:[CrowdFundItem class]]) {
        CrowdFundDetailController * vc = [CrowdFundDetailController new];
//        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//        CATransition *transition = [CATransition animation];
//        transition.duration = 0.5;
//        transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        transition.type = kCAScrollBoth;
//        transition.subtype = kCATransitionFromTop;
//        transition.delegate = self;
//        [self.navigationController.view.layer addAnimation:transition forKey:nil];
//        vc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        vc.status = [((CrowdFundItem*)item).status integerValue];
        vc.item = item;
        [weakself.navigationController pushViewController:vc animated:YES];
    }
    if ([item isKindOfClass:[ConferenceItem class]]) {
        ConferenceDetailController * vc = [ConferenceDetailController new];
        vc.item = item;
        [weakself.navigationController pushViewController:vc animated:YES];
    }
    if ([item isKindOfClass:[ServiceItem class]]) {
        ServiceDetailController * vc = [ServiceDetailController new];
        vc.item = item;
        [weakself.navigationController pushViewController:vc animated:YES];
    }
}
@end
