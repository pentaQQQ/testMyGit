//
//  ConferenceDetailConfirmOrderController.m
//  ONLY
//
//  Created by Dylan on 06/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "ConferenceDetailConfirmOrderController.h"
#import "PayCenterController.h"


#import "ConferenceDetailConfirmOrderCell_1.h"
#import "ConferenceDetailConfirmOrderCell_2.h"
#import "ConferenceDetailConfirmOrderCell_3.h"
#import "ConferenceDetailConfirmOrderCell_4.h"
#import "ReceiptView.h"
#import "AddMemberView.h"
#import "ConferenceDetailConfirmOrderBottomView.h"

#import "PeopleItem.h"
#import "UIViewController+HUD.h"
#import "UIViewController+method.h"
@interface ConferenceDetailConfirmOrderController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong) UITableView * tableView;
@property(nonatomic, strong) ConferenceDetailConfirmOrderBottomView * bottomView;
@property(nonatomic, strong) NSMutableArray * dataArray;
@property(nonatomic, strong) NSMutableArray * trainerArray;
@property(nonatomic, strong) NSString * receiptInfo;
@property(nonatomic, strong)NSString * identity;//纳税人识别号
@property(nonatomic, strong)NSString * receiptType;//0个人 1公司 -1不要发票
@property(nonatomic, assign)BOOL  has_receipt;


@end

@implementation ConferenceDetailConfirmOrderController
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
-(NSMutableArray *)trainerArray{
    if (!_trainerArray) {
        _trainerArray = [NSMutableArray new];
    }
    return _trainerArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self commonInit];
    [self setupNavi];
    [self setupUI];
    [self getData];
    
}
-(void)commonInit{
    self.receiptInfo = @"不开发票";
    self.has_receipt = NO;
    self.identity = @"";
    self.receiptType  = @"-1";
    
}

-(void)setupNavi{
    self.title = @"确认订单";
    self.view.backgroundColor = AppBackColor;
    self.automaticallyAdjustsScrollViewInsets = YES;
}
-(void)setupUI{
    [self setupBottomView];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView setContentInset:UIEdgeInsetsMake(20, 0, 0, 0)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 16, 63, 16));
    }];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ConferenceDetailConfirmOrderCell_1" bundle:nil] forCellReuseIdentifier:@"ConferenceDetailConfirmOrderCell_1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ConferenceDetailConfirmOrderCell_2" bundle:nil] forCellReuseIdentifier:@"ConferenceDetailConfirmOrderCell_2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ConferenceDetailConfirmOrderCell_3" bundle:nil] forCellReuseIdentifier:@"ConferenceDetailConfirmOrderCell_3"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ConferenceDetailConfirmOrderCell_4" bundle:nil] forCellReuseIdentifier:@"ConferenceDetailConfirmOrderCell_4"];
}
-(void)setupBottomView{
    self.bottomView = [[[NSBundle mainBundle]loadNibNamed:@"ConferenceDetailConfirmOrderBottomView" owner:nil options:nil]lastObject];
    self.bottomView.item = self.item;
    
    self.bottomView.priceLabel.text = [NSString stringWithFormat:@"¥%ld",[self.item.unit_price integerValue]*self.trainerArray.count];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(63);
    }];
    kWeakSelf(self);
    self.bottomView.btnAction_block = ^(NSInteger index){
        if (index == 1) {
            NSLog(@"");
            
            [weakself addOrder];
        }
    };
}


