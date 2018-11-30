//
//  MineComDetailController.m
//  ONLY
//
//  Created by 上海点硕 on 2017/2/8.
//  Copyright © 2017年 cbl－　点硕. All rights reserved.
//

#import "MineComDetailController.h"
#import "MineComDetailCell.h"
#import "ComplainModel.h"
@interface MineComDetailController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property (nonatomic ,strong) UIView *shareview;
@property(nonatomic, assign) NSInteger rows;
@end

@implementation MineComDetailController
{
    UITableView *tableview;
    NSArray *dataArray;
    NSArray *commmentArray;
    UIView *bgView;        //遮盖VIEW
    UIView *sendView;      //键盘view
    UITextView *inputView; //评论框
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = colorWithRGB(0xEFEFF4);
    self.fd_prefersNavigationBarHidden = YES;
    [self setNavView];
    [self makeBottomView];
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
    titleLabel.text = @"反馈详情";
    
    tableview = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableview.separatorStyle= UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.sd_layout.leftSpaceToView(self.view,16).rightSpaceToView(self.view,16).topSpaceToView(view,0).bottomSpaceToView(self.view,0);
    cornerRadiusView(tableview, 3);
    tableview.showsVerticalScrollIndicator = NO;
    tableview.estimatedRowHeight = 125;//必须设置好预估值
    tableview.rowHeight = UITableViewAutomaticDimension;
    [tableview registerNib:[UINib nibWithNibName:@"MineComDetailCell" bundle:nil] forCellReuseIdentifier:@"MineComDetailCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return commmentArray.count+1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==0) {
        return 40;
    }
    else
    {
        return 0.00000001;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineComDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MineComDetailCell"];
    ComplainModel *model = dataArray[0];
    
    if (indexPath.section==0) {
        cell.name.text = model.position_name;
        [cell.head sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,model.portrait]] placeholderImage:nil];
        cell.detail.text = model.synopsis;
        cell.time1.text = [self becomeTime:model.add_date];
    }
    else
    {
        ComplainModel *model1 = commmentArray[indexPath.section-1];
        cell.name.text = model1.position_name;
        [cell.head sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,model1.portrait]] placeholderImage:nil];
        cell.detail.text = model1.synopsis;    
        cell.time1.text = [self becomeTime:model1.add_date];
    
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


//加载网络数据
- (void)loadData
{
    
  [DataSourceTool getComplaint:self.com_id ViewController:self success:^(id json) {
      
      if ([json[@"errcode"] integerValue]==0) {
          NSMutableArray *temp = [NSMutableArray array];
           NSMutableArray *temp1 = [NSMutableArray array];
          for (NSDictionary *dic in json[@"rsp"]) {
              ComplainModel *model = [ComplainModel new];
              [model setValuesForKeysWithDictionary:dic];
              [temp addObject:model];
          }
          
          for (NSDictionary *dic in json[@"comment"]) {
              ComplainModel *model = [ComplainModel new];
              [model setValuesForKeysWithDictionary:dic];
              [temp1 addObject:model];
          }
          dataArray = temp;
          commmentArray=temp1;
          [tableview reloadData];
      }
      
  } failure:^(NSError *error) {
      
  }];

}

- (NSString *)becomeTime:(NSString *)time
{
    if (time.length == 0) {
        return @"";
    }
    NSDateFormatter* formatter = [NSDateFormatter new];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *dt = [NSDate dateWithTimeIntervalSince1970:[time integerValue]];
    
    NSString *nowtimeStr = [formatter stringFromDate:dt];
    
    return nowtimeStr;
    
}

