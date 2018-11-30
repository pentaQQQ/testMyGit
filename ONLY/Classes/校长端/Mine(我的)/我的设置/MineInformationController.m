//
//  MineInformationController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/2/9.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineInformationController.h"
#import "MineMemberCell.h"
#import "MineInformationCell.h"
#import "SGDatePicker.h"
#import "MineChangeNameController.h"
@interface MineInformationController ()<UITableViewDelegate,UITableViewDataSource,SGActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,reFreshMyControllerDelegate>

@end

@implementation MineInformationController
{
    UITableView *tableview;
    NSArray *titleArr;
    NSMutableArray *detailArr;
    NSString *sexStr;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = colorWithRGB(0xEFEFF4);
    self.fd_prefersNavigationBarHidden = YES;
    titleArr = @[@"头像",@"姓名",@"性别",@"生日" ];
    
    if ([USERINFO.sex integerValue]==0) {
        sexStr = @"男";
    }
    
    else {
        sexStr = @"女";
    }
    
    detailArr = [NSMutableArray arrayWithObjects:USERINFO.portrait,USERINFO.memberName,sexStr,USERINFO.birthday,nil];
   
    [self setNavView];
    
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
    titleLabel.text = @"设置";
    
    
    tableview = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableview.separatorStyle= UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,16).topSpaceToView(view,0).bottomSpaceToView(self.view,0);
    cornerRadiusView(tableview, 3);
    tableview.showsVerticalScrollIndicator = NO;
    
    [tableview registerNib:[UINib nibWithNibName:@"MineMemberCell" bundle:nil] forCellReuseIdentifier:@"MineMemberCell"];
    [tableview registerNib:[UINib nibWithNibName:@"MineInformationCell" bundle:nil] forCellReuseIdentifier:@"MineInformationCell"];
    
    
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        
        return 84;
    }
    else
    {
        return 47;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return detailArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineMemberCell"];
    MineInformationCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"MineInformationCell"];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *line = [UIView new];
    [cell.contentView addSubview:line];
    line.backgroundColor = colorWithRGB(0x999999);
    line.alpha = 0.102;
    line.sd_layout.leftEqualToView(cell.contentView).rightEqualToView(cell.contentView).heightIs(1).bottomSpaceToView(cell.contentView,0);
    
    UIView *line1 = [UIView new];
    [cell1.contentView addSubview:line1];
    line1.backgroundColor = colorWithRGB(0x999999);
    line1.alpha = 0.102;
    line1.sd_layout.leftEqualToView(cell1.contentView).rightEqualToView(cell1.contentView).heightIs(1).bottomSpaceToView(cell1.contentView,0);
    if (indexPath.row==0) {
        
        cell1.titleLab.text = titleArr[indexPath.row];
        cornerRadiusView(cell1.portail, 25);
        [cell1.portail sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,USERINFO.portrait]] placeholderImage:[UIImage imageNamed:@"member_mine_user"]];
        
        return cell1;
    }
    
    else
    {
        cell.titleLab.text = titleArr[indexPath.row];
        cell.detailLab.text = detailArr[indexPath.row];
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        
        SGActionSheet *sheet = [[SGActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitleArray:@[@"相册", @"拍照"]];
        sheet.cancelButtonTitleColor = [UIColor redColor];
        sheet.tag = 10001;
        [sheet show];

    }
    else if (indexPath.row==1)
    {
        MineChangeNameController *vc  = [MineChangeNameController new];
        vc.delegate = self;
        vc.isType = 0;
        vc.myStr = USERINFO.memberName;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.row==2)
    {
        SGActionSheet *sheet = [SGActionSheet actionSheetWithTitle:@"选择性别" delegate:self cancelButtonTitle:@"取消" otherButtonTitleArray:@[@"男", @"女"]];
        sheet.cancelButtonTitleColor = [UIColor redColor];
        sheet.tag = 10000;
        
        [sheet show];
    }
    else
    {
        // 日期
        SGDatePicker *datePicker = [[SGDatePicker alloc] init];
        datePicker.isBeforeTime = YES; // 日期一定要设置
        datePicker.datePickerMode = UIDatePickerModeDate; // 日期一定要设置
        datePicker.maxSelectDate = [NSDate date];
        [datePicker didFinishSelectedDate:^(NSDate *selectedDate) {
             NSString *birthday = [self dateStringWithDate:selectedDate DateFormat:@"yyyy-MM-dd"];
            
            [DataSourceTool updateMineInformation:@"birthday" myValue:birthday toViewController:self success:^(id json) {
                if ([json[@"errcode"] integerValue]==0) {
                    
                    [detailArr replaceObjectAtIndex:3 withObject:birthday];
                    USERINFO.birthday = birthday;
                    [tableview reloadData];
                }
                
            } failure:^(NSError *error) {
                
            }];
            
            NSLog(@"%@",birthday);
            
        }];
    
        [datePicker show];

    }
}