-(void)getData{
    NSDictionary * param = @{
                             @"member_id":USERINFO.memberId
                             };
    [DataSourceTool peopleListWithParam:param toViewController:self success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"errcode"]integerValue]==0) {
            for (NSDictionary * dic in json[@"list"]) {
                PeopleItem * item = [PeopleItem new];
                [item setValuesForKeysWithDictionary:dic];
                [self.dataArray addObject:item];
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
//    for (int i = 0 ; i<10; i++) {
//        NSString * name = [NSString stringWithFormat:@"%d",arc4random()%100];
//        [self.dataArray addObject:name];
//    }
//    [self.tableView reloadData];
}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return self.trainerArray.count+1;
    }
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    kWeakSelf(self);
    if (indexPath.section == 0) {
        ConferenceDetailConfirmOrderCell_1 * cell = [tableView dequeueReusableCellWithIdentifier:@"ConferenceDetailConfirmOrderCell_1"];
        cell.item = self.item;
        return cell;
    }
    else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            ConferenceDetailConfirmOrderCell_3 * cell = [tableView dequeueReusableCellWithIdentifier:@"ConferenceDetailConfirmOrderCell_3"];
            cell.titleLabel.text = @"添加培训人员";
            cell.detailLabel.text = @"";
            return cell;
        }else{
            ConferenceDetailConfirmOrderCell_2 * cell = [tableView dequeueReusableCellWithIdentifier:@"ConferenceDetailConfirmOrderCell_2"];
            [cell.operateBtn setTitle:@"取消" forState:UIControlStateNormal];
            PeopleItem * item = self.trainerArray[indexPath.row-1];
            cell.nameLabel.text = item.name;
            cell.btnAction_block = ^(NSInteger index){
                [weakself.trainerArray removeObjectAtIndex:indexPath.row-1];
                [weakself.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
                weakself.bottomView.priceLabel.text = [NSString stringWithFormat:@"¥%ld",[self.item.unit_price integerValue]*self.trainerArray.count];
            };
            return cell;
        }
    }
    else{
        ConferenceDetailConfirmOrderCell_3 * cell = [tableView dequeueReusableCellWithIdentifier:@"ConferenceDetailConfirmOrderCell_3"];
        cell.titleLabel.text = @"发票信息";
        cell.detailLabel.text = self.receiptInfo?self.receiptInfo:@"不开发票";
        
        return cell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    kWeakSelf(self);
    if (indexPath.section == 1 && indexPath.row == 0) {
        NSLog(@"选择培训人");
        AddMemberView * view = [[[NSBundle mainBundle]loadNibNamed:@"AddMemberView" owner:nil options:nil]firstObject];
        view.dataArray = self.dataArray;
        [view setBtnAction_block:^(NSArray * array) {
            weakself.trainerArray = [array mutableCopy];
            [weakself.tableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationFade];
            weakself.bottomView.priceLabel.text = [NSString stringWithFormat:@"¥%ld",[self.item.unit_price integerValue]*self.trainerArray.count];
        }];
        [view show];
    }
    else if (indexPath.section == 2){
        NSLog(@"选择发票");
        ReceiptView * view =  [[[NSBundle mainBundle]loadNibNamed:@"ReceiptView" owner:nil options:nil]firstObject];
        
        if (weakself.has_receipt) {
            [view setDataWithReceiptType:weakself.receiptType companyName:weakself.receiptInfo identity:weakself.identity];
        }
        view.btnAction_block = ^(NSInteger index, NSString *companyName, NSString *identity, NSString * receiptType){
            weakself.identity = identity;
            weakself.receiptType = receiptType;
            weakself.receiptInfo = companyName;
            if ([companyName isEqualToString:@"不开发票"]) {
                weakself.has_receipt = NO;
            }else{
                weakself.has_receipt = YES;
            }
            [weakself.tableView reloadData];
        };
        [view show];
        
    }
}

-(void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section{
    if ([view isKindOfClass: [UITableViewHeaderFooterView class]]) {
        UITableViewHeaderFooterView* castView = (UITableViewHeaderFooterView*) view;

        castView.backgroundView.backgroundColor = [UIColor clearColor];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
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
                CGFloat lineHeight = 2.f;
                lineLayer.frame = CGRectMake(CGRectGetMinX(bounds), bounds.size.height-lineHeight, bounds.size.width, lineHeight);
                lineLayer.backgroundColor = AppBackColor.CGColor;
                [layer addSublayer:lineLayer];
            }
            UIView *testView = [[UIView alloc] initWithFrame:bounds];
            [testView.layer insertSublayer:layer atIndex:0];
            testView.backgroundColor = UIColor.clearColor;
            cell.backgroundView = testView;
        }
    }
}

-(BOOL)checkData{
    
    if (self.trainerArray.count == 0) {
        [self showAlertViewWithMessage:@"请选择培训人员"];
        return NO;
    }
    return YES;
}

#pragma mark - 网络请求
-(void)addOrder{
    if (![self checkData]) {
        return;
    };
    NSString * peopleIDs = [NSString string] ;
    for (PeopleItem * item in self.trainerArray) {
        peopleIDs = [peopleIDs stringByAppendingString:[NSString stringWithFormat:@"%@,",item.member_person_id]];
    }
    peopleIDs = [peopleIDs substringToIndex:peopleIDs.length-1];
    
    NSDictionary * param = @{
                             @"course_id":self.item.course_id,
                             @"member_id":USERINFO.memberId,
                             @"person_ids":peopleIDs,
                             @"has_invoice":@(self.has_receipt),
                             @"invoice_type":self.receiptType,
                             @"invoice_taxes":self.identity,
                             @"invoice_title":self.receiptInfo
                             };
    [DataSourceTool addConferenceOrderListWithParam:param toViewController:self success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"errcode"]integerValue]==0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                PayCenterController * vc = [PayCenterController new];
                vc.order_type = @"1";
                vc.endTime = json[@"expire_time"];
                vc.price = json[@"all_amount"];
                vc.order_sn = ((NSArray*)json[@"order_sns"]).firstObject?((NSArray*)json[@"order_sns"]).firstObject:@"";
                [self.navigationController pushViewController:vc animated:YES];
            });
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
    
}




@end
