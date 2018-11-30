//
//  PaySuccessController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/7/13.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "PaySuccessController.h"
#import "PayCenterCell.h"
#import "PayCenterCell_1.h"



#import "MineManyOrderController.h"
#import "MineMeetingController.h"
#import "MineServerController.h"

@interface PaySuccessController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@end

@implementation PaySuccessController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
    [self setupUI];
    [self setupBottomView];
   
}

-(void)setupNavi{
    self.title = @"支付成功";
    self.view.backgroundColor = AppBackColor;
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:@"back" complete:^{
        
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
}



-(void)setupUI{
    
    UIImageView * bgIV = [UIImageView new];
    bgIV.image = [UIImage imageNamed:@"head"];
    [self.view addSubview:bgIV];
    [bgIV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 50;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    
    self.tableView.tableFooterView = [UIView new];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 16, 63, 16));
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"PayCenterCell_1" bundle:nil] forCellReuseIdentifier:@"PayCenterCell_1"];
}

-(void)setupBottomView{
    
    UIView  *bottomBGView = [[UIView alloc]init];
    bottomBGView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:bottomBGView];
    [bottomBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(63);
    }];
    
    UIButton * btn = [UIButton new];
    [btn setTitle:@"继续逛" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.layer.cornerRadius = 4.f;
    [btn setBackgroundColor:colorWithRGB(0x00A9EB)];
    [btn jk_addActionHandler:^(NSInteger tag) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [bottomBGView addSubview:btn];
    btn.sd_layout.leftSpaceToView(bottomBGView, 16).topSpaceToView(bottomBGView, 9).widthIs(165*SCREEN_PRESENT).heightIs(45);
    
    UIButton * btn1 = [UIButton new];
    [btn1 setTitle:@"订单详情" forState:UIControlStateNormal];
    btn1.titleLabel.font = [UIFont systemFontOfSize:14];
    btn1.layer.cornerRadius = 4.f;
    [btn1 setBackgroundColor:colorWithRGB(0xF77142)];
    [btn1 jk_addActionHandler:^(NSInteger tag) {
        
        if ([self.order_type isEqualToString:@"0"]) {
            
            MineManyOrderController *vc = [MineManyOrderController new];
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        else if ([self.order_type isEqualToString:@"1"])
        {
            MineMeetingController *vc  = [MineMeetingController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            MineServerController *vc = [MineServerController new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    
    }];
    
    [bottomBGView addSubview:btn1];
    btn1.sd_layout.rightSpaceToView(bottomBGView, 16).topSpaceToView(bottomBGView, 9).widthIs(165*SCREEN_PRESENT).heightIs(45);

}

#pragma mark - UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
        return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        PayCenterCell_1 * cell = [tableView dequeueReusableCellWithIdentifier:@"PayCenterCell_1"];
        cell.priceLabel.text= @"";
        cell.PayNeed.text =@"";
        cell.countDownLabel.text= @"" ;
        cell.PayMessage .text = @"支付完成 等待审核...";
        return cell;
   
}



-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
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
            if (indexPath.section == 0) {
                layer.fillColor = [UIColor clearColor].CGColor;
            }else{
                layer.fillColor = [UIColor colorWithWhite:1.f alpha:1.f].CGColor;
            }
            
            
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
