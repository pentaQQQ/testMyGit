//
//  CompetitionEnrollController.m
//  ONLY
//
//  Created by Dylan on 15/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "CompetitionEnrollController.h"
#import "CompetitionEnrollCell_1.h"
#import "CompetitionEnrollCell_2.h"
#import "CompetitionEnrollCell_3.h"
#import "CompetitionEnrollCell_4.h"

#import "UIViewController+method.h"
#import "UIViewController+HUD.h"
#import "TZImagePickerController.h"

#import <CTAssetsPickerController/CTAssetsPickerController.h>
@import Photos;
@interface CompetitionEnrollController ()<UITableViewDelegate,UITableViewDataSource,CTAssetsPickerControllerDelegate,SGActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSString * videoUrl;
@property (nonatomic, strong) NSMutableArray * profileArray;
@property (nonatomic, strong) NSMutableArray * imageArray;//保存选择的参赛图片
@property (nonatomic, strong) NSData * videoData;//保存选择的视频
@property (nonatomic, strong) UIImage * headImage;//保存选择的头像
@property (nonatomic, strong) NSString * imageType;//当前选择图片的类型（是选择头像，还是参赛照片）
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * phoneNum;
@property (nonatomic, strong) NSString * brief;

@end

@implementation CompetitionEnrollController{
    UIView * _bottomBGView;
}

-(NSMutableArray *)imageArray{
    if (!_imageArray) {
        _imageArray = [NSMutableArray new];
    }
    return _imageArray;
}

-(NSMutableArray *)profileArray{
    if (!_profileArray) {
        _profileArray = [NSMutableArray new];
    }
    return _profileArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupProfile];
    [self setupNavi];
    [self setupUI];
}

-(void)setupProfile{
    
    
    [self.profileArray addObject:@"CompetitionEnrollCell_1"];
    if ([self.item.is_photo integerValue] == 1) {
        [self.profileArray addObject:@"CompetitionEnrollCell_2"];
    }
    if ([self.item.is_video integerValue] == 1) {
        if (self.videoUrl) {
            [self.profileArray addObject:@"CompetitionEnrollCell_4"];
        }else{
            [self.profileArray addObject:@"CompetitionEnrollCell_3"];
        }
    }
}


-(void)setupNavi{
    self.view.backgroundColor = AppBackColor;
    self.title = @"报名";
}

-(void)setupUI{
    [self setupBottomView];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 16, 63, 16));
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CompetitionEnrollCell_1" bundle:nil] forCellReuseIdentifier:@"CompetitionEnrollCell_1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CompetitionEnrollCell_2" bundle:nil] forCellReuseIdentifier:@"CompetitionEnrollCell_2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CompetitionEnrollCell_3" bundle:nil] forCellReuseIdentifier:@"CompetitionEnrollCell_3"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CompetitionEnrollCell_4" bundle:nil] forCellReuseIdentifier:@"CompetitionEnrollCell_4"];
}


