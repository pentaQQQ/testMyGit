//
//  ConferenceDetailFooterView.m
//  ONLY
//
//  Created by Dylan on 06/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "ConferenceDetailFooterView.h"
#import "ConferenceDetailCell_2.h"
#import "ConferenceDetailCell_3.h"
#import "TeacherItem.h"
@interface ConferenceDetailFooterView()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate>

@property(nonatomic,strong)UIActivityIndicatorView * activityView;

@end

@implementation ConferenceDetailFooterView
@synthesize dataArray = _dataArray;
-(NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    
    self.activityView = [[UIActivityIndicatorView alloc]init];
    self.activityView.center = self.center;
    self.activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self addSubview:self.activityView];

    
    self.webView.scrollView.scrollEnabled = YES;
    self.webView.scalesPageToFit = YES;
    
    self.segment = [[HMSegmentedControl alloc]initWithFrame:CGRectMake(0, 0, screenWidth(), 50)];
    [self.segmentView addSubview:self.segment];
    self.segment.sectionTitles = @[@"课程详情", @"讲师介绍"];
    self.segment.selectedSegmentIndex = 0;
    self.segment.backgroundColor = [UIColor clearColor];
    self.segment.titleTextAttributes = @{NSForegroundColorAttributeName : colorWithRGB(0x333333),NSFontAttributeName:[UIFont systemFontOfSize:16]};
    self.segment.selectedTitleTextAttributes = @{NSForegroundColorAttributeName : colorWithRGB(0x008CCF)};
    self.segment.selectionStyle = HMSegmentedControlSelectionStyleTextWidthStripe;
    self.segment.selectionIndicatorColor = colorWithRGB(0x008CCF);
    self.segment.selectionIndicatorHeight = 1;
    self.segment.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    self.segment.selectionIndicatorBoxOpacity = 1;
    
    __weak typeof(self) weakSelf = self;
    [self.segment setIndexChangeBlock:^(NSInteger index) {
        if (index == 0) {
            weakSelf.webView.hidden = NO;

            [weakSelf.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:weakSelf.item.course_desc]]];
        }else if (index == 1){
            weakSelf.webView.hidden = YES;
            CGSize size = weakSelf.tableView.contentSize;
            weakSelf.frame = CGRectMake(weakSelf.frame.origin.x, weakSelf.frame.origin.y, size.width, size.height +50);
            weakSelf.reload_block(weakSelf);
        }
    }];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.tableView.rowHeight = 92;
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerNib:[UINib nibWithNibName:@"ConferenceDetailCell_3" bundle:nil] forCellReuseIdentifier:@"ConferenceDetailCell_3"];
    
    
}
-(void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    [self.tableView reloadData];
}
-(void)setItem:(ConferenceItem *)item{
    _item = item;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:item.course_desc]]];
}
#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ConferenceDetailCell_3 * cell = [tableView dequeueReusableCellWithIdentifier:@"ConferenceDetailCell_3"];
    TeacherItem * item = self.dataArray[indexPath.row];
    cell.item = item;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TeacherItem * item = self.dataArray[indexPath.row];
    if (self.clicked_block) {
        self.clicked_block(item);
    }
}

//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 2) {
//    }
//}
#pragma mark - UIWebViewDelegate
-(void)webViewDidStartLoad:(UIWebView *)webView{
    NSLog(@"开始加载");
    [self.activityView startAnimating];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityView stopAnimating];
    //获取到webview的高度 document.body.clientHeight document.body.offsetHeight
    CGFloat height = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.scrollHeight"] floatValue];
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, screenWidth(), height+50);
//    [self layoutIfNeeded];
    self.reload_block(self);
    self.segmentView.userInteractionEnabled = YES;
    
    
}

@end
