//
//  MineMemberController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/2/8.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineMemberController.h"
#import "MineMemberCell.h"
#import "PeopleItem.h"
#import "MineMemDetailController.h"
@interface MineMemberController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MineMemberController
{
    UITableView *tableview;
    NSArray *titleArr;
    NSArray *detailArr;
    UIButton *Addbtn;
    NSMutableArray *dataArray;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = colorWithRGB(0xEFEFF4);
    self.fd_prefersNavigationBarHidden = YES;
    [self setNavView];
    
    titleArr = @[@"小磊磊",@"小磊磊",@"小磊磊",@"小磊磊",@"小磊磊"];
    
    detailArr = @[@"",@"",@"",@"",@""];
    
    [self loadData];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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
    titleLabel.text = @"培训人员";
    
    
    Addbtn = [UIButton new];
    [view addSubview:Addbtn];
    [Addbtn setTitle:@"+添加" forState:UIControlStateNormal];
    [Addbtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    Addbtn.sd_layout.widthIs(58).rightSpaceToView(view,16).heightIs(14).topSpaceToView(view,38);
    Addbtn.titleLabel.font = font(14);
    [Addbtn addTarget:self action:@selector(lookHistory) forControlEvents:UIControlEventTouchUpInside];
    
    tableview = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,16).topSpaceToView(view,0).bottomSpaceToView(self.view,0);
    cornerRadiusView(tableview, 3);
    tableview.showsVerticalScrollIndicator = NO;
    tableview.rowHeight = 47;
    [tableview registerNib:[UINib nibWithNibName:@"MineMemberCell" bundle:nil] forCellReuseIdentifier:@"MineMemberCell"];
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0000001;
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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineMemberCell"];
   
    PeopleItem *model = dataArray[indexPath.row];
    cell.titleLab.text = model.name;
    cell.detailLab.text = @"";
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PeopleItem *model = dataArray[indexPath.row];
    MineMemDetailController *vc = [MineMemDetailController new];
    vc.myarr = [NSMutableArray arrayWithObjects:model.master_name,model.campus,model.name,model.identity_id,model.mobile,model.work,model.email, nil];
    vc.navName = @"修改培训人员";
    vc.member_person_id = model.member_person_id;
    vc.isType =1;
    [self.navigationController pushViewController:vc animated:YES];
    
    [tableView reloadData];

}

//添加培训人员
- (void)lookHistory
{
    
    MineMemDetailController *vc = [MineMemDetailController new];
    vc.myarr = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",@"", nil];
    vc.navName = @"添加培训人员";
    vc.isType = 0;
    [self.navigationController pushViewController:vc animated:YES];
    
}

//添加人员列表
- (void)loadData
{
    
  [DataSourceTool mypersonListViewController:self success:^(id json) {
      if ([json[@"errcode"] integerValue]==0) {
          
          NSMutableArray *temp  = [NSMutableArray array];
          for (NSDictionary *dic in json[@"list"]) {
              
              PeopleItem *model = [PeopleItem new];
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