-(void)setupBottomView{
    kWeakSelf(self);
    _bottomBGView = [[UIView alloc]init];
    _bottomBGView.backgroundColor = [UIColor whiteColor];
    
    
    [self.view addSubview:_bottomBGView];
    [_bottomBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(63);
    }];
    
    UIButton * btn = [UIButton new];
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.layer.cornerRadius = 4.f;
    [btn setBackgroundColor:colorWithRGB(0xFD7240)];
    [btn jk_addActionHandler:^(NSInteger tag) {
        [weakself sendMediaSource];
    }];
    
    [_bottomBGView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_bottomBGView).insets(UIEdgeInsetsMake(9, 16, 9, 16));
    }];
    
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.profileArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    kWeakSelf(self);
    NSString * cellName = self.profileArray[indexPath.section];

    
    if ([cellName isEqualToString:@"CompetitionEnrollCell_1"]) {
        CompetitionEnrollCell_1 * cell = [tableView dequeueReusableCellWithIdentifier:@"CompetitionEnrollCell_1"];
        cell.image = self.headImage;
        [cell setChooseHeadImage_block:^{
            weakself.imageType = @"header";
            [weakself chooseImage];
        }];
        [cell setName_block:^(NSString *content) {
            weakself.name = content;
        }];
        [cell setPhoneNum_block:^(NSString *content) {
            weakself.phoneNum = content;
        }];
        [cell setBrief_block:^(NSString *content) {
            weakself.brief = content;
        }];
        return cell;
    }else if ([cellName isEqualToString:@"CompetitionEnrollCell_2"]){
        CompetitionEnrollCell_2 * cell = [tableView dequeueReusableCellWithIdentifier:@"CompetitionEnrollCell_2"];
        cell.imageArray = self.imageArray;
        [cell setDeleteImage_block:^(NSInteger index) {
            [weakself.imageArray removeObjectAtIndex:index];
            [weakself.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }];
        return cell;
    }else if ([cellName isEqualToString:@"CompetitionEnrollCell_3"]){
        if (self.videoUrl) {
            CompetitionEnrollCell_4 * cell = [tableView dequeueReusableCellWithIdentifier:@"CompetitionEnrollCell_4"];
            
            [cell playVideoWithUrlStr:self.videoUrl];
            [cell setDeleteVideo_block:^{
                weakself.videoUrl = nil;
                [tableView reloadData];
            }];
            return cell;
            
        }else{
            CompetitionEnrollCell_3 * cell = [tableView dequeueReusableCellWithIdentifier:@"CompetitionEnrollCell_3"];
            return cell;
        }

    }else{
        return nil;
    }
    
    
    

}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    kWeakSelf(self);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        self.imageType = @"others";
        if (self.imageArray.count == 3) {
            return;
        }
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:3 delegate:nil];
        imagePickerVc.naviBgColor = colorWithRGB(0x00A5E9);
        // You can get the photos by block, the same as by delegate.
        // 你可以通过block或者代理，来得到用户选择的照片.
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray *photos, NSArray *assets,BOOL isSelectOriginalPhoto) {
            weakself.imageArray = [photos mutableCopy];
            [weakself.tableView reloadData];
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
//        [self chooseImage];
    }
    if (indexPath.section == 2) {
        if (self.videoUrl) {
            return;
        }else{
            [self chooseVideo];
        }
    }
}

-(void)chooseVideo{
    
    UIImagePickerController *pc = [[UIImagePickerController alloc] init];
    pc.view.backgroundColor = [UIColor whiteColor];
    pc.allowsEditing = YES;
    pc.delegate = self;
    pc.navigationBarHidden = YES;
    pc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pc.mediaTypes = [NSArray arrayWithObjects:@"public.movie",  nil];
//    NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
//    pc.mediaTypes = [NSArray arrayWithObject:availableMedia[1]];//设置媒体类型为public.movie
    [self presentViewController:pc animated:YES completion:nil];

}

-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    
    if ([view isKindOfClass: [UITableViewHeaderFooterView class]]) {
        UITableViewHeaderFooterView* castView = (UITableViewHeaderFooterView*) view;
        
        castView.backgroundView.backgroundColor = AppBackColor;
    }

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
-(void)chooseAsset:(PHAssetCollectionSubtype)type {
    kWeakSelf(self);
    // request authorization status
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status){
        dispatch_async(dispatch_get_main_queue(), ^{
            
            // init picker
            CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
            
            // set delegate
            picker.delegate = self;
            picker.showsSelectionIndex = YES;
            picker.defaultAssetCollection = type;
            
            // Optionally present picker as a form sheet on iPad
            if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
                picker.modalPresentationStyle = UIModalPresentationFormSheet;
            
            // present picker
            [weakself presentViewController:picker animated:YES completion:nil];
        });
    }];

}
#pragma mark - 网络请求
-(void)sendMediaSource{
    
    if (!self.headImage) {
        [self showAlertViewWithMessage:@"请添加头像"];
        return;
    }
    if (!self.name) {
        [self showAlertViewWithMessage:@"请填写名字"];
        return;
    }

    if (!self.phoneNum) {
        [self showAlertViewWithMessage:@"请填写手机号"];
        return;
    }else if (self.phoneNum.length > 11){
        [self showAlertViewWithMessage:@"手机号码为11位数字"];
        return;
    }

    if (!self.brief) {
        [self showAlertViewWithMessage:@"请添备注"];
        return;
    }
    
    if ([self.item.is_photo integerValue]==1) {
        if (self.imageArray.count==0) {
            [self showAlertViewWithMessage:@"请添加照片"];
            return;
        }
    }
    if ([self.item.is_video integerValue]==1) {
        if (!self.videoData) {
            [self showAlertViewWithMessage:@"请添加视频"];
            return;
        }
    }
    
    NSMutableArray * fileDataArray = [NSMutableArray new];
    NSMutableArray * nameArray = [NSMutableArray new];
    NSMutableArray * fileNameArray = [NSMutableArray new];
    NSMutableArray * fileTypeArray = [NSMutableArray new];
    
    
    if (self.headImage) {
        NSData * portraitData = UIImageJPEGRepresentation(self.headImage,1);
        [fileDataArray addObject:portraitData];
        [nameArray addObject:@"portrait1"];
        [fileNameArray addObject:@"portrait1.jpg"];
        [fileTypeArray addObject:@"image/jpg"];
    }
    if (self.imageArray.count >0) {
        for (int i=0; i<self.imageArray.count; i++) {
            UIImage * image = self.imageArray[i];
            NSData * imageData = UIImageJPEGRepresentation(image,1);
            [fileDataArray addObject:imageData];
            [nameArray addObject:[NSString stringWithFormat:@"img%d",i+1]];
            [fileNameArray addObject:[NSString stringWithFormat:@"img%d.jpg",i+1]];
            [fileTypeArray addObject:@"image/jpg"];
        }
    }
    
    if (self.videoData) {
        [fileDataArray addObject:self.videoData];
        [nameArray addObject:@"video1"];
        [fileNameArray addObject:@"video1.mp4"];
        [fileTypeArray addObject:@"video/mp4"];
    }
    
    NSDictionary * param = @{
                             @"match_id":self.item.match_id,
                             @"member_id":USERINFO.memberId,
                             @"name":self.name,
                             @"mobile":self.phoneNum,
                             @"brief":self.brief
                             };
    
    [DataSourceTool competitionEnrollWithParam:param fileData:fileDataArray name:nameArray fileName:fileNameArray fileType:fileTypeArray toViewController:self success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"errcode"]integerValue]==0) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [self showAlertViewWithMessage:@"服务器错误"];
    }];
    
}

