//
//  ServiceWaiterListController.m
//  ONLY
//
//  Created by Dylan on 08/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "ServiceWaiterListController.h"
#import "ServiceConfirmOrderController.h"
#import "ServiceWaiterSortingView.h"
#import "ServiceWaiterListCell.h"
#import "FilterView.h"
#import "ServiceManItem.h"
#import "ServiceWaiterFilterView.h"
#import "UIViewController+HUD.h"
@interface ServiceWaiterListController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * tableView;
@property(nonatomic,strong)ServiceWaiterSortingView * sortView;
@property(nonatomic,strong)NSString * sortType;
@property(nonatomic,strong)NSString * sortOrder;
@property(nonatomic,strong)NSString * level_id;
@property(nonatomic,assign)NSInteger pageIndex;
@property(nonatomic,strong)NSMutableArray * dataArray;
@property(nonatomic,strong)NSMutableArray * filterArray;
@end

@implementation ServiceWaiterListController
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
-(NSMutableArray *)filterArray{
    if (!_filterArray) {
        _filterArray = [NSMutableArray new];
    }
    return _filterArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
    [self setupNavi];
    [self setupUI];
    [self getData];
    [self getFilterData];
}

-(void)commonInit{
    self.sortType = @"sort";
    self.sortOrder = @"DESC";
    self.pageIndex = 1;
    self.level_id = @"0";
}

-(void)setupNavi{
    self.title = @"服务人员";
    kWeakSelf(self);
    UIBarButtonItem * filterItem = [[UIBarButtonItem alloc]initWithImage:@"产品众筹_filter" complete:^{
        NSLog(@"filterItem");
        ServiceWaiterFilterView * filterView = [[[NSBundle mainBundle]loadNibNamed:@"ServiceWaiterFilterView" owner:nil options:nil]firstObject];
        [filterView setDataBlock:^(ServiceWaiterFilterView * filterView) {
            filterView.dataArray = weakself.filterArray;
            [filterView.collectionView reloadData];
        }];
        [filterView setBtnAction_block:^(NSInteger index,NSString * type_id) {
            weakself.level_id = type_id;
            [weakself reloadData];
        }];
        [filterView show];
    }];
    
    self.navigationItem.rightBarButtonItem = filterItem;
}
-(void)setupUI{
    self.view.backgroundColor = colorWithRGB(0xf6f7fb);
    
    [self setupSortView];
    [self setupTableView];
    
}

-(void)setupSortView{
    self.sortView = [[[NSBundle mainBundle]loadNibNamed:@"ServiceWaiterSortingView" owner:nil options:nil]firstObject];
    kWeakSelf(self);
    [self.sortView setBtnAction_block:^(NSInteger index,sortType sortType,sortOrder sortOrder) {
        
        if (index == 1) {
            
            weakself.sortType = @"sort";
            
        }else if (index == 2){

            weakself.sortType = @"service_count";
            
        }else if (index == 3){
            weakself.sortType = @"service_price";
        }
        
        if (sortOrder == sortOrder_Down) {
            weakself.sortOrder = @"ASC";
        }else{
            weakself.sortOrder = @"DESC";
        }
        
        [weakself reloadData];
    }];
    
    [self.view addSubview:self.sortView];
    [self.sortView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
        make.height.mas_equalTo(60);
    }];
}

-(void)setupTableView{
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 120;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.backgroundColor = colorWithRGB(0xf6f7fb);
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.sortView.mas_bottom);
        make.left.bottom.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 16, 0, 16));
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ServiceWaiterListCell" bundle:nil] forCellReuseIdentifier:@"ServiceWaiterListCell"];
}

-(void)reloadData{
    kWeakSelf(self);
    weakself.pageIndex = 1;
    [weakself getData];
}

