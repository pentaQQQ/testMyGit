//
//  MinePXController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/2/7.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MinePXController.h"
#import "HMSegmentedControl.h"
#import "ConferenceCell.h"
#import "MineAdviseCell.h"
#import "ConferenceDetailController.h"
#import "MineZCDetailController.h"
#import "ZCModel.h"
#import "ConferenceItem.h"
@interface MinePXController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)HMSegmentedControl * segmentControl;
@end

@implementation MinePXController
{
    UIView * _segmentBGView;
    UITableView * tableview;
    NSInteger IsCell;
    NSInteger pageIndex;
    NSMutableArray *dataArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = WhiteColor;
    IsCell = 0;
    pageIndex = 1;
    
    [self setNavView];
    [self setupSegment];
    
    [self loadData];
    
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
    titleLabel.text = @"我的培训";
    
    tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:tableview];
    tableview.sd_layout.topSpaceToView(self.view,108).bottomSpaceToView(self.view,0).rightEqualToView(self.view).leftEqualToView(self.view);
    tableview.rowHeight = 326;
    tableview.delegate = self;
    tableview.dataSource = self;
    //MineAdviseCell
    [tableview registerNib:[UINib nibWithNibName:@"ConferenceCell" bundle:nil] forCellReuseIdentifier:@"ConferenceCell"];
    [tableview setTableFooterView:[UIView new]];
    [tableview registerNib:[UINib nibWithNibName:@"MineAdviseCell" bundle:nil] forCellReuseIdentifier:@"MineAdviseCell"];
    kWeakSelf(self);
    tableview.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakself reloadData];
    }];
    tableview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakself loadData];
    }];
}

-(void)setupSegment{
    _segmentBGView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, screenWidth(), 44)];
    _segmentBGView.backgroundColor = colorWithRGB(0x00A9EB);;
    self.segmentControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH-10, 40)];
    
    self.segmentControl.sectionTitles = @[@"已购买", @"已关注", @"已提议"];
    self.segmentControl.selectedSegmentIndex = 0;
    self.segmentControl.backgroundColor = [UIColor clearColor];
    self.segmentControl.titleTextAttributes = @{NSForegroundColorAttributeName : kRGBColor(191,221,233),NSFontAttributeName:[UIFont systemFontOfSize:14]};
    self.segmentControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.segmentControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.segmentControl.selectionIndicatorColor = [UIColor whiteColor];
    self.segmentControl.selectionIndicatorHeight = 2;
    self.segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentControl.selectionIndicatorBoxOpacity = 1;
    kWeakSelf(self)
    [self.segmentControl setIndexChangeBlock:^(NSInteger index) {
        pageIndex = 1;
        if (index == 2) {
            IsCell = 2;
            
        }else if(index==0){
            IsCell=0;
        }
        else
        {
            IsCell=1;
        }
        [weakself loadData];
    }];
    
    [_segmentBGView addSubview:self.segmentControl];
    [self.view addSubview:_segmentBGView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IsCell==0||IsCell==1) {
        return 307;
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
    
    ConferenceCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ConferenceCell"];
    MineAdviseCell * cell1 = [tableView dequeueReusableCellWithIdentifier:@"MineAdviseCell"];
    if (IsCell==0||IsCell==1) {
        
        ConferenceItem * item =dataArray[indexPath.row];
        cell.item = item;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
        [cell1.adviseImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,model.portrait]]];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell1;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (IsCell==0||IsCell==1) {
        
        ConferenceItem * item = dataArray[indexPath.row];
        ConferenceDetailController * vc = [ConferenceDetailController new];
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

- (void)loadData
{
  [DataSourceTool buyListPage: [NSString stringWithFormat:@"%ld",pageIndex] pageSize:@"10" Url:[NSString stringWithFormat:@"%ld",IsCell] ViewController:self success:^(id json) {
      
      if ([json[@"errcode"] integerValue]==0) {
          NSMutableArray *temp = [NSMutableArray array];
          [temp removeAllObjects];
          if (pageIndex==1)
          {
              [dataArray removeAllObjects];
              [tableview.mj_header endRefreshing ];
              [tableview.mj_footer endRefreshing];
          }
          else {
              if (((NSArray*)json[@"list"]).count == 0) {
                  [tableview.mj_footer endRefreshingWithNoMoreData];
              }else{
                  [tableview.mj_footer endRefreshing];
              }
          }
          
          pageIndex++;
          
          for (NSDictionary * dic in json[@"list"]) {
              if (IsCell==0||IsCell==1) {
                  ConferenceItem * item = [ConferenceItem new];
                  [item setValuesForKeysWithDictionary:dic];
                  [temp addObject:item];
                  
              }
              else
              {
                  ZCModel *model = [ZCModel new];
                  [model setValuesForKeysWithDictionary:dic];
                  [temp addObject:model];
              }
              dataArray = temp;
              [tableview reloadData];
          }
          
      }else {
          [tableview.mj_header endRefreshing];
          [tableview.mj_footer endRefreshing];
      }

  } failure:^(NSError *error) {
      
  }];
}


- (NSString *)becomeTime:(NSString *)time
{
    NSDateFormatter* formatter = [NSDateFormatter new];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *dt = [NSDate dateWithTimeIntervalSince1970:[time integerValue]];
    NSString *nowtimeStr = [formatter stringFromDate:dt];
    return nowtimeStr;
    
}


//下拉刷新数据
-(void)reloadData
{
    pageIndex = 1;
    [self loadData];
}


@end