#pragma mark - CTAssetsPickerControllerDelegate

- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets{
    
    
}


- (void)assetsPickerController:(CTAssetsPickerController *)picker didSelectAsset:(PHAsset *)asset{
    NSLog(@"%@",asset);
    
    kWeakSelf(self);

    if (asset.mediaType == PHAssetMediaTypeVideo) {
        PHVideoRequestOptions *options = [[PHVideoRequestOptions alloc] init];
        options.version = PHImageRequestOptionsVersionCurrent;
        options.deliveryMode = PHVideoRequestOptionsDeliveryModeAutomatic;
        
        PHImageManager *manager = [PHImageManager defaultManager];
        [manager requestAVAssetForVideo:asset options:options resultHandler:^(AVAsset * _Nullable asset, AVAudioMix * _Nullable audioMix, NSDictionary * _Nullable info) {
            AVURLAsset *urlAsset = (AVURLAsset *)asset;
            
            NSURL *url = urlAsset.URL;
            NSData *data = [NSData dataWithContentsOfURL:url];
            
            if (data.length/1000/1000 > 50) {
                [weakself showAlertViewWithMessage:@"视频大于50M无法上传"];
                return ;
            }else{
                weakself.videoUrl = url.absoluteString;
                weakself.videoData = data;
            }
            
        }];
    }
    
    [picker dismissViewControllerAnimated:YES completion:^{
        [weakself.tableView reloadData];
    }];
    
}

#pragma mark - 选择照片
//选择图片按钮的上传
- (void)chooseImage{
    
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
       
    }
}

#pragma mark - UIImagePickerController
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    kWeakSelf(self);
    //获取媒体类型
    NSString* mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
     if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
         UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
         
         // 拍照
         if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
         {
             UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
         }
         
         
         if ([self.imageType isEqualToString:@"header"]) {
             self.headImage = image;
         }else{
             [self.imageArray addObject:image];
         }

     }else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
         //获取视频文件的url
         NSURL* mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
         
         NSData *data = [NSData dataWithContentsOfURL:mediaURL];
         
         if (data.length/1000/1000 > 50) {
             NSLog(@"%lu",data.length/1000/1000);
             [weakself showAlertViewWithMessage:@"视频大于50M无法上传"];
             return ;
         }else{
             weakself.videoUrl = mediaURL.absoluteString;
             weakself.videoData = data;
         }
     }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    [self.tableView reloadData];
    
}

#pragma mark - 照相之后，保存到相册
- (void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo{
    
}

#pragma mark - 当用户选取完成后,调用
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