//创建底部的评论视图
- (void)makeBottomView
{
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = colorWithRGB(0xF9F9F9);
    [self.view addSubview:bottomView];
    bottomView.sd_layout.leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).bottomSpaceToView(self.view,0).heightIs(50*SCREEN_PRESENT);
    
    UIButton *discussBtn = [UIButton new];
    [bottomView addSubview:discussBtn];
    discussBtn.backgroundColor = colorWithRGB(0xF0F0F0);
    discussBtn.layer.cornerRadius = 4;
    discussBtn.layer.masksToBounds = YES;
    discussBtn.sd_layout.leftSpaceToView(bottomView,10).topSpaceToView(bottomView,10).heightIs(32).rightSpaceToView(bottomView, 10);
    [discussBtn addTarget:self action:@selector(discussBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *penImg = [UIImageView new];
    [discussBtn addSubview:penImg];
    penImg.image = [UIImage imageNamed:@"pen"];
    penImg.sd_layout.leftSpaceToView(discussBtn,11).topSpaceToView(discussBtn,10).widthIs(13).heightIs(15);
    
    UILabel *pinglun = [UILabel new];
    [discussBtn addSubview:pinglun];
    pinglun.text = @"写评论";
    pinglun.font = font(13);
    pinglun.textColor = colorWithRGB(0x999999);
    pinglun.sd_layout.leftSpaceToView(penImg,10).topSpaceToView(discussBtn,10).widthIs(40).heightIs(13);
    
}

//评论按钮的点击
- (void)discussBtnClick
{
    bgView = [UIView new];
    [self.view addSubview:bgView];
    bgView.backgroundColor = BlackColor;
    bgView.alpha = 0.4 ;
    bgView.frame = self.view.frame;
    
    sendView = [UIView new];
    [self.view addSubview:sendView];
    sendView.backgroundColor = colorWithRGB(0xF9F9F9);
    sendView.sd_layout.leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view).heightIs(400*SCREEN_PRESENT);
    
    inputView = [UITextView new];
    inputView.font = font(12);
    inputView.delegate = self;
    inputView.backgroundColor = colorWithRGB(0xFFFFFF);
    [sendView addSubview:inputView];
    inputView.layer.cornerRadius = 3;
    inputView.layer.masksToBounds = YES;
    inputView.sd_layout.leftSpaceToView(sendView,10).topSpaceToView(sendView,10).rightSpaceToView(sendView,10).heightIs(36);
    
    UIButton *fabiao = [UIButton new];
    [sendView addSubview:fabiao];
    fabiao.backgroundColor = colorWithRGB(0xEF898F);
    fabiao.layer.cornerRadius = 4;
    fabiao.layer.masksToBounds = YES;
    fabiao.titleLabel.font = font(14);
    [fabiao addTarget:self action:@selector(fabiaoClick) forControlEvents:UIControlEventTouchUpInside];
    fabiao.sd_layout.rightSpaceToView(sendView,10).topSpaceToView(inputView,10).widthIs(79).heightIs(31);
    [fabiao setTitle:@"发表" forState:UIControlStateNormal];
    [fabiao setTitleColor:WhiteColor forState:UIControlStateNormal];
    
    UIButton *quxiao = [UIButton new];
    [sendView addSubview:quxiao];
    quxiao.backgroundColor = colorWithRGB(0xF0F0F0);
    quxiao.layer.cornerRadius = 4;
    quxiao.layer.masksToBounds = YES;
    quxiao.titleLabel.font = font(14);
    [quxiao addTarget:self action:@selector(quxiaoClick) forControlEvents:UIControlEventTouchUpInside];
    quxiao.sd_layout.rightSpaceToView(fabiao,10).topSpaceToView(inputView,10).widthIs(79).heightIs(31);
    [quxiao setTitle:@"取消" forState:UIControlStateNormal];
    [quxiao setTitleColor:colorWithRGB(0x333333) forState:UIControlStateNormal];
    
    [inputView becomeFirstResponder];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [bgView removeFromSuperview];
    [sendView removeFromSuperview];
    
}
- (void)textViewDidChange:(UITextView *)textView{
    
    //numberlines用来控制输入的行数
    NSInteger numberLines = textView.contentSize.height / textView.font.lineHeight;
    if (numberLines != _rows) {
        
        NSLog(@"text = %@", inputView.text);
        _rows = numberLines;
        
        if  (_rows < 7) {
            
            [self changeFrame:textView.contentSize.height];
            
        }else{
            
            inputView.scrollEnabled = YES;
        }
        
        [textView setContentOffset:CGPointZero animated:YES];
    }
}

//发表评论
- (void)fabiaoClick
{
    [bgView removeFromSuperview];
    [sendView removeFromSuperview];
    
    [DataSourceTool addComment:self.com_id desc:inputView.text ViewController:self success:^(id json) {
       
        if ([json[@"errcode"] integerValue]==0) {
        
            [self loadData];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}
//取消评论
- (void)quxiaoClick
{
    [bgView removeFromSuperview];
    [sendView removeFromSuperview];
}

- (void)changeFrame:(CGFloat)height{
    
    CGRect textViewFrame = inputView.frame;
    textViewFrame.size.height = height;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        inputView.frame = textViewFrame;
    }];
}


@end
