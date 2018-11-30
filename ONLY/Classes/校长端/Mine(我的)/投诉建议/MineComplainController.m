//
//  MineComplainController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/2/7.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineComplainController.h"
#import "PlaceholderTextView.h"
#import "MineComListController.h"
#import "InterestModel.h"
#import "MBProgressHUD+Extension.h"
@interface MineComplainController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,SGActionSheetDelegate,UINavigationControllerDelegate>

@end

@implementation MineComplainController
{
    UITableView *tableview;
    NSMutableArray *dataArray;
    NSMutableArray *dataArray1;
    NSString *typeID;
    NSString *typeName;
    NSMutableArray *imgArrayData;
    NSMutableArray *imgArray;
    NSString *QQ;
    NSString *desc;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = colorWithRGB(0xEFEFF4);
    self.fd_prefersNavigationBarHidden = YES;
    imgArray = [NSMutableArray array];
    imgArrayData = [NSMutableArray array];
    [self setNavView];
    [self loadTypeList];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setMobileText:) name:UITextFieldTextDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setTextView:) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)setTextView:(NSNotification *)noti
{
    UITextView *textview = noti.object;
    desc = textview.text;
    
}


-(void)setMobileText:(NSNotification *)noti{
    UITextField * tf = noti.object;
    QQ = tf.text;
    NSLog(@"%@",tf.text);
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
    titleLabel.text = @"投诉建议";
    
    UIButton *btn = [UIButton new];
    [view addSubview:btn];
    [btn setTitle:@"历史反馈" forState:UIControlStateNormal];
    [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
    btn.sd_layout.widthIs(58).rightSpaceToView(view,16).heightIs(14).topSpaceToView(view,38);
    btn.titleLabel.font = font(14);
    [btn addTarget:self action:@selector(lookHistory) forControlEvents:UIControlEventTouchUpInside];
    
    tableview = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableview.separatorStyle= UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,16).topSpaceToView(view,0).bottomSpaceToView(self.view,0);
    cornerRadiusView(tableview, 3);
    tableview.showsVerticalScrollIndicator = NO;
    
}

