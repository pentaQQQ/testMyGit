//
//  GVUserDefaults+Information.m
//  OA
//
//  Created by George on 16/10/31.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import "GVUserDefaults+Information.h"

@implementation GVUserDefaults (Information)
@dynamic login;
@dynamic account;
@dynamic password;
@dynamic personal;
@dynamic accessToken;
@dynamic memberId;   //会员ID
@dynamic memberName; //会员姓名
@dynamic mobile;     //手机号
@dynamic email;      //邮箱
@dynamic portrait;   //头像
@dynamic drop_tag;
@dynamic shoppingList_type;
@dynamic department; //部门
@dynamic address;    //居住地址
@dynamic service_count;//服务数量
@dynamic service_price; //服务价格
@dynamic point ;  //金币
@dynamic status ;//判断用户(0外部校长，1内部校长，2市场人员，3 精英校长)
@dynamic vip ;//
@dynamic firstLaunch ;
@dynamic sex;
@dynamic birthday;
@dynamic typeId;
@dynamic memberLogin;
@dynamic Maccount;
@dynamic Mpassword;
@dynamic MmemberId;
@dynamic MmemberName;
@dynamic Mportrait;
@dynamic device_tokens;

-(void)cleanData {
    
    self.login = NO;
    
    self.password = @"";
    
    self.personal = YES;
}

- (void)cleanMemberData
{
    self.memberLogin = NO;
    
    self.Mpassword = @"";
}

- (NSString *)transformKey:(NSString *)key {
    key = [key stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[key substringToIndex:1] uppercaseString]];
    return [NSString stringWithFormat:@"NSUserDefault%@", key];
}

@end
