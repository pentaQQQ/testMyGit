//
//  ReceiptView.h
//  ONLY
//
//  Created by Dylan on 06/02/2017.
//  Copyright © 2017 cbl－　点硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReceiptView : UIView
@property (weak, nonatomic) IBOutlet UIButton *bgBtn;
@property (weak, nonatomic) IBOutlet UITextView *companyNameTV;
@property (weak, nonatomic) IBOutlet UITextView *identityTV;
@property (weak, nonatomic) IBOutlet UIButton *personalBtn;
@property (weak, nonatomic) IBOutlet UIButton *companyBtn;

@property(nonatomic,copy) void (^btnAction_block)(NSInteger index,NSString * companyName,NSString * identity,NSString * type);
-(void)show;
-(void)dismiss;
/**
 param : receiptType:0表示个人，1表示公司
 */
-(void)setDataWithReceiptType:(NSString *)receiptTpye
                  companyName:(NSString *)companyName
                     identity:(NSString *)identity;
-(void)setBtnAction_block:(void (^)(NSInteger, NSString *,NSString *,NSString *))btnAction_block;

@end
