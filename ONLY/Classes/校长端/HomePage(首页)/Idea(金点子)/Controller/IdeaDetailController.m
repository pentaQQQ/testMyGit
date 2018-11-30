//
//  IdeaDetailController.m
//  ONLY
//
//  Created by Dylan on 13/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "IdeaDetailController.h"

#import "IdeaDetailCell_1.h"
#import "IdeaDetailCell_2.h"
#import "IdeaDetailCell_3.h"
#import "IdeaDetailHeadView.h"
#import "IdeaDetailBottomView.h"
#import "UUIInputView.h"

#import "IdeaReplyItem.h"

#import "UIViewController+HUD.h"
@interface IdeaDetailController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)NSMutableArray * replyArray;
@property (nonatomic,strong)IdeaDetailBottomView * bottomView;
@end

@implementation IdeaDetailController
-(NSMutableArray *)replyArray{
    if (!_replyArray) {
        _replyArray = [NSMutableArray new];
    }
    return _replyArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
    [self setupUI];
    [self getData];
}

-(void)setupNavi{
    self.title = @"详情";
}
-(void)setupUI{
    [self setupBottomView];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 100;
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 63, 0));
    }];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"IdeaDetailCell_1" bundle:nil] forCellReuseIdentifier:@"IdeaDetailCell_1"];
    [self.tableView registerNib:[UINib nibWithNibName:@"IdeaDetailCell_2" bundle:nil] forCellReuseIdentifier:@"IdeaDetailCell_2"];
    [self.tableView registerNib:[UINib nibWithNibName:@"IdeaDetailCell_3" bundle:nil] forCellReuseIdentifier:@"IdeaDetailCell_3"];
    [self.tableView registerNib:[UINib nibWithNibName:@"IdeaDetailHeadView" bundle:nil] forHeaderFooterViewReuseIdentifier:@"IdeaDetailHeadView"];
    
}

-(void)setupBottomView{
    self.bottomView = [[[NSBundle mainBundle]loadNibNamed:@"IdeaDetailBottomView" owner:nil options:nil]lastObject];
    self.bottomView.item = self.item;
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(63);
    }];
    
    kWeakSelf(self);
    [self.bottomView setBtnAction_block:^(NSInteger index) {
        if (index == 1) {//评论
            UUIInputView *inputView = [UUIInputView new];
            inputView.title = @"评论";
            inputView.Ename = @"";
            [inputView inputDidFinished:^(NSString *inputStr) {
                [weakself commentWitnContent:inputStr];
                
            }];
            
            [inputView show];

        }else if (index == 2){//收藏
            [weakself collection];
        }else if (index == 3){//点赞
            [weakself great];
        }
    }];
    
}

-(void)getData{
    kWeakSelf(self);
    NSDictionary * param = @{
                             @"apply_id": self.item.apply_id,
                             @"member_id": USERINFO.memberId
                             };
    [DataSourceTool ideaDetailWithParam:param toViewController:weakself success:^(id json) {
        NSLog(@"%@",json);
//        [json[@"rsp"] createPropertyCode];
        
        if ([json[@"errcode"]integerValue]==0) {
            [weakself.item setValuesForKeysWithDictionary:json[@"rsp"]];
            [weakself.replyArray removeAllObjects];
            for (NSDictionary * dic in json[@"reply"]) {
                IdeaReplyItem * item = [IdeaReplyItem new];
                [item setValuesForKeysWithDictionary:dic];
                [weakself.replyArray addObject:item];
            }
            [weakself.tableView reloadData];
            weakself.bottomView.item = weakself.item;
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma  mark - UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.replyArray.count>0) {
        return 2;
    }else{
        return 1;
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 2;
    }else{
        return self.replyArray.count;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 56;
    }
    return 0.01;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        IdeaDetailHeadView * view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"IdeaDetailHeadView"];
        view.item = self.item;
        return view;
    }
    return nil;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            IdeaDetailCell_1 * cell = [tableView dequeueReusableCellWithIdentifier:@"IdeaDetailCell_1"];
            cell.item = self.item;
            return cell;
        }else{
            IdeaDetailCell_2 * cell = [tableView dequeueReusableCellWithIdentifier:@"IdeaDetailCell_2"];
            cell.item = self.item;
            return cell;
        }
    }else{
        IdeaDetailCell_3 * cell = [tableView dequeueReusableCellWithIdentifier:@"IdeaDetailCell_3"];
        IdeaReplyItem * item = self.replyArray[indexPath.row];
        cell.item = item;
        return cell;
    }
}

#pragma mark - 网络请求

-(void)commentWitnContent:(NSString*)content{
    [DataSourceTool addDiscussTypeId:@"" comment_content:content comment_type:@"3" comment_img:@[] comment_star:@"" comment_id:self.item.apply_id ViewController:self success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"errcode"]integerValue]==0) {
            [self getData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}

-(void)collection{
    NSDictionary * param = @{
                             @"member_id": USERINFO.memberId,
                             @"collect_id": self.item.apply_id
                             };
    [DataSourceTool ideaCollectWithParam:param toViewController:self success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"errcode"]integerValue]==0) {
          
        }

    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}

-(void)great{
    NSDictionary * param = @{
                             @"member_id": USERINFO.memberId,
                             @"good_id": self.item.apply_id
                             };
    [DataSourceTool ideaThumbWithParam:param toViewController:self success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"errcode"]integerValue]==0) {
  
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}

@end
