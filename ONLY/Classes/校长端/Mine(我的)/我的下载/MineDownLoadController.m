//
//  MineDownLoadController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/2/6.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineDownLoadController.h"
#import "MineDownloadCell.h"
#import "MineFileModel.h"
#import "MineDownLoadDetailController.h"
@interface MineDownLoadController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MineDownLoadController
{
    UITableView *tableview;
    NSArray *dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = WhiteColor;
    [self setNavView];
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
    titleLabel.text = @"我的下载";
    
    tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:tableview];
    tableview.sd_layout.topSpaceToView(self.view,64).bottomSpaceToView(self.view,0).rightEqualToView(self.view).leftEqualToView(self.view);
    tableview.rowHeight = 85;
    tableview.delegate = self;
    tableview.dataSource = self;
    [tableview setTableFooterView:[UIView new]];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"MineDownloadCell";
    MineDownloadCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell==nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MineDownloadCell" owner:nil options:nil] firstObject];
    }
    MineFileModel *model = dataArray[indexPath.row];
    cell.name.text = model.data_name;
    cell.time.text = [self becomeTime:model.download_time];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineFileModel *model = dataArray[indexPath.row];
    MineDownLoadDetailController  *vc  = [ MineDownLoadDetailController new];
    vc.downloadUrl = model.download_url;
    [self.navigationController pushViewController:vc animated:YES];
    

}

- (NSString *)becomeTime:(NSString *)time
{
    NSDateFormatter* formatter = [NSDateFormatter new];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *dt = [NSDate dateWithTimeIntervalSince1970:[time integerValue]];
    
    NSString *nowtimeStr = [formatter stringFromDate:dt];
    
    return nowtimeStr;
    
}

- (void)loadData
{
  [DataSourceTool findMyRecords:@"" ViewController:self success:^(id json) {
      
      if ([json[@"errcode"] integerValue]==0) {
          NSMutableArray *temp = [NSMutableArray array];
          for (NSDictionary *dic in json[@"list"]) {
              MineFileModel *model = [MineFileModel new];
              [model setValuesForKeysWithDictionary:dic];
              [temp addObject:model];
              
          }
          dataArray = temp;
          [tableview reloadData];
      }
  } failure:^(NSError *error) {
      
  }];


}

@end
