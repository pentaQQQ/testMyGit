//
//  AddViewController.m
//  ONLY
//
//  Created by 上海点硕 on 2016/12/17.
//  Copyright © 2016年 cbl－　点硕. All rights reserved.
//

#import "AddViewController.h"
#import "PlaceholderTextView.h"
#import "InterestModel.h"
#import "MBProgressHUD+Extension.h"
@interface AddViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,SGActionSheetDelegate,UINavigationControllerDelegate>

@end

@implementation AddViewController
{
    TPKeyboardAvoidingTableView *tableview ;
    BOOL isCheck;
    NSMutableArray *imgArrayData;
    NSMutableArray *imgArray;
    NSMutableArray *dataArray;
    NSMutableArray *dataArray1;
    NSString *typeID;
    NSString *typeName;
    NSString *price;
    NSString *productName;
    NSString *desc;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    imgArray = [NSMutableArray array];
    imgArrayData = [NSMutableArray array];
    self.view.backgroundColor = colorWithRGB(0xEFEFF4);
    
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
    if (tf.tag == 100) {
        productName = tf.text;
    }
    else
    {
        price = tf.text;
    }
    
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
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    UILabel *titleLabel = [UILabel new];
    [view addSubview:titleLabel];
    titleLabel.textColor= WhiteColor;
    titleLabel.font = font(18);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.sd_layout.leftSpaceToView(view,50).rightSpaceToView(view,50).heightIs(17).topSpaceToView(view,35);
    titleLabel.text = @"众筹提议";

    tableview = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableview.separatorStyle= UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,16).topSpaceToView(view,0).bottomSpaceToView(self.view,64);
    cornerRadiusView(tableview, 3);
    tableview.showsVerticalScrollIndicator = NO;
    
    [self makeBottomView];

}

