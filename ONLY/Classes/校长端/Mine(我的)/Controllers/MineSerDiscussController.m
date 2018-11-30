//
//  MineSerDiscussController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/2/6.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineSerDiscussController.h"
#import "StarView.h"
#import "PlaceholderTextView.h"
#import "MineDiscussCell.h"
@interface MineSerDiscussController ()<UITableViewDelegate,UITableViewDataSource,StarViewDelegate,UIImagePickerControllerDelegate,SGActionSheetDelegate,UINavigationControllerDelegate>

@end

@implementation MineSerDiscussController
{
    TPKeyboardAvoidingTableView *tableview;
    UIImageView *cheakImg;
    BOOL isCheck;
    NSMutableArray *imgArrayData;
    NSMutableArray *imgArray;
    NSInteger neckName;
    NSInteger stars1;
    NSInteger stars2;
    NSString *desc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    imgArray = [NSMutableArray array];
    imgArrayData = [NSMutableArray array];
    self.view.backgroundColor = colorWithRGB(0xEFEFF4);
    
    self.fd_prefersNavigationBarHidden = YES;
    
    [self setNavView];
    
    [self makeBottobView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setTextView:) name:UITextViewTextDidChangeNotification object:nil];
    

}
- (void)setTextView:(NSNotification *)noti
{
    UITextView *textview = noti.object;
    desc = textview.text;
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
    titleLabel.text = @"发表评价";
    
    
    tableview = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    //tableview.separatorStyle= UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,16).topSpaceToView(view,0).bottomSpaceToView(self.view,64);
    cornerRadiusView(tableview, 3);
    tableview.showsVerticalScrollIndicator = NO;
    
}

