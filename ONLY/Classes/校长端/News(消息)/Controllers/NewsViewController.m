//
//  NewsViewController.m
//  ONLY
//
//  Created by 上海点硕 on 2016/12/17.
//  Copyright © 2016年 cbl－　点硕. All rights reserved.
//

#import "NewsViewController.h"
#import "NewsListController.h"

#import "NewsListCollectionViewCell.h"

@interface NewsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic, strong)UICollectionView * collectionView;
@property(nonatomic, strong)NSMutableArray * dataArray;

@end

@implementation NewsViewController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
    [self setupUI];
    [self getData];
}

-(void)setupNavi{
    self.title = @"消息";
    kWeakSelf(self);
    UIButton * rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    [rightBtn setTitle:@"设为已读" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightBtn jk_addActionHandler:^(NSInteger tag) {
        [weakself readAllNews];
    }];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItems = @[rightItem];
    
}

-(void)setupUI{
    self.view.backgroundColor = colorWithRGB(0xf6f7fb);
    
    [self setupTableView];
}



-(void)setupTableView{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = CGSizeMake((screenWidth()-50)/2, (screenWidth()-40)/2);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(16, 16, 16, 16);
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = AppBackColor;
    
    [self.view addSubview:self.collectionView];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view);
    }];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"NewsListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"NewsListCollectionViewCell"];
}

-(void)getData{
    [DataSourceTool NewsNotReadViewController:self success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"errcode"]integerValue]==0) {
            self.dataArray = json[@"rsp"];
            [self.collectionView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 4;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    NewsListCollectionViewCell * cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"NewsListCollectionViewCell" forIndexPath:indexPath];
    if (indexPath.row < self.dataArray.count) {
        NSString *countStr =[NSString stringWithFormat:@"%@",self.dataArray[indexPath.row]];
        if ([countStr integerValue]==0) {
            cell.badgeBG.hidden = YES;
        }else{
            cell.badgeBG.hidden = NO;
            cell.badgeLabel.text = countStr;
        }
    }

    
    if (indexPath.row == 0) {
        cell.iconIV.image = [UIImage imageNamed:@"消息_dingdan"];
        cell.titleLabel.text = @"订单消息";
    }else if (indexPath.row == 1){
        cell.iconIV.image = [UIImage imageNamed:@"消息_zhifu"];
        cell.titleLabel.text = @"支付通知";
    }else if (indexPath.row == 2){
        cell.iconIV.image = [UIImage imageNamed:@"消息_tousu"];
        cell.titleLabel.text = @"提议投诉消息";
    }else if (indexPath.row == 3){
        cell.iconIV.image = [UIImage imageNamed:@"消息_xitong"];
        cell.titleLabel.text = @"系统通知";
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    NewsListController * vc = [NewsListController new];
    vc.tidingType = [NSString stringWithFormat:@"%ld",indexPath.row+1];
    [self.navigationController pushViewController:vc animated:YES];

}


#pragma mark - 网络请求
-(void)readAllNews{
    [DataSourceTool NewsAllReadViewController:self success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"errcode"]integerValue]==0) {
            NSArray * array = @[@"0",@"0",@"0",@"0"];
            self.dataArray = [array mutableCopy];
            [self.collectionView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
