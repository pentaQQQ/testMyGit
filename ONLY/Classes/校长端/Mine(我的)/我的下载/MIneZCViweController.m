//
//  MIneZCViweController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/2/6.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MIneZCViweController.h"
#import "HMSegmentedControl.h"
#import "CrowdFundListCell.h"
#import "MineAdviseCell.h"
#import "CrowdFundDetailController.h"
#import "MineZCDetailController.h"
#import "ZCModel.h"
@interface MIneZCViweController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)HMSegmentedControl * segmentControl;
@end

@implementation MIneZCViweController
{
    UIView * _segmentBGView;
    UITableView * tableview;
    NSInteger IsCell;
    NSMutableArray *phurseArray;
    NSMutableArray *adviseArray;
    NSMutableArray *thumbArray;
    NSMutableArray *dataArray;
    NSInteger  pageIndex;
    NSString *url;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    pageIndex = 1;
    IsCell = 0;
    url = @"0";
    
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = WhiteColor;
    dataArray = [NSMutableArray array];
    [self setNavView];
    [self setupSegment];
    [self loadPhurseData];
}

//创建导航栏（自定义）
- (void)setNavView
{
    UIView *view  = [UIView new];
    view.backgroundColor = colorWithRGB(0x00A9EB);
    [self.view addSubview:view];
    view.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).topEqualToView(self.view).heightIs(64);
    
    UIButton *backBtn = [UIButton new];
    [view addSubview:backBtn];
    [backBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    backBtn.sd_layout.leftSpaceToView(view,8).topSpaceToView(view,25).heightIs(30).widthIs(30);
    [backBtn jk_addActionHandler:^(NSInteger tag) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }];
    
    UILabel *titleLabel = [UILabel new];
    [view addSubview:titleLabel];
    titleLabel.textColor= WhiteColor;
    titleLabel.font = font(18);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.sd_layout.leftSpaceToView(view,50).rightSpaceToView(view,50).heightIs(17).topSpaceToView(view,35);
    titleLabel.text = @"我的众筹";
    
    tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:tableview];
    tableview.sd_layout.topSpaceToView(self.view,108).bottomSpaceToView(self.view,0).rightEqualToView(self.view).leftEqualToView(self.view);
    tableview.rowHeight = 326;
    tableview.delegate = self;
    tableview.dataSource = self;
    [tableview setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    //MineAdviseCell
    [tableview registerNib:[UINib nibWithNibName:@"CrowdFundListCell" bundle:nil] forCellReuseIdentifier:@"CrowdFundListCell"];
    
    [tableview registerNib:[UINib nibWithNibName:@"MineAdviseCell" bundle:nil] forCellReuseIdentifier:@"MineAdviseCell"];
    kWeakSelf(self);
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself reloadData];
    }];
    tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakself loadPhurseData];
    }];
}

