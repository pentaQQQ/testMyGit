//
//  CompetitionVoteDetailController.m
//  ONLY
//
//  Created by Dylan on 15/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "CompetitionVoteDetailController.h"
#import "CompetitionVoteDetailView.h"
@interface CompetitionVoteDetailController ()
@property (nonatomic, strong) CompetitionVoteDetailView * detailView;
@property (nonatomic, strong) NSString * portraitUrlStr;
@property (nonatomic, strong) NSString * candidateDescription;
@property (nonatomic, strong) NSMutableArray * photoArray;
@property (nonatomic, strong) NSString * videoUrlStr;

@end

@implementation CompetitionVoteDetailController{
    UIView * _bottomBGView;
}
-(NSMutableArray *)photoArray{
    if (!_photoArray) {
        _photoArray = [NSMutableArray new];
    }
    return _photoArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavi];
    [self setupUI];
    [self getData];
}

-(void)setupNavi{
    self.title = @"详情";
    self.view.backgroundColor = AppBackColor;
}

-(void)setupUI{
    [self setupBottomView];
    
    self.detailView = [[[NSBundle mainBundle]loadNibNamed:@"CompetitionVoteDetailView" owner:nil options:nil]firstObject];
    [self.view addSubview:self.detailView];
    
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(0, 0, 63, 0));
    }];
}


-(void)setupBottomView{
    
    _bottomBGView = [[UIView alloc]init];
    _bottomBGView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_bottomBGView];
    [_bottomBGView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(63);
    }];
    
    UIButton * btn = [UIButton new];
    [btn setTitle:@"给TA投票" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.layer.cornerRadius = 4.f;
    [btn setBackgroundColor:colorWithRGB(0x00A9EB)];
    [btn jk_addActionHandler:^(NSInteger tag) {
        
    }];
    
    [_bottomBGView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_bottomBGView).insets(UIEdgeInsetsMake(9, 16, 9, 16));
    }];
}

-(void)getData{
    NSDictionary * param = @{
                             @"member_id": self.item.member_id,
                             @"match_id": self.item.match_id
                             };
    [DataSourceTool competitionCandidateDetailWithParam:param toViewController:self success:^(id json) {
        NSLog(@"%@",json);
        if ([json[@"errcode"]integerValue]==0) {
            NSDictionary * dic = json[@"rsp"];
            self.portraitUrlStr = dic[@"member_portrait"];
            self.candidateDescription = dic[@"brief"];
            self.photoArray = dic[@"picture"];
            self.videoUrlStr = dic[@"video"];
            [self reloadData];
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
    
}


-(void)reloadData{
    self.detailView.nameLabel.text = self.item.name;
    [self.detailView.portraitIV sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",Choose_Base_URL,self.portraitUrlStr]]];
    self.detailView.descriptionLabel.text = self.candidateDescription;
    self.detailView.photoArray = self.photoArray;
    if (self.videoUrlStr.length > 0) {
        self.detailView.videoUrlStr = [NSString stringWithFormat:@"%@%@",Choose_Base_URL,self.videoUrlStr];
    }
    
}

@end