- (void)makeBottomView
{
    UIView *bomView = [UIView new];
    [self.view addSubview:bomView];
    bomView.backgroundColor = WhiteColor;
    bomView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view).heightIs(64);
    
    UIButton *btn = [UIButton new];
    btn.backgroundColor = colorWithRGB(0xFD7240);
    [bomView addSubview:btn];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
    btn.sd_layout.leftSpaceToView(bomView,16).rightSpaceToView(bomView,16).topSpaceToView(bomView,9).heightIs(45);
    [btn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
    cornerRadiusView(btn, 4);

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 3;
    }
    
        return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
            
            return 56;
        }
        else if (indexPath.row==1)
        {
            return 44;
        }
        else{
            return 240;
        }
    }
    else if( indexPath.section==1)
    {
        return 62;
    }
    
    return 167 ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId1 = @"Addcell1";
    static NSString *cellId2 = @"Addcell2";
    static NSString *cellId3 = @"Addcell3";
    static NSString *cellId4= @"Addcell4";
    static NSString *cellId5 = @"Addcell5";
    
    UITableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellId1];
    UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellId2];
    UITableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:cellId3];
    UITableViewCell *cell4 = [tableView dequeueReusableCellWithIdentifier:cellId4];
    UITableViewCell *cell5 = [tableView dequeueReusableCellWithIdentifier:cellId5];
    if (cell5==nil) {
        
        cell5 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId5];
        cell5.selectionStyle = UITableViewCellSelectionStyleNone;
        cell5.backgroundColor = [UIColor clearColor];
        
        UIView *view = [UIView new];
        view.backgroundColor = WhiteColor;
        [cell5.contentView addSubview:view];
        cornerRadiusView(view, 3);
        view.sd_layout.leftSpaceToView(cell5.contentView,0).rightSpaceToView(cell5.contentView,0).topSpaceToView(cell5.contentView,0).heightIs(240);
        
        PlaceholderTextView *textView = [PlaceholderTextView new];
        textView.placeholder = @"描述众筹的目的";
        textView.font = font(14);
        textView.tag = 103;
        [view addSubview:textView];
        textView.sd_layout.leftSpaceToView(view,16).rightSpaceToView(view,16).topSpaceToView(view,12).bottomSpaceToView(view,5);
        
    }
    
    if (cell4==nil) {
        
        cell4 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId4];
        cell4.selectionStyle = UITableViewCellSelectionStyleNone;
        cell4.backgroundColor = [UIColor clearColor];
        
        UIView *view = [UIView new];
        view.backgroundColor = WhiteColor;
        [cell4.contentView addSubview:view];
        cornerRadiusView(view, 3);
        view.sd_layout.leftSpaceToView(cell4.contentView,0).rightSpaceToView(cell4.contentView,0).topSpaceToView(cell4.contentView,0).heightIs(44);
        
        UILabel *titleLabel = [UILabel new];
        [view addSubview:titleLabel];
        [self makeLabel:titleLabel font:14 color:colorWithRGB(0x333333) text:@"类别"];
        titleLabel.sd_layout.leftSpaceToView(view,15).topSpaceToView(view,15).widthIs(56).heightIs(14);
        
        UIView *lineView = [UIView new];
        lineView.alpha = 0.3;
        [view addSubview:lineView];
        lineView.backgroundColor = colorWithRGB(0x999999);
        lineView.sd_layout.leftEqualToView(view).rightEqualToView(view).heightIs(1).topSpaceToView(view,43);
        
        UILabel *detailLabel = [UILabel new];
        [view addSubview:detailLabel];
        detailLabel.tag = 104;
        [self makeLabel:detailLabel font:14 color:colorWithRGB(0x666666) text:@"学科"];
        detailLabel.textAlignment = NSTextAlignmentRight;
        detailLabel.sd_layout.rightSpaceToView(view,15).topSpaceToView(view,15).widthIs(56).heightIs(14);
    }
    
    if (cell1==nil) {
        
        cell1 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId1];
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        cell1.backgroundColor = [UIColor clearColor];
        
        UIView *view = [UIView new];
        view.backgroundColor = WhiteColor;
        [cell1.contentView addSubview:view];
        cornerRadiusView(view, 3);
        view.sd_layout.leftSpaceToView(cell1.contentView,0).rightSpaceToView(cell1.contentView,0).topSpaceToView(cell1.contentView,0).heightIs(56);
        
        UILabel *titleLabel = [UILabel new];
        [view addSubview:titleLabel];
        [self makeLabel:titleLabel font:14 color:colorWithRGB(0x333333) text:@"产品名称"];
        titleLabel.sd_layout.leftSpaceToView(view,15).topSpaceToView(view,25).widthIs(56).heightIs(14);
        
        UITextField *textField = [UITextField new];
        [view addSubview:textField];
        textField.tag = 100;
        textField.placeholder = @"用一句话描述您的产品";
        textField.sd_layout.leftSpaceToView(titleLabel,14).rightSpaceToView(view,10).heightIs(14).topSpaceToView(view,25);
        textField.font = font(14);

        UIView *lineView = [UIView new];
        lineView.alpha = 0.3;
        [view addSubview:lineView];
        lineView.backgroundColor = colorWithRGB(0x999999);
        lineView.sd_layout.leftEqualToView(view).rightEqualToView(view).heightIs(1).topSpaceToView(titleLabel,16);
    }
    if (cell2==nil) {
        
        cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId2];
        cell2.selectionStyle = UITableViewCellSelectionStyleNone;
        cell2.backgroundColor = [UIColor clearColor];
        UIView *view = [UIView new];
        view.backgroundColor = WhiteColor;
        [cell2.contentView addSubview:view];
        cornerRadiusView(view, 3);
        view.sd_layout.leftSpaceToView(cell2.contentView,0).rightSpaceToView(cell2.contentView,0).topSpaceToView(cell2.contentView,10).heightIs(62);
        
        UILabel *titleLabel = [UILabel new];
        [view addSubview:titleLabel];
        [self makeLabel:titleLabel font:14 color:colorWithRGB(0x333333) text:@"参考价格"];
        titleLabel.sd_layout.leftSpaceToView(view,15).topSpaceToView(view,25).widthIs(56).heightIs(14);
        
        UITextField *textField = [UITextField new];
        [view addSubview:textField];
        textField.tag = 101;
        textField.placeholder = @"大致预估下产品的单价";
        textField.sd_layout.leftSpaceToView(titleLabel,14).rightSpaceToView(view,10).heightIs(14).topSpaceToView(view,25);
        textField.font = font(14);
        
        
    }
    if (cell3==nil) {
        
        cell3 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId3];
        cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        cell3.backgroundColor = [UIColor clearColor];
        
        UIView *view = [UIView new];
        view.backgroundColor = WhiteColor;
        [cell3.contentView addSubview:view];
        cornerRadiusView(view, 3);
        view.sd_layout.leftSpaceToView(cell3.contentView,0).rightSpaceToView(cell3.contentView,0).topSpaceToView(cell3.contentView,10).heightIs(167);
        
        UILabel *titleLabel = [UILabel new];
        [view addSubview:titleLabel];
        [self makeLabel:titleLabel font:14 color:colorWithRGB(0x333333) text:@"参考图片"];
        titleLabel.sd_layout.leftSpaceToView(view,15).topSpaceToView(view,25).widthIs(56).heightIs(14);
        
        UILabel *titleLabel1 = [UILabel new];
        [view addSubview:titleLabel1];
        [self makeLabel:titleLabel1 font:14 color:colorWithRGB(0x999999) text:@"(最多3张)"];
        titleLabel1.sd_layout.leftSpaceToView(titleLabel,5).topSpaceToView(view,25).widthIs(60).heightIs(14);
        for (int i = 0; i<3; i++) {
            
            UIButton *btn = [UIButton new];
            [view addSubview:btn];
            btn.tag = 300+i;
            [btn setImage:[UIImage imageNamed:@"上传照片"] forState:UIControlStateNormal];
            btn.sd_layout.leftSpaceToView(view,(16*(i+1)+i*90)*SCREEN_PRESENT).topSpaceToView(titleLabel,15).widthIs(90*SCREEN_PRESENT).heightIs(90*SCREEN_PRESENT);
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
    
//******************CellSetValue********************//
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            
            UITextField *textField = [cell1.contentView viewWithTag:100];
            textField.text = productName;
            
             return cell1;
        }
        else if (indexPath.row==1)
        {
            UILabel *detailLabel = [cell4.contentView viewWithTag:104];
            detailLabel.text = typeName;
            return cell4;
        }
        else{
            UITextView *textView = [cell5.contentView viewWithTag:103];
            textView.text = desc;
            return cell5;
        }
  
    }
    else if (indexPath.section==1)
    {
        UITextField *textField = [cell2.contentView viewWithTag:101];
        textField.text = price;
        return cell2;
    }
    else{
        
        for (int i = 0; i<imgArray.count; i++) {
            
            UIButton *btn = [cell3.contentView viewWithTag:300+i];
            [btn setImage:imgArray[i] forState:UIControlStateNormal];
            UIButton *btn1 = [cell3.contentView viewWithTag:303+i];
            [btn1 setHidden:NO];
        }
        
        cell3.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell3;
    }

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0&&indexPath.row==1) {
        
        SGActionSheet *sheet = [[SGActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitleArray:dataArray];
        sheet.cancelButtonTitleColor = [UIColor redColor];
        sheet.tag = 10001;
        [sheet show];
    }

}