-(void)setupSegment{
    
    _segmentBGView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, screenWidth(), 44)];
    _segmentBGView.backgroundColor = colorWithRGB(0x00A9EB);;
    self.segmentControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH-10, 40)];
   
    self.segmentControl.sectionTitles = @[@"已购买", @"已点赞", @"已提议"];
    self.segmentControl.selectedSegmentIndex = 0;
    self.segmentControl.backgroundColor = [UIColor clearColor];
    self.segmentControl.titleTextAttributes = @{NSForegroundColorAttributeName : kRGBColor(191,221,233),NSFontAttributeName:[UIFont systemFontOfSize:14]};
    self.segmentControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.segmentControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.segmentControl.selectionIndicatorColor = [UIColor whiteColor];
    self.segmentControl.selectionIndicatorHeight = 2;
    self.segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentControl.selectionIndicatorBoxOpacity = 1;
    
    kWeakSelf(self);
    
    [self.segmentControl setIndexChangeBlock:^(NSInteger index) {
        if (index == 0) {
            pageIndex = 1;
            IsCell = 0;
            url = @"0";
           
        }
        else if(index==1)
        {
            pageIndex = 1;
            IsCell = 1;
            url = @"1";
        }
        else
        {
            pageIndex = 1;
            IsCell=2;
            url = @"2";
        }
         [weakself loadPhurseData];
    }];
    
    [_segmentBGView addSubview:self.segmentControl];
    
    [self.view addSubview:_segmentBGView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IsCell==0||IsCell==1) {
        return 326*SCREEN_PRESENT;
    }
    else
    {
        return 120;
    }

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CrowdFundListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CrowdFundListCell"];
    MineAdviseCell * cell1 = [tableView dequeueReusableCellWithIdentifier:@"MineAdviseCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (IsCell==0||IsCell==1) {
        CrowdFundItem * item =dataArray[indexPath.row];
        cell.item = item;
        return cell;
    }
    else
    {
        ZCModel *model = dataArray[indexPath.row];
        cell1.adviseTitle.text = model.apply_name;
        cell1.adviseTime.text = [self becomeTime:model.add_time];
        if ([model.status isEqualToString:@"0"]) {
           //审核状态 0未审核1审核通过2审核未通过
            cell1.adviseStatus.text = @"未审核";
        }
        else if ([model.status isEqualToString:@"1"])
        {
            cell1.adviseStatus.text = @"审核通过";
        }
        else
        {
           cell1.adviseStatus.text = @"审核失败";
        }
        return cell1;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (IsCell==0||IsCell==1) {
        CrowdFundItem * item = dataArray[indexPath.row];
        CrowdFundDetailController * vc = [CrowdFundDetailController new];
        vc.status = CrowdFundStatus_Requset;
        vc.item = item;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        ZCModel *model = dataArray[indexPath.row];
        MineZCDetailController *vc  =[MineZCDetailController new];
        vc.apply_id = model.apply_id;
        vc.apply_time = [self becomeTime:model.add_time];
        vc.apply_name = model.apply_name;
        if ([model.status isEqualToString:@"0"]) {
        //审核状态 0未审核1审核通过2审核未通过
            vc.apply_status = @"未审核";
        }
        else if ([model.status isEqualToString:@"1"])
        {
            vc.apply_status = @"审核通过";
        }
        else
        {
            vc.apply_status = @"审核失败";
        }

        [self.navigationController pushViewController:vc animated:YES];
        
    }
}

//加载已购买数据
- (void)loadPhurseData
{
   
    [DataSourceTool purchaseListPage:[NSString stringWithFormat:@"%ld",pageIndex] pageSize:@"5" Url:url ViewController:self success:^(id json) {
        if ([json[@"errcode"] integerValue]==0) {

            if (pageIndex==1)
            {
                [dataArray removeAllObjects];
                [tableview.mj_header endRefreshing ];
                [tableview.mj_footer endRefreshing];
            }
            else {
                if (((NSArray*)json[@"data"]).count == 0) {
                    [tableview.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [tableview.mj_footer endRefreshing];
                }
                }
            
            pageIndex++;
            
            for (NSDictionary * dic in json[@"data"]) {
                if (IsCell==0||IsCell==1) {
                    CrowdFundItem * item = [CrowdFundItem new];
                    [item setValuesForKeysWithDictionary:dic];
                    [dataArray addObject:item];
                    
                }
                else
                {
                    ZCModel *model = [ZCModel new];
                    [model setValuesForKeysWithDictionary:dic];
                    [dataArray addObject:model];
                }
                [tableview reloadData];
            }
            

        }else {
            [tableview.mj_header endRefreshing];
            [tableview.mj_footer endRefreshing];
        }
        
   } failure:^(NSError *error) {
      
   }];
}

//下拉刷新数据
-(void)reloadData
{
    pageIndex = 1;
    
    [self loadPhurseData];
}

- (NSString *)becomeTime:(NSString *)time
{
    NSDateFormatter* formatter = [NSDateFormatter new];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *dt = [NSDate dateWithTimeIntervalSince1970:[time integerValue]];
    
    NSString *nowtimeStr = [formatter stringFromDate:dt];
    
    return nowtimeStr;
    
}
@end
