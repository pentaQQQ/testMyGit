//
//  MineZCDetailController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/2/6.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineZCDetailController.h"
#import "MineZCDetailCell.h"
@interface MineZCDetailController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation MineZCDetailController
{
    UITableView *tableview;
    NSMutableArray *dataArray;
    NSArray *picArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.fd_prefersNavigationBarHidden = YES;
    self.view.backgroundColor = WhiteColor;
    [self setNavView];
    
    dataArray = [NSMutableArray arrayWithObjects:@"",@"",@"",@"",@"",@"",nil];
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
    titleLabel.text = @"提议详情";
    
    tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:tableview];
    tableview.sd_layout.topSpaceToView(self.view,64).bottomSpaceToView(self.view,0).rightEqualToView(self.view).leftEqualToView(self.view);
    tableview.delegate = self;
    tableview.dataSource = self;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 112;
    }
    else if (indexPath.row==1)
    {
        return 84;
    }
    else
    {
        return 1000;
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"MineZCDetailCell";
    static NSString *cellID1 = @"MineZCDetailCell1";
    static NSString *cellID2 = @"MineZCDetailCell2";
    
    MineZCDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellID1];
    UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellID2];
    
    if (cell==nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MineZCDetailCell" owner:nil options:nil] firstObject];
    }
    
    if (cell1 == nil) {
        
        cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID1];
        
        UILabel *lab1 = [UILabel new];
        lab1.tag = 100;
        [cell1.contentView addSubview:lab1];
        lab1.textColor = colorWithRGB(0x666666);
        lab1.text = @"类别：英语";
        lab1.font = font(12);
        lab1.textAlignment = NSTextAlignmentLeft;
        lab1.sd_layout.leftSpaceToView(cell1.contentView,17).topSpaceToView(cell1.contentView,25).rightSpaceToView(cell1.contentView,17).heightIs(12);
        
        UILabel *lab2 = [UILabel new];
        lab2.tag = 101;
        [cell1.contentView addSubview:lab2];
        lab2.textColor = colorWithRGB(0x666666);
        lab2.text = @"市场参考价：￥60/件";
        lab2.font = font(12);
        lab2.textAlignment = NSTextAlignmentLeft;
        lab2.sd_layout.leftSpaceToView(cell1.contentView,17).topSpaceToView(lab1,12).rightSpaceToView(cell1.contentView,17).heightIs(12);
    }
    
    if (cell2 == nil) {
        cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID2];
        
        UILabel *lab1 = [UILabel new];
        lab1.numberOfLines = 0;
        [cell2.contentView addSubview:lab1];
        lab1.textColor = colorWithRGB(0x666666);
        lab1.text = @"";
        lab1.font = font(12);
        lab1.textAlignment = NSTextAlignmentLeft;
        lab1.sd_layout.leftSpaceToView(cell2.contentView,17).topSpaceToView(cell2.contentView,25).rightSpaceToView(cell2.contentView,17).heightIs(87);
        for (int i = 0; i<3; i++) {
            UIImageView *imageView = [UIImageView new];
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            [cell2.contentView addSubview:imageView];
            
            imageView.tag = 10000+i;
            
            imageView.sd_layout.leftSpaceToView(cell2.contentView,16).rightSpaceToView(cell2.contentView,16).heightIs(141).topSpaceToView(lab1,10+i*150);
        }
    }
    
    if (indexPath.row==0) {
        cell.apply_name.text = self.apply_name;
        cell.apply_time.text = self.apply_time;
        cell.apply_status.text = self.apply_status;
        
        
        cell.member_name.text = dataArray[3];
        
       return  cell;
    }
    else if (indexPath.row==1)
    {
        UILabel *lab1  = [cell1.contentView viewWithTag:100];
        lab1.text = [NSString stringWithFormat:@"类别：%@",dataArray[1]];
        
        UILabel *lab2  = [cell1.contentView viewWithTag:101];
        lab2.text = [NSString stringWithFormat:@"市场参考价：%@",dataArray[2]];
        
        return cell1;
    }
   
    for (int i = 0; i<picArray.count; i++) {
        
        UIImageView *imageview = [cell2.contentView viewWithTag:10000+i];
        NSString *url = [NSString stringWithFormat:@"%@%@",Choose_Base_URL,picArray[i]];
        NSLog(@"url = %@",url);
        [imageview sd_setImageWithURL:[NSURL URLWithString:url]];
    }
    
    return cell2;

}

- (void)loadData
{
   [DataSourceTool getOfferDetailID:self.apply_id ViewController:self success:^(id json) {
       
       if ([json[@"errcode"] integerValue]==0) {

             [dataArray removeAllObjects];
             [dataArray addObject:json[@"data"][@"portrait"]];
             [dataArray addObject:json[@"data"][@"type_name"]];
             [dataArray addObject:json[@"data"][@"apply_price"]];
             [dataArray addObject:json[@"data"][@"member_name"] ];
             [dataArray addObject:json[@"data"][@"portrait"] ];
             [dataArray addObject:json[@"data"][@"keywords"] ];
             picArray = json[@"data"][@"picList"];
        
           self.apply_time = [self becomeTime:json[@"data"][@"add_time"]];
           self.apply_name = json[@"data"][@"apply_name"];
           if ([json[@"data"][@"status"] isEqualToString:@"0"]) {
               //审核状态 0未审核1审核通过2审核未通过
               self.apply_status = @"未审核";
           }
           else if ([json[@"data"][@"status"] isEqualToString:@"1"])
           {
               self.apply_status = @"审核通过";
           }
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
