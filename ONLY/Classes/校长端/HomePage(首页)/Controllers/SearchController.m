//
//  SearchController.m
//  Choose
//
//  Created by George on 16/11/18.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import "SearchController.h"
#import "CrowdFundController.h"
#import "ServiceController.h"
#import "ConferenceController.h"
#import "IdeaController.h"
@interface SearchController ()<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, TTTagViewDelegate, TTGroupTagViewDelegate,UITextFieldDelegate>
{
    UIViewController *sourceController;
    SearchType type;
    NSInteger myType;
    
    NSArray *fundArray;
    NSArray *goldArray;
    NSArray *courseArray;
    NSArray *service;
    
    NSArray *hisFundArray;
    NSArray *hisGoldArray;
    NSArray *hisCourseArray;
    NSArray *hisService;
    
    NSString *keyword;
}
@property (nonatomic, strong) UIView *navigationBar;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) TPKeyboardAvoidingTableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
/**
 *  存储标签列表cell的高度
 */
@property (strong, nonatomic) NSMutableArray *heightArr;

@end

@implementation SearchController
@synthesize navigationBar;


+(void)presentToSearchControllerWithContext:(UIViewController *)target type:(SearchType)type {
    SearchController *searchVC = [SearchController new];
    searchVC->type = type;
    searchVC->sourceController = target;
    [target.navigationController pushViewController:searchVC animated:YES];
    //[target presentViewController:searchVC animated:NO completion:nil];
}

-(void)pushToDetailController {
    [self dismissViewControllerAnimated:NO completion:nil];
    
    switch (type) {
        case SearchTypeGoods: {
            CrowdFundController *VC = [CrowdFundController new];
            VC.isSearch = YES;
             VC.keyword = keyword;
            [sourceController.navigationController pushViewController:VC animated:YES];
            break;
        }
        case SearchTypeRecruit: {
            
            NSLog(@"服务");
           
            ServiceController *VC = [ServiceController new];

            VC.isSearch = YES;
            VC.keyword = keyword;

            [sourceController.navigationController pushViewController:VC animated:YES];
            break;
        }
        case SearchTypeVideo: {
            NSLog(@"培训");
            ConferenceController *VC = [ConferenceController new];

            VC.isSearch = YES;
            VC.keyword = keyword;

            [sourceController.navigationController pushViewController:VC animated:YES];
            break;
        }
        case SearchTypeIdea: {
            NSLog(@"金点子");
            IdeaController *VC = [IdeaController new];

            VC.isSearch = YES;
            VC.keyword = keyword;

            [sourceController.navigationController pushViewController:VC animated:YES];
            break;
        }
            
        default:
            break;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = WhiteColor;
    self.fd_prefersNavigationBarHidden = YES;
    
    fundArray = [NSArray array];
    goldArray = [NSArray array];
    courseArray = [NSArray array];
    service = [NSArray array];
    
    myType = 0;
    
    hisFundArray = [NSArray array];
    hisGoldArray = [NSArray array];
    hisCourseArray = [NSArray array];
    hisService = [NSArray array];
    



    [self loadData];

    self.dataSource = [NSMutableArray arrayWithArray:@[@{@"历史纪录":hisFundArray}, @{@"热门搜索":fundArray}]];

    self.heightArr = [NSMutableArray array];
    
    [self createNavigationBar];
    [self userSelectedType:type];
    
    self.tableView = ({
        TPKeyboardAvoidingTableView *tableView = [[TPKeyboardAvoidingTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.view);
            make.top.equalTo(self.navigationBar.mas_bottom);
        }];
        [tableView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
            [self.searchTextField resignFirstResponder];
        }];
        
        tableView;
    });
    
     [self loadData];
}