//查看历史反馈
- (void)lookHistory
{
    MineComListController *vc  = [MineComListController new];
    [self.navigationController pushViewController:vc animated:YES];

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0)
    {
        return 2;
    }
    else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
            return 44;
        }
        else{
            return 245;
        }
    }
    else if( indexPath.section==1)
    {
        return 47;
    }
    return 75 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId1 = @"Complaincell1";
    static NSString *cellId2 = @"Complaincell2";
    static NSString *cellId3 = @"Complaincell3";
    static NSString *cellId4 = @"Complaincell4";
    
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellId1];
    UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellId2];
    UITableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:cellId3];
    UITableViewCell *cell4 = [tableView dequeueReusableCellWithIdentifier:cellId4];
    
    if (cell1==nil) {
        
        cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId1];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell1.backgroundColor = [UIColor clearColor];
        
        UIView *view = [UIView new];
        view.backgroundColor = WhiteColor;
        [cell1.contentView addSubview:view];
        cornerRadiusView(view, 3);
        view.sd_layout.leftSpaceToView(cell1.contentView,0).rightSpaceToView(cell1.contentView,0).topSpaceToView(cell1.contentView,0).heightIs(44);
        
        UILabel *titleLabel = [UILabel new];
        [view addSubview:titleLabel];
        [self makeLabel:titleLabel font:14 color:colorWithRGB(0x333333) text:@"选择投诉类型"];
        titleLabel.sd_layout.leftSpaceToView(view,16).topSpaceToView(view,16).widthIs(86).heightIs(14);
        
        UIImageView *imageview = [UIImageView new];
        [view addSubview:imageview];
        imageview.image = [UIImage imageNamed:@"member_right_arrow"];
        imageview.sd_layout.rightSpaceToView(view,16).topSpaceToView(view,16).widthIs(10).heightIs(14);
        
        UILabel *detailLabel = [UILabel new];
        [view addSubview:detailLabel];
        [self makeLabel:detailLabel font:14 color:colorWithRGB(0x333333) text:@""];
        detailLabel.tag = 888;
        detailLabel.textAlignment = NSTextAlignmentRight;
        detailLabel.sd_layout.leftSpaceToView(titleLabel,10).topSpaceToView(view,16).rightSpaceToView(imageview, 10).heightIs(14);
        
        
    }
    if (cell2==nil) {
        
        cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId2];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        cell2.backgroundColor = [UIColor clearColor];
        
        UIView *view = [UIView new];
        view.backgroundColor = WhiteColor;
        [cell2.contentView addSubview:view];
        cornerRadiusView(view, 3);
        view.sd_layout.leftSpaceToView(cell2.contentView,0).rightSpaceToView(cell2.contentView,0).topSpaceToView(cell2.contentView,1).heightIs(245);
        
        PlaceholderTextView *textView = [PlaceholderTextView new];
        [view addSubview:textView];
        textView.tag = 101;
        textView.placeholder = @"请输入您想要投诉的详情";
        textView.sd_layout.leftSpaceToView(view,16).rightSpaceToView(view,10).heightIs(118).topSpaceToView(view,16);
        textView.font = font(14);
        
        for (int i = 0; i<3; i++) {
            
            UIButton *btn = [UIButton new];
            [view addSubview:btn];
            btn.tag = 300+i;
            [btn setImage:[UIImage imageNamed:@"上传照片"] forState:UIControlStateNormal];
            btn.sd_layout.leftSpaceToView(view,16*(i+1)+i*90).topSpaceToView(textView,15).widthIs(90).heightIs(90);
            [btn addTarget:self action:@selector(selectedImg:) forControlEvents:UIControlEventTouchUpInside];
            
            UIButton *delbtn= [UIButton new];
            [btn addSubview:delbtn];
            delbtn.tag = 303+i;
            [delbtn setHidden:YES];
            [delbtn setImage:[UIImage imageNamed:@"delete_image"] forState:UIControlStateNormal];
            delbtn.sd_layout.rightSpaceToView(btn,0).topSpaceToView(btn,0).heightIs(15).widthIs(15);
            [delbtn addTarget:self action:@selector(deleteImg:) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    if (cell3==nil) {
        
        cell3 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId3];
        cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        cell3.backgroundColor = [UIColor clearColor];
        
        UIView *view = [UIView new];
        view.backgroundColor = WhiteColor;
        [cell3.contentView addSubview:view];
        cornerRadiusView(view, 3);
        view.sd_layout.leftSpaceToView(cell3.contentView,0).rightSpaceToView(cell3.contentView,0).topSpaceToView(cell3.contentView,10).heightIs(47);
        
        UITextField *textField = [UITextField new];
        textField.tag = 100;
        [view addSubview:textField];
        textField.placeholder = @"手机号/QQ/邮箱";
        textField.sd_layout.leftSpaceToView(view,14).rightSpaceToView(view,10).heightIs(14).topSpaceToView(view,17);
        textField.font = font(14);
        
    }
    if (cell4==nil) {
        
        cell4 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId3];
        cell4.selectionStyle = UITableViewCellSelectionStyleNone;
        cell4.backgroundColor = [UIColor clearColor];
        
        UIView *view = [UIView new];
        view.backgroundColor = colorWithRGB(0xEFEFF4);
        [cell4.contentView addSubview:view];
        cornerRadiusView(view, 3);
        view.sd_layout.leftSpaceToView(cell4.contentView,0).rightSpaceToView(cell4.contentView,0).topSpaceToView(cell4.contentView,10).heightIs(75);
        
        UIButton *btn = [UIButton new];
        [view addSubview:btn];
        btn.backgroundColor = colorWithRGB(0x00A9EB);
        [btn setTitle:@"提交" forState:UIControlStateNormal];
        [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
        btn.sd_layout.leftSpaceToView(view,0).rightSpaceToView(view,0).heightIs(45).topSpaceToView(view,15);
        [btn addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = font(14);
        cornerRadiusView(btn, 4);
    }

    //******************CellSetValue********************//
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            
            UILabel *label = [cell1.contentView viewWithTag:888];
            label.text = typeName;
            return cell1;
        }
        else {
            for (int i = 0; i<imgArray.count; i++) {
                
                UIButton *btn = [cell2.contentView viewWithTag:300+i];
                [btn setImage:imgArray[i] forState:UIControlStateNormal];
                
                UIButton *btn1 = [cell2.contentView viewWithTag:303+i];
                [btn1 setHidden:NO];
            }
            UITextView *textview = [cell2.contentView viewWithTag:101];
            textview.text = desc;
            return cell2;
        }
        
    }
    else if (indexPath.section==1)
    {
        UITextField *textField = [cell3.contentView viewWithTag:100];
        textField.text = QQ;
        return cell3;
    }
    else{
        
       
        return cell4;
    }
    
}