//提交按钮
- (void)confirmBtnClick
{
    if(productName.length>0&&price.length>0&&desc.length>0&&typeName.length>0)
    {
        [DataSourceTool addZCTypeId:typeID apply_name:productName apply_desc:desc apply_price:price apply_type:@"0" file:imgArrayData ViewController:self success:^(id json) {
            if ([json[@"errcode"] integerValue]==0) {
                 [self dismissViewControllerAnimated:YES completion:nil];
            }
            
        } failure:^(NSError *error) {
            
        }];
    }
    else
    {
        [MBProgressHUD showFailure:@"请完善信息" toView:self.view complete:nil];
    }
  

}

//选择图片按钮的上传
- (void)selectedImg:(UIButton *)btn
{
    UITextView *textview = [self.view viewWithTag:103];
    UITextField *textField = [self.view viewWithTag:101];
    UITextField *textField1 = [self.view viewWithTag:100];
    [textview resignFirstResponder];
    [textField resignFirstResponder];
    [textField1 resignFirstResponder];
    
    SGActionSheet *sheet = [[SGActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitleArray:@[@"相册", @"拍照"]];
    sheet.cancelButtonTitleColor = [UIColor redColor];
    sheet.tag = 10000;
    [sheet show];
    
}

- (void)SGActionSheet:(SGActionSheet *)actionSheet didSelectRowAtIndexPath:(NSInteger)indexPath {
    NSLog(@"indexPath = %ld", indexPath);
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

- (void)loadTypeList
{
    
  [DataSourceTool typeList:@"0" ViewController:self success:^(id json) {
      
      if ([json[@"errcode"] integerValue]==0) {
          NSMutableArray *temp = [NSMutableArray array];
          NSMutableArray *temp1 = [NSMutableArray array];
          for (NSDictionary *dic in json[@"data"][0][@"list"]) {
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

- (void)makeLabel:(UILabel *)label font:(CGFloat)fonts color:(UIColor *)color text:(NSString *)str
{
    label.text = str;
    label.font = font(fonts);
    label.textColor = color;
    label.textAlignment = NSTextAlignmentLeft;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