- (void)makeBottobView
{
    UIView *bomView = [UIView new];
    [self.view addSubview:bomView];
    bomView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.85];
    bomView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view).heightIs(64);
    
    UIButton *btn = [UIButton new];
    [bomView addSubview:btn];
    btn.sd_layout.leftEqualToView(bomView).topSpaceToView(bomView,0).widthIs(120).bottomSpaceToView(bomView,0);
    [btn addTarget:self action:@selector(cheakBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    cheakImg = [UIImageView new];
    [btn addSubview:cheakImg];
    isCheck = NO;
    cheakImg.image = [UIImage imageNamed:@"pay_normal"];
    cheakImg.sd_layout.leftSpaceToView(btn,15).topSpaceToView(btn,20).widthIs(19).heightIs(19);
    
    
    UILabel *label = [UILabel new];
    [btn addSubview:label];
    label.font = font(13);
    label.textColor = colorWithRGB(0x333333);
    label.text = @"匿名评价";
    label.sd_layout.leftSpaceToView(cheakImg,9).topSpaceToView(btn,19).widthIs(52).heightIs(14);
    
    UIButton *confirmBtn = [UIButton new];
    [bomView addSubview:confirmBtn];
    confirmBtn.sd_layout.rightSpaceToView(bomView,12).topSpaceToView(bomView,10).widthIs(76).heightIs(33);
    confirmBtn.backgroundColor = colorWithRGB(0xF77142);
    cornerRadiusView(confirmBtn, 3);
    [confirmBtn setTitle:@"提交评价" forState:UIControlStateNormal];
    confirmBtn.titleLabel.font = font(12);
    [confirmBtn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [confirmBtn addTarget:self action:@selector(confirmBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

//提交评价
- (void)confirmBtnClick
{
    NSString *str  = [NSString stringWithFormat:@"%ld,%ld",stars1,stars2];
    [DataSourceTool addDiscussTypeId:[NSString stringWithFormat:@"%ld",neckName] comment_content:desc comment_type:@"2" comment_img:imgArrayData comment_star:str comment_id:self.ser_id ViewController:self success:^(id json) {
        
        if ([json[@"errcode"] integerValue]==0) {
            
            [self.navigationController popViewControllerAnimated:YES];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)cheakBtnClick
{
    isCheck = !isCheck;
    if (isCheck==YES) {
        
        cheakImg.image = [UIImage imageNamed:@"cheak"];
        neckName = 0;
    }
    else
    {
        cheakImg.image = [UIImage imageNamed:@"pay_normal"];
        neckName = 1;
    }
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
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
            return 102;
        }
        else {
            return 237;
        }
    }
    else
    {
        return 123;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId1 = @"MineDiscussCell";
    static NSString *cellId2 = @"MineDiscussCell2";
    static NSString *cellId3 = @"MineDiscussCell3";
    
    MineDiscussCell *cell1 = [tableView dequeueReusableCellWithIdentifier:cellId1];
    UITableViewCell *cell2 = [tableView dequeueReusableCellWithIdentifier:cellId2];
    UITableViewCell *cell3 = [tableView dequeueReusableCellWithIdentifier:cellId3];
    
    cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    cell2.selectionStyle = UITableViewCellSelectionStyleNone;
    cell3.selectionStyle = UITableViewCellSelectionStyleNone;

    if (cell1==nil) {
        
        cell1 = [[[NSBundle mainBundle]loadNibNamed:@"MineDiscussCell" owner:nil options:nil] firstObject];
    }
    
    if (cell2==nil) {
        cell2 = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId2];

        PlaceholderTextView *textView = [PlaceholderTextView new];
        textView.font = font(14);
        textView.tag = 200;
        textView.placeholder = @"写下对此次服务的感受";
        [cell2.contentView addSubview:textView];
        textView.sd_layout.leftSpaceToView(cell2.contentView,17).topSpaceToView(cell2.contentView,16).heightIs(120).rightSpaceToView(cell2.contentView,12);
        
        for (int i = 0; i<3; i++) {
            UIButton *btn = [UIButton new];
            [cell2.contentView addSubview:btn];
            btn.tag = 300+i;
            [btn setImage:[UIImage imageNamed:@"上传照片"] forState:UIControlStateNormal];
            btn.sd_layout.leftSpaceToView(cell2.contentView,12*(i+1)+i*90).topSpaceToView(textView,3).widthIs(90).heightIs(90);
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
        NSArray *arr = @[@"服务态度",@"服务效果"];
        for (int i = 0; i<2; i++) {
            
            UILabel *titleLabel = [UILabel new];
            [cell3.contentView addSubview:titleLabel];
            titleLabel.font = font(14);
            titleLabel.text = arr[i];
            titleLabel.textColor = colorWithRGB(0x333333);
            titleLabel.sd_layout.leftSpaceToView(cell3.contentView,12).topSpaceToView(cell3.contentView,25+i*25).widthIs(56).heightIs(14);
            
            StarView *starView = [[StarView alloc] initWithFrame:CGRectMake(90*SCREEN_PRESENT, 25+i*25, 200, 25) EmptyImage:@"graystar" StarImage:@"redstar"];
            
            starView.delegate = self;
            starView.tag = 700+i;
            [cell3.contentView addSubview:starView];
        }
    
    }
    //************************cell set  value *********************//
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell1.abc.text = self.abc;
            cell1.price.text = self.ser_price;
            cell1.supportTime.text = self.supportTime;
            cell1.address.text = self.address;
            cell1.range.text = self.range;
            cell1.number.text = self.ser_number;
            if ([self.sex isEqualToString:@"0"]) {
                cell1.sex.image = [UIImage imageNamed:@"member_mine_male"];
            }
            else
            {
                cell1.sex.image = [UIImage imageNamed:@"member_mine_female"];
            }
            return cell1;
        }
        else
        {
            for (int i = 0; i<imgArray.count; i++) {
                UIButton *btn = [cell2.contentView viewWithTag:300+i];
                [btn setImage:imgArray[i] forState:UIControlStateNormal];
                UIButton *btn1 = [cell2.contentView viewWithTag:303+i];
                [btn1 setHidden:NO];
            }
            
            cell2.selectionStyle = UITableViewCellSelectionStyleNone;
            
            UITextView *textview = [cell2.contentView viewWithTag:200];
            textview.text = desc;
            return cell2;
        }
    }
    
    else
    {
        return cell3;
    }
}

//评价的代理
- (void)SGActionSheet:(StarView *)StarView index:(NSInteger)index
{
    NSLog(@"猜猜我是几颗星%ld",index);
    if (StarView.tag==700) {
        stars1 = index+1;
    }
    else
    {
        stars2 = index+1;
    }
    NSLog(@"猜猜我是几颗星%ld",index);
}

- (void)makeLabel:(UILabel *)label font:(CGFloat)fonts color:(UIColor *)color text:(NSString *)str
{
    label.text = str;
    label.font = font(fonts);
    label.textColor = color;
    label.textAlignment = NSTextAlignmentLeft;
}

//选者图片
- (void)selectedImg:(UIButton *)btn
{
    UITextView *textView = [self.view viewWithTag:200];
    [textView resignFirstResponder];
    
    SGActionSheet *sheet = [[SGActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitleArray:@[@"相册", @"拍照"]];
    sheet.cancelButtonTitleColor = [UIColor redColor];
    
    [sheet show];
    
}

- (void)SGActionSheet:(SGActionSheet *)actionSheet didSelectRowAtIndexPath:(NSInteger)indexPath {
    NSLog(@"indexPath = %ld", indexPath);
    NSUInteger sourceType = 0;
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

@end
