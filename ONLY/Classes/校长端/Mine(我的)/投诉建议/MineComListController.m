//
//  MineComListController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/2/8.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineComListController.h"
#import "MineComListCell.h"
#import "MineComDetailController.h"
#import "ComplainModel.h"
@interface MineComListController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MineComListController
{
    UITableView *tableview;
    NSArray *dataArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = colorWithRGB(0xEFEFF4);
    self.fd_prefersNavigationBarHidden = YES;
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
    
    UIImageView *imageview = [UIImageView new];
    imageview.image = [UIImage imageNamed:@"head"];
    [self.view addSubview:imageview];
    imageview.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(view,0).heightIs(112);
    
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
    titleLabel.text = @"投诉建议反馈";
    
  
    tableview = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableview.separatorStyle= UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,16).topSpaceToView(view,0).bottomSpaceToView(self.view,0);
    cornerRadiusView(tableview, 3);
    tableview.showsVerticalScrollIndicator = NO;

    [tableview registerNib:[UINib nibWithNibName:@"MineComListCell" bundle:nil] forCellReuseIdentifier:@"MineComListCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
   
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 40;
    }
    else
    {
        return 0.00000001;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    return 83 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineComListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineComListCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ComplainModel *model = dataArray[indexPath.section];
    cell.title.text = model.synopsis;
    cell.time.text = [self becomeTime:model.add_date];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ComplainModel *model = dataArray[indexPath.section];
    MineComDetailController *vc  = [MineComDetailController new];
    vc.com_id = model.complaint_id;
    [self.navigationController pushViewController:vc animated:YES];

}

//加载网络数据(历史反馈列表)
- (void)loadData
{
   [DataSourceTool findComplaintViewController:self success:^(id json) {
       
       if ([json[@"errcode"] integerValue]==0) {
           NSMutableArray *temp = [NSMutableArray array];
           for (NSDictionary *dic in json[@"rsp"]) {
               
               ComplainModel *model = [ComplainModel new];
               [model setValuesForKeysWithDictionary:dic];
               [temp addObject:model];
           }
           
           dataArray = temp;
           [tableview reloadData];
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


@end
