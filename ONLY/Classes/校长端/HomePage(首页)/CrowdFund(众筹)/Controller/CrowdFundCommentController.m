//
//  CrowdFundCommentController.m
//  ONLY
//
//  Created by Dylan on 23/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "CrowdFundCommentController.h"

#import "CrowdFundCommentListCell.h"

#import "CommentItem.h"
@interface CrowdFundCommentController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)NSMutableArray * dataArray;
@end

@implementation CrowdFundCommentController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
    [self setupUI];
    [self getData];
}

-(void)setupNavi{
    self.title = @"产品评价";
}
-(void)setupUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 245;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.tableView setSeparatorColor:AppBackColor];
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CrowdFundCommentListCell" bundle:nil] forCellReuseIdentifier:@"CrowdFundCommentListCell"];
}


-(void)getData{
    
    
    NSDictionary * param =@{
                            @"comment_type": @"0",
                            @"good_id": self.item.good_id
                            };
    [DataSourceTool commentListWithParam:param toViewController:self success:^(id json) {
        NSLog(@"%@",json);
        [json[@"data"][0] createPropertyCode];
        if ([json[@"errcode"]integerValue]==0) {
            for (NSDictionary * dic in json[@"data"]) {
                CommentItem * item = [CommentItem new];
                [item setValuesForKeysWithDictionary:dic];
                
                [self.dataArray addObject:item];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
    
    
}



#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CrowdFundCommentListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CrowdFundCommentListCell"];
    CommentItem * item = self.dataArray[indexPath.row];
    cell.item = item;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    CrowdFundItem * item = self.dataArray[indexPath.row];
//    CrowdFundDetailController * vc = [CrowdFundDetailController new];
//    vc.status = self.status;
//    vc.item = item;
//    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