//变换日期的格式
- (NSString *)dateStringWithDate:(NSDate *)date DateFormat:(NSString *)dateFormat {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *str = [dateFormatter stringFromDate:date];
    return str ? str : @"";
}


- (void)SGActionSheet:(SGActionSheet *)actionSheet didSelectRowAtIndexPath:(NSInteger)indexPath {
    NSUInteger sourceType = 0;
    if(actionSheet.tag == 10000){;
    switch (indexPath) {
        case 0: {
            
            NSLog(@"男");
            [DataSourceTool updateMineInformation:@"sex" myValue:@"0" toViewController:self success:^(id json) {
                if ([json[@"errcode"] integerValue]==0) {
                    
                    USERINFO.sex = @"0";
                    [detailArr replaceObjectAtIndex:2 withObject:@"男"];
                    [tableview reloadData];
                }
                
            } failure:^(NSError *error) {
                
                
            }];
            break;
        }
        case 1: {
            
            NSLog(@"女");
            [DataSourceTool updateMineInformation:@"sex" myValue:@"1" toViewController:self success:^(id json) {
                if ([json[@"errcode"] integerValue]==0) {
                    
                    USERINFO.sex = @"0";
                    [detailArr replaceObjectAtIndex:2 withObject:@"女"];
                    [tableview reloadData];
                }
            } failure:^(NSError *error) {
                
            }];
            
            break;
        }
        default:
            break;
    }
    }
    else
    {
        switch (indexPath) {
        case 0: {
            // 从手机相册选择
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
            {
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            }
            
            UIImagePickerController *pc = [[UIImagePickerController alloc] init];
            pc.view.backgroundColor = [UIColor whiteColor];
            pc.allowsEditing = YES;
            pc.delegate = self;
            pc.navigationBarHidden = YES;
            pc.sourceType = sourceType;
            [self.navigationController presentViewController:pc animated:YES completion:nil];
            
            break;
        }
        case 1: {
            
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                sourceType = UIImagePickerControllerSourceTypeCamera;
            }
            else
            {
                NSLog(@"请在真机下使用");
            }
            
            UIImagePickerController *pc = [[UIImagePickerController alloc] init];
            pc.view.backgroundColor = [UIColor whiteColor];
            pc.allowsEditing = YES;
            pc.delegate = self;
            pc.navigationBarHidden = YES;
            pc.sourceType = sourceType;
            [self.navigationController presentViewController:pc animated:YES completion:nil];
            
            break;
        }
        default:
            break;
    }
      
    
    }
}
#pragma mark - UIImagePickerController
// 当用户取消选取时调用
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    // 拍照
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
    
    NSData *imaData = UIImageJPEGRepresentation(image, 0.7);
    [DataSourceTool uploadImg:imaData toViewController:self success:^(id json) {
        
        if ([json[@"errcode"] integerValue]==0) {
            
            USERINFO.portrait = json[@"success"];
            
            [tableview reloadData];
            
            NSLog(@"上传成功%@",USERINFO.portrait);
        }
    } failure:^(NSError *error) {
        
        NSLog(@"上传失败");
        
    }];

}

#pragma mark - 照相之后，保存到相册
- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    
}

- (void)reFresh:(NSString *)str
{
    [detailArr replaceObjectAtIndex:1 withObject:USERINFO.memberName];
    [tableview reloadData];
}

#pragma mark - 当用户选取完成后,调用
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    viewController.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self setNeedsStatusBarAppearanceUpdate];
    
    viewController.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
    
    if (viewController.navigationController.viewControllers.count == 3)
    {
        [viewController.navigationController.navigationBar setHidden:YES];
    }
    else
    {
        [viewController.navigationController.navigationBar setHidden:NO];
    }
}


@end