-(void)createNavigationBar {
    navigationBar = [UIView new];
    [self.view addSubview:navigationBar];
    navigationBar.backgroundColor = colorWithRGB(0x00A9EB);
    [navigationBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.mas_equalTo(64);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = colorWithRGB(0xe6e6e6);
    [navigationBar addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(navigationBar);
        make.height.mas_equalTo(0.5);
    }];
    
    /* 取消按钮 */
    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    cancel.titleLabel.font = font(14);
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:WhiteColor forState:UIControlStateNormal];
    [cancel jk_addActionHandler:^(NSInteger tag) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
        
    }];
    [navigationBar addSubview:cancel];
    [cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.equalTo(navigationBar);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    UITextField *textField = [UITextField new];
    self.searchTextField = textField;
    textField.layer.borderColor = colorWithRGB(0xcfcfcf).CGColor;
    textField.layer.borderWidth = 1;
    textField.layer.cornerRadius = 15;
    textField.layer.masksToBounds = YES;
    textField.backgroundColor = [UIColor whiteColor];
    textField.font = font(14);
    [textField becomeFirstResponder];
    textField.returnKeyType = UIReturnKeySearch;
    textField.delegate = self;
    [navigationBar addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.bottom.equalTo(navigationBar.mas_bottom).offset(-7);
        make.right.equalTo(cancel.mas_left);
        make.height.mas_equalTo(30);
    }];

    /* 输入框的左侧按钮 */
    UIView *leftView = [UIView new];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.leftView = leftView;
    leftView.frame = CGRectMake(0, 0, 70, 0);
    [leftView jk_addTapActionWithBlock:^(UIGestureRecognizer *gestureRecoginzer) {
        
        UIImageView *arrow = [leftView viewWithTag:10];
        arrow.image = [UIImage imageNamed:@"search_up_arrow"];
        
        CGRect rect = [leftView convertRect:leftView.frame toView:self.view];
        
        [FTPopOverMenu setTintColor:colorWithRGB(0x0A9EB)];
        [FTPopOverMenu showFromSenderFrame:rect
                                  withMenu:@[ @"产品", @"服务", @"培训",@"金点子"]
                            imageNameArray:@[ @"popmenu_cart", @"popmenu_recruit", @"popmenu_edu"]
                                 doneBlock:^(NSInteger selectedIndex) {
                                     NSLog(@"done block. do something. selectedIndex : %ld", (long)selectedIndex);
                                     
                                     [self userSelectedType:(SearchType)selectedIndex];
                                     
                                     arrow.image = [UIImage imageNamed:@"search_down_arrow"];
                                 }
                              dismissBlock:^{
                                  NSLog(@"user canceled. do nothing.");
                                  arrow.image = [UIImage imageNamed:@"search_down_arrow"];
                              }];
        
    }];
    
    self.typeLabel = ({
        UILabel *typeLabel = [UILabel new];
//      typeLabel.text = @"商品";
        typeLabel.font = font(14);
        typeLabel.textColor = colorWithRGB(0x666666);
        [leftView addSubview:typeLabel];
        [typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(leftView).offset(15);
            make.centerY.equalTo(leftView);
        }];
        
        UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search_down_arrow"]];
        arrow.contentMode = UIViewContentModeScaleAspectFit;
        arrow.tag = 10;
        [leftView addSubview:arrow];
        [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(typeLabel.mas_right).offset(8);
            make.centerY.equalTo(leftView);
        }];
        typeLabel;
    });
}

