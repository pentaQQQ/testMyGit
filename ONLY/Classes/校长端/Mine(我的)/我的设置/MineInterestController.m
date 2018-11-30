//
//  MineInterestController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/2/9.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineInterestController.h"
#import "MineMemberCell.h"
#import "Masonry.h"
#import "BaseTabBarController.h"
#import "InterestModel.h"
#import "UICollectionView+Sure_Placeholder.h"
#import "MBProgressHUD+Extension.h"
@interface MineInterestController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong, nonatomic)UICollectionView *collectionView;
@end

const float edgeleft = 38;
const float edgeright = 38;
@implementation MineInterestController
{
    UITableView *tableview;
    NSArray *titleArr;
    NSArray *detailArr;
    NSMutableArray *dataArray;
    float corner;
    NSString *typeID;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = colorWithRGB(0xEFEFF4);
    self.fd_prefersNavigationBarHidden = YES;
    titleArr = @[@[@"珠心算" ,@"作文" ,@"数学" ,@"英语"]];
    
    detailArr = @[@[@"",@"",@""],@[@"",@"",@"",@"" ],@[@"",@"当前版本：V1.0.1"],@[@""]];;
    
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
    titleLabel.text = @"兴趣关注";
    
    //确定是水平滚动，还是垂直滚动
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView=[[UICollectionView alloc] initWithFrame:CGRectMake(16, 104, SCREEN_WIDTH-32, SCREEN_HEIGHT-200) collectionViewLayout:flowLayout];
    self.collectionView.dataSource=self;
    self.collectionView.delegate=self;
    [self.collectionView setBackgroundColor:WhiteColor];
    cornerRadiusView(self.collectionView, 3);
    
    //注册Cell，必须要有
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    [self.view addSubview:self.collectionView];
    
    self.collectionView.firstReload = YES;
    
    [self setFootView];
}

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return dataArray.count;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * CellIdentifier = @"UICollectionViewCell";
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 101;
    btn.selected = NO;
    btn.userInteractionEnabled = NO;
    cornerRadiusView(btn, corner);
    [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
    btn.titleLabel.font = font(12);
    UIImageView *checkImg = [UIImageView new];
    checkImg.tag = 100;
  
    
    [btn setBackgroundImage:[UIImage imageNamed:@"bg"] forState:UIControlStateNormal];
    checkImg.image = [UIImage imageNamed:@"selected"];
    for (id subView in cell.contentView.subviews) {
        [subView removeFromSuperview];
    }
    
    [cell.contentView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(cell.contentView);
    }];
    [btn addSubview:checkImg];
    checkImg.sd_layout.rightSpaceToView(btn,5).bottomSpaceToView(btn,5).widthIs(19).heightIs(19);
    
    InterestModel *model = dataArray[indexPath.item];
    if ([model.selected isEqualToString:@"0"]) {
        [checkImg setHidden:YES];
    }
    else
    {
       [checkImg setHidden:NO];
    }
    
    [btn setTitle:model.type_name forState:UIControlStateNormal];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSString *httpUrl = [NSString stringWithFormat:@"%@%@",Choose_Base_URL,model.type_img];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:httpUrl]];
        [btn setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
    });

    return cell;
}

//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    float width = (collectionView.width-edgeleft-edgeright-2*edgeleft)/3.0;
    
    float height = width;
    corner = width/2;
    return CGSizeMake(width, height);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(38, edgeleft, 5, edgeright);
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    UIImageView *img = [cell.contentView viewWithTag:100];
    UIButton *btn = [cell.contentView viewWithTag:101];
    btn.selected = !btn.selected;
    InterestModel *model = dataArray[indexPath.item];
    if (btn.selected==YES) {
        [img setHidden:NO];
        model.selected = @"1";
    }
    else
    {
        [img setHidden:YES];
        model.selected = @"0";
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"selected like '1'"];
    NSArray *arr = [dataArray filteredArrayUsingPredicate:predicate];
    NSMutableArray *temp = [NSMutableArray array];
    
    for (InterestModel *model1 in arr) {

        [temp addObject:model1.type_id];
    }
    typeID = [temp componentsJoinedByString:@","];
    
//    NSLog(@"item======%ld",(long)indexPath.item);
//    NSLog(@"row=======%ld",(long)indexPath.row);
//    NSLog(@"section===%ld",(long)indexPath.section);
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)setFootView
{
    UIButton *btn = [UIButton new];
    [self.view addSubview:btn];
    btn.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,16).heightIs(45).bottomSpaceToView(self.view,14);
    btn.backgroundColor = colorWithRGB(0x0099E3);
    btn.titleLabel.font = font(14);
    [btn setTitle:@"选好了，保存" forState:UIControlStateNormal];
    [btn setTitleColor:WhiteColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(saveBtnClick) forControlEvents:UIControlEventTouchUpInside];
    cornerRadiusView(btn, 4);
}

- (void)saveBtnClick
{
    //注册界面跳到这个界面
    if (self.typeVc == 0) {
        [UIApplication sharedApplication].delegate.window.rootViewController = [BaseTabBarController new].tabBarController ;
        
    }
    //我的设置
   else
    {
        if (typeID.length>0) {
           
            [DataSourceTool updateMineInformation:@"typeId" myValue:typeID toViewController:self success:^(id json) {
                
                if ([json[@"errcode"] integerValue]==0) {
                    
                    USERINFO.typeId = typeID;
                    [MBProgressHUD showSuccess:@"保存成功" toView:self.view complete:nil];
                }
                
            } failure:^(NSError *error) {
                
            }];

        }
        else
        {
            [MBProgressHUD showFailure:@"抱歉您没有修改兴趣关注" toView:self.view];
        }
        
       
    }
}

- (void)loadData
{
   [DataSourceTool findTypetoViewController:self success:^(id json) {
       NSMutableArray *temp = [NSMutableArray array];
       if ([json[@"errcode"] integerValue]==0) {
           
           NSLog(@"%@",json[@"rsp"]);
           for (NSDictionary *dic in json[@"rsp"]) {
              
               InterestModel *model = [[InterestModel alloc] init];
               [model setValuesForKeysWithDictionary:dic];
                model.selected = @"0";
               [temp addObject:model];
            
           }
           
           dataArray = temp;
           NSCharacterSet *set=[NSCharacterSet characterSetWithCharactersInString:@","];
           NSArray *arr6=  [USERINFO.typeId componentsSeparatedByCharactersInSet:set];
           
           for (InterestModel *model1 in dataArray) {
               
               for (NSString *typeId in arr6) {
                   
                   if ([typeId isEqualToString:model1.type_id]) {
                       model1.selected = @"1";
                   }
               }
           }
           
           [self.collectionView reloadData];
       }
   } failure:^(NSError *error) {
       
   }];

}

@end
