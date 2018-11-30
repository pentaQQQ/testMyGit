//
//  MIneGodIdeaController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/2/7.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MIneGodIdeaController.h"
#import "HMSegmentedControl.h"
#import "MineServerDetailController.h"
#import "MineAdviseCell.h"
#import "CrowdFundDetailController.h"
#import "MineZCDetailController.h"
#import "MineServerSecondCell.h"
#import "MineGodIdeaCell.h"
#import "MIneGodIdeaCell1.h"
#import "MineGodIdeaCell2.h"
#import "ServerModel.h"
#import "GoodIdeaModel.h"
#import "IdeaDetailController.h"
@interface MIneGodIdeaController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)HMSegmentedControl * segmentControl;
@end

@implementation MIneGodIdeaController
{
    UIView * _segmentBGView;
    UITableView * tableview;
    NSInteger IsCell;
    NSInteger pageindex;
    NSMutableArray *dataArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = WhiteColor;
    IsCell = 0;
    pageindex = 1;
    dataArray = [NSMutableArray array];
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
    titleLabel.text = @"我的金点子";
    
    tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:tableview];
    tableview.sd_layout.topSpaceToView(self.view,108).bottomSpaceToView(self.view,0).rightEqualToView(self.view).leftEqualToView(self.view);
    tableview.rowHeight = 94;
    tableview.delegate = self;
    tableview.dataSource = self;
    [tableview setTableFooterView:[UIView new]];
    //MineAdviseCell
    [tableview registerNib:[UINib nibWithNibName:@"MineGodIdeaCell" bundle:nil] forCellReuseIdentifier:@"MineGodIdeaCell"];
    
    [tableview registerNib:[UINib nibWithNibName:@"MIneGodIdeaCell1" bundle:nil] forCellReuseIdentifier:@"MIneGodIdeaCell1"];
    
     [tableview registerNib:[UINib nibWithNibName:@"MineAdviseCell" bundle:nil] forCellReuseIdentifier:@"MineAdviseCell"];
    
    
}

-(void)setupSegment{
    _segmentBGView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, screenWidth(), 44)];
    _segmentBGView.backgroundColor = colorWithRGB(0x00A9EB);;
    self.segmentControl = [[HMSegmentedControl alloc] initWithFrame:CGRectMake(5, 0, SCREEN_WIDTH-10, 40)];
    
    self.segmentControl.sectionTitles = @[@"已点赞",@"已收藏", @"已提议"];
    self.segmentControl.selectedSegmentIndex = 0;
    self.segmentControl.backgroundColor = [UIColor clearColor];
    self.segmentControl.titleTextAttributes = @{NSForegroundColorAttributeName : kRGBColor(191,221,233),NSFontAttributeName:[UIFont systemFontOfSize:14]};
    self.segmentControl.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    self.segmentControl.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.segmentControl.selectionIndicatorColor = [UIColor whiteColor];
    self.segmentControl.selectionIndicatorHeight = 2;
    self.segmentControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segmentControl.selectionIndicatorBoxOpacity = 1;
    //__weak typeof(tableview) weaktableview = tableview;
    kWeakSelf(self);
    [self.segmentControl setIndexChangeBlock:^(NSInteger index) {
         pageindex = 1;
        
        if (index == 0) {
            IsCell = 0;
            
        }else if (index==1){
            IsCell=1;
        }
        else
        {
            IsCell = 2;
        }
        [weakself loadData];
    }];
    
    [_segmentBGView addSubview:self.segmentControl];
    [self.view addSubview:_segmentBGView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 172;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MineGodIdeaCell  *cell =  [tableView dequeueReusableCellWithIdentifier:@"MineGodIdeaCell"];
    MIneGodIdeaCell1 *cell1 = [tableView dequeueReusableCellWithIdentifier:@"MIneGodIdeaCell1"];
    MineAdviseCell   *cell2 = [tableView dequeueReusableCellWithIdentifier:@"MineAdviseCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    cell2.selectionStyle = UITableViewCellSelectionStyleNone;
    
    GoodIdeaModel *model = dataArray[indexPath.row];
    
    if (IsCell==0) {
        
        [cell.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,model.portrait]] placeholderImage:nil];
        [cell.GoodImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,model.apply_img[0]]] placeholderImage:nil];
        
        cell.name.text = model.member_name;
        cell.title.text = model.apply_name;
        cell.detail.text = model.apply_desc;
        cell.disNum.text = model.comment_count;
        cell.zanNUm.text = model.thumbs;
        cell.time.text = [self becomeTime:model.add_time];
        
        
        return cell;
    }
    else if (IsCell==1)
    {
        cell1.name.text = model.member_name;
        cell1.title.text = model.apply_name;
        cell1.detail.text = model.apply_desc;
        cell1.time.text = [self becomeTime:model.add_time];
        [cell1.img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,model.apply_img[0]]] placeholderImage:nil];
        
        return cell1;
    }
    else
    {
        cell2.adviseTitle.text = model.apply_name;
        cell2.adviseTime.text = [self becomeTime:model.add_time];
        cell2.adviseStatus.text = model.status;
        [cell2.adviseImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,model.apply_img[0]]] placeholderImage:nil];
        return cell2;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodIdeaModel *model = dataArray[indexPath.row];
    IdeaItem *item = [IdeaItem new];
    item.apply_id  = model.apply_id;
    if (IsCell==0||IsCell==1) {
        IdeaDetailController *vc  =[IdeaDetailController new];
        vc.item = item;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
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

//加载网络数据
- (void)loadData
{
   [DataSourceTool goodIdea:IsCell page:pageindex ViewController:self success:^(id json) {
       
       if ([json[@"errcode"] integerValue]==0) {
//           NSMutableArray *temp = [NSMutableArray array];
//           [temp removeAllObjects];
           if (pageindex==1)
           {
               [dataArray removeAllObjects];
               [tableview.mj_header endRefreshing];
               [tableview.mj_footer endRefreshing];
           }
           else {
               if (((NSArray*)json[@"rsp"]).count == 0) {
                   [tableview.mj_footer endRefreshingWithNoMoreData];
                   
               }else{
                   [tableview.mj_footer endRefreshing];
               }
           }
           
           pageindex++;
           for (NSDictionary * dic in json[@"rsp"]) {
               
               GoodIdeaModel * item = [GoodIdeaModel new];
               [item setValuesForKeysWithDictionary:dic];
               [dataArray addObject:item];
               //dataArray = temp;
           }
         
           [tableview reloadData];
           
       }else {
           [tableview.mj_header endRefreshing];
           [tableview.mj_footer endRefreshing];
       }
       
   } failure:^(NSError *error) {
       
   }];

}

//下拉刷新
- (void)reloadData
{
    kWeakSelf(self);
    pageindex = 1;
    [weakself loadData];

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
