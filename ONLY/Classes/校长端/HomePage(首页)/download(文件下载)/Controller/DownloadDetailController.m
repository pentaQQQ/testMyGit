
//
//  DownloadDetailController.m
//  ONLY
//
//  Created by Dylan on 21/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "DownloadDetailController.h"
#import "DownloadDetailCell.h"
#import "MineDownLoadDetailController.h"
@interface DownloadDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView * tableView;

@end

@implementation DownloadDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
    [self setupUI];
}

-(void)setupNavi{
    self.title = self.item.name;
}

-(void)setupUI{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.tableView setSeparatorColor:AppBackColor];
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"DownloadDetailCell" bundle:nil] forCellReuseIdentifier:@"DownloadDetailCell"];
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.item.content.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DownloadDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"DownloadDetailCell"];
    DataItem * dataItem = self.item.content[indexPath.row];
    cell.item = dataItem;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MineDownLoadDetailController * vc = [MineDownLoadDetailController new];
    DataItem * dataItem = self.item.content[indexPath.row];
    vc.downloadUrl = dataItem.download_url;
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