//点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   if(indexPath.section==0&&indexPath.row==0)
   {
       SGActionSheet *sheet = [[SGActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitleArray:dataArray];
       sheet.cancelButtonTitleColor = [UIColor redColor];
       sheet.tag = 10001;
       [sheet show];
   }

}

- (void)SGActionSheet:(SGActionSheet *)actionSheet didSelectRowAtIndexPath:(NSInteger)indexPath
{
    NSUInteger sourceType = 0;
    if (actionSheet.tag==10000) {
        
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
                [self presentViewController:pc animated:YES completion:nil];
                
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
                [self  presentViewController:pc animated:YES completion:nil];
                
                break;
            }
            default:
                break;
        }
    }
    else
    {
        typeID =  dataArray1[indexPath];
        typeName = dataArray[indexPath];
        [tableview reloadData];
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
    
    [imgArrayData addObject:UIImageJPEGRepresentation(image, 0.7)];
    [imgArray addObject:image];
    [tableview reloadData];
    NSLog(@"++++%@ ______%lu",imgArray,(unsigned long)imgArray.count);
}


#pragma mark - 照相之后，保存到相册
- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    
}

#pragma mark - 当用户选取完成后,调用
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)deleteImg:(UIButton *)btn
{
    if (btn.tag==303) {
        [imgArray removeObjectAtIndex:0];
        [imgArrayData removeObjectAtIndex:0];
    }
    else if (btn.tag==304)
    {
        [imgArray removeObjectAtIndex:1];
        [imgArrayData removeObjectAtIndex:1];
    }
    
    else
    {
        [imgArray removeObjectAtIndex:2];
        [imgArrayData removeObjectAtIndex:2];
        
    }
    
    [tableview reloadData];
    
}

- (void)makeLabel:(UILabel *)label font:(CGFloat)fonts color:(UIColor *)color text:(NSString *)str
{
    label.text = str;
    label.font = font(fonts);
    label.textColor = color;
    label.textAlignment = NSTextAlignmentLeft;
}

//选择图片按钮的上传
- (void)selectedImg:(UIButton *)btn
{
    
    UITextField *textField = [self.view viewWithTag:100];
    UITextView *textview = [self.view viewWithTag:101];
    
    [textField resignFirstResponder];
    [textview resignFirstResponder];
  
    SGActionSheet *sheet = [[SGActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitleArray:@[@"相册", @"拍照"]];
    sheet.cancelButtonTitleColor = [UIColor redColor];
    sheet.tag = 10000;
    [sheet show];
    
}

- (void)loadTypeList
{
    [DataSourceTool disTypeViewController:self success:^(id json) {
        if ([json[@"errcode"] integerValue]==0) {
            NSMutableArray *temp = [NSMutableArray array];
            NSMutableArray *temp1 = [NSMutableArray array];
            for (NSDictionary *dic in json[@"rsp"]) {
                InterestModel *model = [InterestModel new];
                [model setValuesForKeysWithDictionary:dic];
                [temp addObject:model.type_name];
                [temp1 addObject:model.type_id];
            }
            
            dataArray = temp;
            dataArray1 = temp1;
        }
    
    } failure:^(NSError *error) {
        
    }];
}


- (void)confirmClick
{
    if (desc.length==0||typeID.length==0||QQ.length==0) {
        
        [MBProgressHUD showFailure:@"请完善反馈信息" toView:self.view];
    }
    else{
        
    [DataSourceTool disConfirm:@"" synopsis:desc position_id:typeID mobile:QQ file:imgArrayData ViewController:self success:^(id json) {
        
        if ([json[@"errcode"] integerValue]==0) {
            MineComListController *vc  = [MineComListController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    } failure:^(NSError *error) {
        
    }];
    }

}

@end