-(void)getData{
    NSDictionary * param = @{
                             @"service_id": self.serviceItem.service_id,
                             @"member_id": USERINFO.memberId,
                             @"activity_time": self.selectedActivityDate,
                             @"sort":self.sortType,
                             @"sortOrder":self.sortOrder,
                             @"page":@(self.pageIndex),
                             @"level_id": self.level_id
                             };
    [DataSourceTool serviceManListWithParam:param toViewController:self success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"errcode"]integerValue]==0) {
            if (self.pageIndex==1) {
                [self.dataArray removeAllObjects];
                [self.filterArray removeAllObjects];
                [self.tableView.mj_header endRefreshing];
                [self.tableView.mj_footer endRefreshing];
            }else{
                if (((NSArray*)json[@"list"]).count == 0) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.tableView.mj_footer endRefreshing];
                }
            }
            self.pageIndex++;

            for (NSDictionary * dic in json[@"list"]) {
                ServiceManItem * item = [ServiceManItem new];
                [item setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:item];
            }
            for (NSDictionary * dic in json[@"level"]) {
                FilterItem * item = [FilterItem new];
                item.type_id = dic[@"level_id"];
                item.type_name = dic[@"level_name"];
                [self.filterArray addObject:item];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

-(void)getFilterData{
    
    NSDictionary * param = @{
                             @"type":@"2"
                             };
    
    [DataSourceTool filterListWithParam:param toViewController:self success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"errcode"]integerValue]==0) {
            //            [json[@"data"][0]createPropertyCode];
            for (NSDictionary * dic in json[@"data"]) {
                FilterItem * item = [FilterItem new];
                [item setValuesForKeysWithDictionary:dic];
                [self.filterArray addObject:item];
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}

#pragma mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell * )tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ServiceWaiterListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"ServiceWaiterListCell"];
    ServiceManItem * manItem = self.dataArray[indexPath.section];
    cell.manItem = manItem;
    cell.btnAction_block = ^(NSInteger index){
        ServiceConfirmOrderController * vc = [ServiceConfirmOrderController new];
        vc.serviceItem = self.serviceItem;
        vc.manItem = manItem;
        vc.selectedActivityDate = self.selectedActivityDate;
        [self.navigationController pushViewController:vc animated:YES];
    };
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    if ([view isKindOfClass: [UITableViewHeaderFooterView class]]) {
        UITableViewHeaderFooterView* castView = (UITableViewHeaderFooterView*) view;
        
        castView.backgroundView.backgroundColor = colorWithRGB(0xf6f7fb);
    }
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0,13,0,13)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0,13,0,13)];
    }
    if ([cell respondsToSelector:@selector(tintColor)]) {
        if (tableView == self.tableView) {
            CGFloat cornerRadius = 3.f;
            cell.backgroundColor = UIColor.clearColor;
            CAShapeLayer *layer = [[CAShapeLayer alloc] init];
            CGMutablePathRef pathRef = CGPathCreateMutable();
            CGRect bounds = CGRectInset(cell.bounds, 0, 0);
            BOOL addLine = NO;
            if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            } else if (indexPath.row == 0) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
                addLine = YES;
            } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
                CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
                CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
                CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
                
            } else {
                CGPathAddRect(pathRef, nil, bounds);
                addLine = YES;
            }
            layer.path = pathRef;
            CFRelease(pathRef);
            layer.fillColor = [UIColor colorWithWhite:1.f alpha:1.f].CGColor;
            
            if (addLine == YES) {
                CALayer *lineLayer = [[CALayer alloc] init];
                CGFloat lineHeight = (1.f / [UIScreen mainScreen].scale);
                lineLayer.frame = CGRectMake(CGRectGetMinX(bounds)+14, bounds.size.height-lineHeight, bounds.size.width-28, lineHeight);
                lineLayer.backgroundColor = tableView.separatorColor.CGColor;
                [layer addSublayer:lineLayer];
            }
            UIView *testView = [[UIView alloc] initWithFrame:bounds];
            [testView.layer insertSublayer:layer atIndex:0];
            testView.backgroundColor = UIColor.clearColor;
            cell.backgroundView = testView;
        }
    }
}


@end
