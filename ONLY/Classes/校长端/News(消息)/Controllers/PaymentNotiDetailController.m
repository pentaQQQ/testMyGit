//
//  PaymentNotiDetailController.m
//  ONLY
//
//  Created by Dylan on 20/03/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import "PaymentNotiDetailController.h"

@interface PaymentNotiDetailController ()
@property (weak, nonatomic) IBOutlet UILabel *priceTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UILabel *paymentWayTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *paymentWayLabel;


@property (weak, nonatomic) IBOutlet UILabel *acountTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *acountLabel;
@property (weak, nonatomic) IBOutlet UILabel *explainTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *explainLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end

@implementation PaymentNotiDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.priceLabel.text = [NSString stringWithFormat:@"¥%@",self.item.price];
    
    self.statusLabel.text = self.item.state;
    self.paymentWayLabel.text = self.item.method;
    self.acountLabel.text = self.item.account;
    self.explainLabel.text = self.item.explain;
    self.timeLabel.text = [self timeWithTimeIntervalString:self.item.add_date];
    
    if ([self.item.difference integerValue]==0) {
        self.paymentWayTitleLabel.text = @"退款方式:";
        self.acountTitleLabel.text = @"退款到:";
        self.explainTitleLabel.text = @"退款说明:";
        self.timeTitleLabel.text = @"退款时间:";
    }else{
        self.paymentWayTitleLabel.text = @"交易方式:";
        self.acountTitleLabel.text = @"交易账号:";
        self.explainTitleLabel.text = @"交易说明:";
        self.timeTitleLabel.text = @"交易时间:";
    }
}

-(void)setItem:(NewsItem *)item{
    _item = item;
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
