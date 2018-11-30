//
//  MineMemDetailController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/3/7.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineMemDetailController.h"
#import "MineMemberCell.h"
#import "PeopleItem.h"
#import "MineChangeMemController.h"
@interface MineMemDetailController ()<UITableViewDelegate,UITableViewDataSource,FreshMyControllerDelegate>

@end

@implementation MineMemDetailController

{
    UITableView *tableview;
    NSArray *titleArr;
    NSArray *detailArr;
    UIButton *Addbtn;
    NSMutableArray *dataArray;
    NSInteger myIndex;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = colorWithRGB(0xEFEFF4);
    self.fd_prefersNavigationBarHidden = YES;
    [self setNavView];
    titleArr = @[@"分校名称",@"校长姓名",@"参会/参训人姓名",@"身份证号",@"手机号码",@"岗位",@"邮箱",];
    
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
    titleLabel.text = self.navName;
    
    Addbtn = [UIButton new];
    [view addSubview:Addbtn];
    if([self.navName isEqualToString:@"添加培训人员"]){
    [Addbtn setTitle:@"提交" forState:UIControlStateNormal];
    }
    else
    {
    [Addbtn setTitle:@"删除" forState:UIControlStateNormal];
    }
    [Addbtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    Addbtn.sd_layout.widthIs(58).rightSpaceToView(view,16).heightIs(14).topSpaceToView(view,38);
    Addbtn.titleLabel.font = font(14);
    [Addbtn addTarget:self action:@selector(lookHistory) forControlEvents:UIControlEventTouchUpInside];
    
    tableview = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    //tableview.separatorStyle= UITableViewCellSeparatorStyleNone;
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
    return titleArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    MineMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineMemberCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLab.text = titleArr[indexPath.row];
    cell.detailLab.text = self.myarr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineChangeMemController *vc = [MineChangeMemController new];
    vc.myStr = _myarr[indexPath.row];
    vc.delegate = self;
    vc.isType = self.isType;
    myIndex = indexPath.row;
    if (indexPath.row==2) {
        vc.keyName = @"name";
    }
    else if (indexPath.row==3)
    {
        vc.keyName = @"identity_id";
    }
    else if (indexPath.row==4)
    {
        vc.keyName = @"mobile";
    }
    else if (indexPath.row==5)
    {
        vc.keyName = @"work";
    }
    else if (indexPath.row==6)
    {
        vc.keyName = @"email";
    }
    else if (indexPath.row==1)
    {
      vc.keyName = @"campus";
    }
    else
    {
      vc.keyName = @"master_name";
    }
    vc.person_id = self.member_person_id;
    [self.navigationController pushViewController:vc animated:YES];
    
}

- (void)Fresh:(NSString *)str
{
    [_myarr replaceObjectAtIndex:myIndex withObject:str];
    [tableview reloadData];
}

//删除培训人员
- (void)lookHistory
{
   
    if([self.navName isEqualToString:@"添加培训人员"]){
        
        [DataSourceTool addPersonname:_myarr[2] identity_id:_myarr[3]  mobile:_myarr[4]  work:_myarr[5]  email:_myarr[6] campus:_myarr[1] master_name:_myarr[0] ViewController:self success:^(id json) {
            
            if ([json[@"errcode"] integerValue]==0) {
                
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError *error) {
            
        }];
    }
    else
    {
        [DataSourceTool deletePerson:self.member_person_id ViewController:self success:^(id json) {
            
            if ([json[@"errcode"] integerValue]==0) {
                
                [self.navigationController popViewControllerAnimated:YES];
            }
        } failure:^(NSError *error) {
            
        }];
        
    }
    
}

@end
