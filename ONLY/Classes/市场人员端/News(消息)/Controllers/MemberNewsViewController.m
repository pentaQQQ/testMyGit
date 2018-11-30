//
//  MemberNewsViewController.m
//  ONLY
//
//  Created by 上海点硕 on 2016/12/20.
//  Copyright © 2016年 cbl－　点硕. All rights reserved.
//

#import "MemberNewsViewController.h"
#import "MemberNewsListCell.h"
#import "MemberHomeDetailController.h"
#import "NewsItem.h"
@interface MemberNewsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView* tableView; /*表视图*/
@property (nonatomic,strong) NSMutableArray* dataSource; /*数据模型*/
@property (nonatomic, strong) NSMutableArray * dataArray;
@end

@implementation MemberNewsViewController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItems = @[[UIBarButtonItem itemFixedSpace:-10], [UIBarButtonItem itemWithframe:CGRectMake(0, 0, 70, 40) Title:@"设为已读" bgColor:ClearColor textColor:WhiteColor font:NaviFont TextAlignment:NSTextAlignmentLeft Target:self Action:@selector(rightItemAction:)]];
    [self.tableView setSectionFooterHeight:0.0f];
    [self getData];
}


-(void)reloadData
{
  [self getData];
}


-(UITableView*) tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = TableviewGroupColor;
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 100;
        kWeakSelf(self);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            
            [weakself reloadData];
            
        }];
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001f;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MemberNewsListCell* cell = [MemberNewsListCell memberNewsListCellWithTableview:_tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NewsItem *model = self.dataArray[indexPath.row];

    /*时间label*/
    cell.time_label.text = [self timeWithTimeIntervalString:model.add_date];
    cell.order_state_label.text = model.tiding_name;
    cell.news_content_label.text = model.title ;
    cell.order_number_label.text = model.gd_sn;
    if ([model.status isEqualToString:@"1"]) {
        
        cell.news_read_state_label.text = @"";
    }
    else
    {
        cell.news_read_state_label.text = @"未读";
    }
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MemberHomeDetailController* vc = [[MemberHomeDetailController alloc] init];
    NewsItem *model = self.dataArray[indexPath.row];
    vc.order_sn = model.gd_sn;
    if( [model.order_status integerValue] == 0)
    {
        vc.type = 1;
    }
    else if([model.order_status integerValue] == 1)
    {
        vc.type = 0;
    }
    else if([model.order_status integerValue] == 3)
    {
        vc.type = 2;
    }
    else
    {
        vc.type = 3;
    }
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 设置为已读
-(void) rightItemAction:(UIButton*) sender
{
    NSLog(@"设置为已读");
}


-(void)getData{
    [DataSourceTool findNewsType:@"1" ViewController:self success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"errcode"]integerValue]==0) {
            [self.dataArray  removeAllObjects];
            for (NSDictionary * dic in json[@"rsp"]) {
                NewsItem * item = [NewsItem new];
                [item setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:item];
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
        [self.tableView.mj_header endRefreshing];
    }];
}

- (NSString *)timeWithTimeIntervalString:(NSString *)aTimeString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[aTimeString doubleValue]];
    NSLog(@"%@",date);// 这个时间是格林尼治时间
    NSString *dat = [formatter stringFromDate:date];
    NSLog(@"%@", dat);// 这个时间是北京时间
    return dat;
    
}
@end
