//
//  AddMemberView.m
//  ONLY
//
//  Created by Dylan on 06/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "AddMemberView.h"
#import "ConferenceDetailConfirmOrderCell_2.h"
#import "PeopleItem.h"
@interface AddMemberView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray * choosedArray;

@end

@implementation AddMemberView
@synthesize dataArray = _dataArray;
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}
-(NSMutableArray *)choosedArray{
    if (!_choosedArray) {
        _choosedArray = [NSMutableArray new];
    }
    return _choosedArray;
}
-(void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    for (int i=0; i<dataArray.count; i++) {
        BOOL isSelected = NO;
        [self.choosedArray addObject:@(isSelected)];
    }
}
-(void)awakeFromNib{
    [super awakeFromNib];
    [self.tableView registerNib:[UINib nibWithNibName:@"ConferenceDetailConfirmOrderCell_2" bundle:nil] forCellReuseIdentifier:@"ConferenceDetailConfirmOrderCell_2"];
}


- (void)show{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    self.alpha = 0;
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}
-(void)dismiss{
    __weak typeof(self) weakSelf = self;
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        
        [weakSelf removeFromSuperview];
    }];
}

- (IBAction)btnClicked:(UIButton *)sender {
    if (sender.tag == 1 || sender.tag == 2) {
        [self dismiss];
    }else if (sender.tag == 3){
        [self dismiss];
        if (self.btnAction_block) {
            NSMutableArray * array = [NSMutableArray new];
            for (int i=0; i<self.choosedArray.count; i++) {
                BOOL isSelected = [self.choosedArray[i] boolValue];
                if (isSelected) {
                    [array addObject:self.dataArray[i]];
                }
            }
            self.btnAction_block(array);
        }
    }
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ConferenceDetailConfirmOrderCell_2 * cell = [tableView dequeueReusableCellWithIdentifier:@"ConferenceDetailConfirmOrderCell_2"];
    PeopleItem * item = self.dataArray[indexPath.row];
    cell.nameLabel.text = item.name;
    [cell.operateBtn setTitle:@"＋添加" forState:UIControlStateNormal];
    [cell.operateBtn setTitle:@"－取消" forState:UIControlStateSelected];
    
    [cell.operateBtn jk_setBackgroundColor:colorWithRGB(0xffffff) forState:UIControlStateNormal];
    [cell.operateBtn jk_setBackgroundColor:colorWithRGB(0x0099E3) forState:UIControlStateSelected];
    kWeakSelf(cell);
    kWeakSelf(self);
    cell.btnAction_block = ^(NSInteger index){
        weakcell.operateBtn.selected = !weakcell.operateBtn.selected;
        BOOL isSelected = ![weakself.choosedArray[indexPath.row] boolValue];
        [weakself.choosedArray replaceObjectAtIndex:indexPath.row withObject:@(isSelected)];
    };
    return cell;
}
@end