-(void)userSelectedType:(SearchType)selType {
    type = selType;
    switch (selType) {
        case SearchTypeGoods: {
            self.typeLabel.text = @"产品";
            myType = 0;
            self.searchTextField.placeholder = @"产品";
            [self.dataSource replaceObjectAtIndex:0 withObject:@{@"历史纪录":hisFundArray}];
            [self.dataSource replaceObjectAtIndex:1 withObject:@{@"热门搜索":fundArray}];
            [self.tableView reloadData];
            break;
        }
        case SearchTypeRecruit: {
            self.typeLabel.text = @"服务";
            myType = 1;
            self.searchTextField.placeholder = @"服务";
            [self.dataSource replaceObjectAtIndex:0 withObject:@{@"历史纪录":hisService}];
            [self.dataSource replaceObjectAtIndex:1 withObject:@{@"热门搜索":service}];
            [self.tableView reloadData];
            
            break;
        }
        case SearchTypeVideo: {
            self.typeLabel.text = @"培训";
            myType = 2;
            self.searchTextField.placeholder = @"培训";
            [self.dataSource replaceObjectAtIndex:0 withObject:@{@"历史纪录":hisCourseArray}];
            [self.dataSource replaceObjectAtIndex:1 withObject:@{@"热门搜索":courseArray}];
            [self.tableView reloadData];
            
            break;
        }
            
        case SearchTypeIdea: {
            self.typeLabel.text = @"金点子";
            myType = 3;
            self.searchTextField.placeholder = @"金点子";
            [self.dataSource replaceObjectAtIndex:0 withObject:@{@"历史纪录":hisGoldArray}];
            [self.dataSource replaceObjectAtIndex:1 withObject:@{@"热门搜索":goldArray}];
            [self.tableView reloadData];
            break;
        }
        default:
            break;
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    
    [DataSourceTool historykeyWord:textField.text keyType:myType ViewController:self success:^(id json) {
        
        if ([json[@"errcode"] integerValue]==0) {
            
            //[self loadData];
            keyword = textField.text;
            [self pushToDetailController];
            
        }
        
    } failure:^(NSError *error) {
        
    }];
  
    return [textField resignFirstResponder];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44.0f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.heightArr.count > 0) {
        
        return [self.heightArr[indexPath.section] floatValue];
        
    } else {
        
        return 44.0;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSDictionary *dic = self.dataSource[section];
    NSString *sectionTitle = dic.allKeys.firstObject;
    
    UIView *headerView = [UIView new];
    headerView.backgroundColor = [UIColor whiteColor];
    UILabel *label = [UILabel new];
    label.text = sectionTitle;
    label.textColor = colorWithRGB(0x666666);
    label.font = font(13);
    [headerView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.equalTo(headerView);
    }];
    if ([sectionTitle isEqualToString:@"历史纪录"]) {
        UIButton *delButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [delButton setTitle:@"清除" forState:UIControlStateNormal];
        [delButton setImage:[UIImage imageNamed:@"search_delect"] forState:UIControlStateNormal];
        [delButton jk_setImagePosition:LXMImagePositionLeft spacing:5];
        [delButton setTitleColor:colorWithRGB(0xef898f) forState:UIControlStateNormal];
        delButton.tag = 2;
        delButton.titleLabel.font = font(14);
        [delButton jk_addActionHandler:^(NSInteger tag) {
            [self.dataSource removeObjectAtIndex:0];
            [self.heightArr removeObjectAtIndex:0];
            
            //删除第一个分区
            [self.tableView beginUpdates];
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView endUpdates];
        }];
        [headerView addSubview:delButton];
        [delButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(headerView.mas_right).offset(-10);
            make.centerY.equalTo(headerView);
        }];
    }
    else {
        
        [[headerView viewWithTag:2] removeFromSuperview];
    }
    
    return headerView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.contentView addSubview:[self addHistoryViewTagsWithCGRect:CGRectMake(0, 0, kScreenWidth, 44) andIndex:indexPath]];
    
    return cell;
}

#pragma mark - 添加标签列表视图
- (TTGroupTagView *)addHistoryViewTagsWithCGRect:(CGRect)rect andIndex:(NSIndexPath *)indexPath{

    TTGroupTagView *tagView = [[TTGroupTagView alloc] initWithFrame:rect];
    tagView.tag = indexPath.section + 1000;
    tagView.translatesAutoresizingMaskIntoConstraints = YES;
    tagView.delegate = self;
    tagView.changeHeight = 0;
    tagView.backgroundColor = [UIColor clearColor];
    if (indexPath.section==1) {
        tagView.borderColor = colorWithRGB(0xE4F3FA);
        tagView.bgColor = colorWithRGB(0x009DE5);
    }
    

    NSDictionary *dic = self.dataSource[indexPath.section];
    NSArray *tagsArr = dic.allValues.firstObject;
    if (tagsArr.count > 0) {
        
        [tagView addTags:tagsArr];
    }
    //这里存储tagView的最大高度, 是为了设置cell的行高
    NSString *tagsHeight = [NSString stringWithFormat:@"%f", tagView.changeHeight];
    if (self.heightArr.count > indexPath.section) {
        [self.heightArr replaceObjectAtIndex:indexPath.section withObject:tagsHeight];
    } else {
        [self.heightArr addObject:tagsHeight];
    }
    return tagView;
    
}

- (void)buttonClick:(NSString *)string and:(BOOL)isDelete {
    NSLog(@"选中的标签是:%@", string);
    keyword = string;
    NSLog(@"isDelete : %d", isDelete);
    [self pushToDetailController];
}

- (void)loadData
{
  [DataSourceTool recommend:myType ViewController:self success:^(id json) {
      
      if ([json[@"errcode"] integerValue]== 0 ) {
        
          fundArray = json[@"list"][0];
          goldArray = json[@"list"][3];
          courseArray = json[@"list"][2];
          service = json[@"list"][1];
          
          hisFundArray= json[@"history"][0];
          hisGoldArray= json[@"history"][3];
          hisCourseArray= json[@"history"][2];
          hisService = json[@"history"][1];
          self.dataSource = [NSMutableArray arrayWithArray:@[@{@"历史纪录":hisFundArray}, @{@"热门搜索":fundArray}]];
          
          [self.tableView reloadData];
        
      }
      
  } failure:^(NSError *error) {
      
  }];
    
}
@end
