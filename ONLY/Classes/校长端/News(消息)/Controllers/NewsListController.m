//
//  NewsListController.m
//  ONLY
//
//  Created by Dylan on 16/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "NewsListController.h"
#import "PaymentNotiDetailController.h"
#import "CrowdFundDetailController.h"
#import "ConferenceDetailController.h"
#import "ServiceDetailController.h"
#import "CompetitionDetailController.h"
#import "IdeaDetailController.h"
#import "MineZCDetailController.h"
#import "MineComDetailController.h"
#import "MineOrderDetailController.h"
#import "MineServerDetailController.h"

#import "NewsListCell_1.h"
#import "NewsListCell_2.h"
#import "NewsListCell_3.h"
#import "NewsListCell_4.h"
#import "NewsListHeaderView.h"

#import "NewsItem.h"
#import "CrowdFundItem.h"
#import "ConferenceItem.h"
#import "ServiceItem.h"
#import "CompetitionItem.h"
#import "IdeaItem.h"

@interface NewsListController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSMutableArray * dataArray;
@end

@implementation NewsListController
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
    if ([self.tidingType integerValue]==1) {
        self.title = @"订单消息";
    }
    if ([self.tidingType integerValue]==2) {
        self.title = @"支付通知";
    }
    if ([self.tidingType integerValue]==3) {
        self.title = @"提议投诉消息";
    }
    if ([self.tidingType integerValue]==4) {
        self.title = @"系统通知";
    }
}

-(void)setupUI{
    self.view.backgroundColor = AppBackColor;
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 16, 0, 16));
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsListCell_1" bundle:nil] forCellReuseIdentifier:@"NewsListCell_1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsListCell_2" bundle:nil] forCellReuseIdentifier:@"NewsListCell_2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsListCell_3" bundle:nil] forCellReuseIdentifier:@"NewsListCell_3"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsListCell_4" bundle:nil] forCellReuseIdentifier:@"NewsListCell_4"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewsListHeaderView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"NewsListHeaderView"];
    
}
-(void)getData{
    [DataSourceTool findNewsType:self.tidingType ViewController:self success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"errcode"]integerValue]==0) {
            for (NSDictionary * dic in json[@"rsp"]) {
                NewsItem * item = [NewsItem new];
                [item setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:item];
            }
            [self.tableView reloadData];
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
    return 50;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NewsItem * item = self.dataArray[section];
    NewsListHeaderView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"NewsListHeaderView"];
    view.timeLabel.text = [self timeWithTimeIntervalString:item.add_date];
    return view;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsItem * item = self.dataArray[indexPath.section];
    if ([self.tidingType integerValue] == 1) {
        NewsListCell_1 * cell = [tableView dequeueReusableCellWithIdentifier:@"NewsListCell_1"];
        cell.item = item;
        return cell;
    }else if ([self.tidingType integerValue] == 2) {
        NewsListCell_2 * cell = [tableView dequeueReusableCellWithIdentifier:@"NewsListCell_2"];
        cell.item = item;
        return cell;
    }else if ([self.tidingType integerValue] == 3) {
        NewsListCell_3 * cell = [tableView dequeueReusableCellWithIdentifier:@"NewsListCell_3"];
        cell.item = item;
        return cell;
    }else if ([self.tidingType integerValue] == 4) {
        NewsListCell_4 * cell = [tableView dequeueReusableCellWithIdentifier:@"NewsListCell_4"];
        cell.item = item;
        return cell;
    }else{
        return nil;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsItem * item = self.dataArray[indexPath.section];
    if ([self.tidingType integerValue]==2) {
        PaymentNotiDetailController * vc = [PaymentNotiDetailController new];
        vc.item = item;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([self.tidingType integerValue]==3) {
        MineComDetailController * vc = [MineComDetailController new];
        vc.com_id = item.ID;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([self.tidingType integerValue]==4) {
        if ([item.type_id integerValue] == 1) {
            ConferenceDetailController * vc = [ConferenceDetailController new];
            ConferenceItem * conferenceItem = [ConferenceItem new];
            conferenceItem.course_id = item.ID;
            vc.item = conferenceItem;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([item.type_id integerValue] == 2) {
            MineZCDetailController * vc = [MineZCDetailController new];
            vc.apply_id = item.ID;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([item.type_id integerValue] == 3) {
            MineZCDetailController * vc = [MineZCDetailController new];
            vc.apply_id = item.ID;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([item.type_id integerValue] == 4) {
            MineZCDetailController * vc = [MineZCDetailController new];
            vc.apply_id = item.ID;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([item.type_id integerValue] == 5) {
            MineZCDetailController * vc = [MineZCDetailController new];
            vc.apply_id = item.ID;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([item.type_id integerValue] == 6) {
            MineOrderDetailController * vc = [MineOrderDetailController new];
            vc.order_num = item.ID;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([item.type_id integerValue] == 7) {
            MineServerDetailController * vc = [MineServerDetailController new];
            vc.order_sn = item.ID;
            [self.navigationController pushViewController:vc animated:YES];
        }
        if ([item.type_id integerValue] == 8) {
            CrowdFundDetailController * vc = [CrowdFundDetailController new];
            CrowdFundItem * crowdFundItem = [CrowdFundItem new];
            crowdFundItem.good_id = item.ID;
            vc.item = crowdFundItem;
            [self.navigationController pushViewController:vc animated:YES];
        }
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

- (NSString *)timeWithTimeIntervalString:(NSString *)aTimeString
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm"];
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[aTimeString doubleValue]];
    NSLog(@"%@",date);// 这个时间是格林尼治时间
    NSString *dat = [formatter stringFromDate:date];
    NSLog(@"%@", dat);// 这个时间是北京时间
    return dat;
    
}

@end
