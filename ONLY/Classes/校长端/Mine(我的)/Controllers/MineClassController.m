//
//  MineClassController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/1/18.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//  课表

#import "MineClassController.h"
#import "MineClassCell.h"
#import "MineClassDetailCell.h"
#import "ClassModel.h"
#import "ClassDetailModel.h"
@interface MineClassController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MineClassController
{
    UITableView *tableview;
    NSMutableArray <NSArray *>*arr1;
    BOOL isExpand;
    NSInteger selectSection;
    NSMutableArray *expandArray;
    NSMutableArray *dataArray;
    NSMutableArray <NSArray *>*detailArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = colorWithRGB(0xEFEFF4);
    
    self.fd_prefersNavigationBarHidden = YES;
    
    [self setNavView];
    isExpand = NO;
    selectSection = 0;
    //是最开始的模型
    arr1 = [NSMutableArray array];
    expandArray = [NSMutableArray array];
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
    imageview.image = [UIImage imageNamed:@"member_mine_bg"];
    [self.view addSubview:imageview];
    imageview.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).topSpaceToView(view,0).heightIs(174);
    
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
    titleLabel.text = @"课程表";

    tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableview.separatorStyle= UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,16).topSpaceToView(view,0).bottomSpaceToView(self.view,64);
    cornerRadiusView(tableview, 5);
    tableview.showsVerticalScrollIndicator = NO;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    if (section == selectSection) {
//        if (isExpand==NO) {
//            return 1;
//        }
//        else{
//            return detailArray[section].count+1;
//        }
//    } else {
//        return 1;
//    }
    if ([expandArray[section] boolValue]) {
        return detailArray[section].count+1;
    }
    else {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 63;
    }
    else {
        
        return 114;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"MineClassCell";
    static NSString *cellID1 = @"MineClassDetailCell";
    
    MineClassCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    MineClassDetailCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellID1];
    
    if (cell==nil) {
        
        cell = [[MineClassCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = ClearColor;
        
    }
    
    if (cell1==nil) {
        
        cell1 = [[MineClassDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
        
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell1.backgroundColor = ClearColor;
        
    }
    if (indexPath.row==0) {
        if ([expandArray[indexPath.section] boolValue]) {
            cell.downImg.image = [UIImage imageNamed:@"up"];
        }
        else
        {
            cell.downImg.image = [UIImage imageNamed:@"down"];
        }
        ClassModel *model = dataArray[indexPath.section];
        cell.dayLabel.text = model.name;
        cell.timeLabel.text = model.date;
        return cell;
    }
    else
    {
        if ([expandArray[indexPath.section] boolValue]) {
            
            ClassDetailModel *model1 = detailArray[indexPath.section][indexPath.row-1];
            cell1.classType.text = model1.class_name;
            cell1.timeLabel.text = [NSString stringWithFormat:@"课程日期：%@",model1.class_date];
            cell1.tecLabel.text  = [NSString stringWithFormat:@"课程讲师：%@",model1.teacher_name];
            cell1.addLabel.text  = [NSString stringWithFormat:@"课程地址：%@",model1.class_addres];
        }
        return cell1;
    }
  
}

//把数据放到模型里面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    isExpand = !isExpand;
    selectSection = indexPath.section;
    
    expandArray[indexPath.section] = @(![expandArray[indexPath.section] boolValue]);
    [tableView reloadData];
    
}


//加载网络数据
- (void)loadData
{
   [DataSourceTool findTimetableID:self.course_id ViewController:self success:^(id json) {
       
       if ([json[@"errcode"] integerValue]==0) {
           NSMutableArray *temp = [NSMutableArray array];
           NSMutableArray *temp2 = [NSMutableArray array];
           for (NSDictionary *dic in json[@"list"]) {
               NSMutableArray *temp1 = [NSMutableArray array];
               ClassModel *model = [ClassModel new];
               [model setValuesForKeysWithDictionary:dic];
               [temp addObject:model];
               
               for (NSDictionary *myDic in model.son) {
                   
                   ClassDetailModel *model1 = [ClassDetailModel new];
                   [model1 setValuesForKeysWithDictionary:myDic];
                   [temp1 addObject:model1];
               }
               [temp2 addObject:temp1];
           }
           
           dataArray = temp;
           detailArray = temp2;
           
           for (int i =0 ; i < dataArray.count; i++) {
               [expandArray addObject:@(NO)];
           }
           
           [tableview reloadData];
       }
       
   } failure:^(NSError *error) {
       
   }];

}

@end
