//
//  AppDelegate.m
//  ONLY
//
//  Created by 上海点硕 on 2016/12/17.
//  Copyright © 2016年 cbl－　点硕. All rights reserved.
//

#import "AppDelegate.h"
#import "BaseTabBarController.h"
#import "BasePlusButton.h"
#import "MemberBaseTabBarController.h"
#import "GuideViewController.h"
#import "LoginViewController.h"
#import "UMessage.h"
#import "MemberLoginController.h"
#import "WXApi.h"
#import "AlipaySDK.h"

#define WXAppId @"wxd6acda7466887cb2"
@interface AppDelegate ()<UNUserNotificationCenterDelegate,WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [WXApi registerApp:WXAppId];
    [BasePlusButton registerPlusButton];
    
    BaseTabBarController *mainTab = [[BaseTabBarController alloc] init];
    if (USERINFO.personal == NO){//////////////
        //第一次启动
        if (USERINFO.firstLaunch==NO) {
            GuideViewController *GuideVc = [[GuideViewController alloc] initWithMainController:mainTab.tabBarController loginController:[LoginViewController new]];
            self.window.rootViewController = GuideVc;
            USERINFO.firstLaunch = YES;
        }
        //非第一次启动
        else{
            if (USERINFO.login==NO) {
                
                self.window.rootViewController = [LoginViewController new];
                
            }
            else
            {
                BaseTabBarController *mainTab = [[BaseTabBarController alloc] init];
                self.window.rootViewController = mainTab.tabBarController;
            }
        }
        
    }//////////////////
    else
    {
        if (USERINFO.memberLogin==NO) {
            
            self.window.rootViewController = [MemberLoginController new];
            
        }
        else
        {
            //市场人员
            MemberBaseTabBarController *member = [[MemberBaseTabBarController alloc] init];
            self.window.rootViewController = member;
        }
        
    }
    
    [self push:launchOptions];
    return YES;

}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url{
     return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            NSLog(@"result = %@",resultDic);
            if ([resultDic[@"resultStatus"]integerValue]==9000){
                NSLog(@"result = %@",resultDic);
                [SVProgressHUD showSuccessWithStatus:@"支付成功"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AlipaySuccess" object:nil];
            }
        }];
        return YES;
    }else if ([[url absoluteString] rangeOfString:@"wxd6acda7466887cb2://pay"].location == 0)
    {
      return [WXApi handleOpenURL:url delegate:self];
    }
    
    else{
      
        return NO;
    }
    
}

// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    //如果极简开发包不可用，会跳转支付宝钱包进行支付，需要将支付宝钱包的支付结果回传给开发包
    if ([url.host isEqualToString:@"safepay"]) {
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            //【由于在跳转支付宝客户端支付的过程中，商户app在后台很可能被系统kill了，所以pay接口的callback就会失效，请商户对standbyCallback返回的回调结果进行处理,就是在这个方法里面处理跟callback一样的逻辑】
            NSLog(@"result = %@",resultDic);
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                if ([resultDic[@"resultStatus"]integerValue]==9000){
                    NSLog(@"result = %@",resultDic);
                    [SVProgressHUD showSuccessWithStatus:@"支付成功"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"AlipaySuccess" object:nil];
                }
            }];
        }];
        return YES;
    }
    else if ([[url absoluteString] rangeOfString:@"wxd6acda7466887cb2://pay"].location == 0){
        
        return [WXApi handleOpenURL:url delegate:self];
        
    }else{
      
        return NO;
    }

}

-(void)onResp:(BaseResp*)resp
{
    if ([resp isKindOfClass:[PayResp class]])
    {
        PayResp*response=(PayResp*)resp;
        switch(response.errCode)
        {
            case WXSuccess:
            {
                //服务器端查询支付通知或查询API返回的结果再提示成功
                NSLog(@"支付成功");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"WXPaySuccess" object:nil];
            }
                break;
            case WXErrCodeCommon:
            {
                //签名错误、未注册APPID、项目设置APPID不正确、注册的APPID与设置的不匹配、其他异常等
                NSLog(@"支付失败");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"1111" object:nil];
            }
                break;
            case WXErrCodeUserCancel:
            {
                //用户点击取消并返回
                NSLog(@"取消支付");
                [[NSNotificationCenter defaultCenter] postNotificationName:@"2222" object:nil];
            }
                break;
            case WXErrCodeSentFail:
            {
                //发送失败
                [[NSNotificationCenter defaultCenter] postNotificationName:@"3333" object:nil];
                NSLog(@"发送失败");
            }
                break;
            case WXErrCodeUnsupport:
            {
                //微信不支持
                [[NSNotificationCenter defaultCenter] postNotificationName:@"4444" object:nil];
                NSLog(@"微信不支持");
            }
                break;
            case WXErrCodeAuthDeny:
            {
                //授权失败
                [[NSNotificationCenter defaultCenter] postNotificationName:@"5555" object:nil];
                NSLog(@"授权失败");
            }
                break;
            default:
                break;
        }
    }
}


- (void)applicationWillResignActive:(UIApplication *)application {
 
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
 
  
    
}


- (void)applicationWillTerminate:(UIApplication *)application {
   
}

- (void)push :(NSDictionary *)launchOptions
{
    //初始化方法,也可以使用(void)startWithAppkey:(NSString *)appKey launchOptions:(NSDictionary * )launchOptions httpsenable:(BOOL)value;这个方法，方便设置https请求。
    [UMessage startWithAppkey:@"58df44a5b27b0a0385001044" launchOptions:launchOptions];
    //注册通知，如果要使用category的自定义策略，可以参考demo中的代码。
    [UMessage registerForRemoteNotifications];
    
    //iOS10必须加下面这段代码。
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate=self;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
            //这里可以添加一些自己的逻辑
        } else {
            //点击不允许
            //这里可以添加一些自己的逻辑
        }
    }];
    //打开日志，方便调试
    [UMessage setLogEnabled:YES];
 
}


//iOS10以下使用这个方法接收通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    [UMessage didReceiveRemoteNotification:userInfo];
     [UMessage setAutoAlert:YES];
        //self.userInfo = userInfo;
        //定制自定的的弹出框
    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
    {
//        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"消息通知"
//                                                         message:userInfo[@"aps"][@"alert"]
//                                                        delegate:self
//                                               cancelButtonTitle:@"确定"
//                                               otherButtonTitles:nil];
//        [alert show];
    }
}

//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭U-Push自带的弹出框
        [UMessage setAutoAlert:NO];
        //必须加这句代码
        [UMessage didReceiveRemoteNotification:userInfo];
        
    }else{
        //应用处于前台时的本地推送接受
    }
    //当应用处于前台时提示设置，需要哪个可以设置哪一个
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionAlert);
}

-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(nonnull NSData *)deviceToken {
    
    NSString *token = [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<" withString:@""] stringByReplacingOccurrencesOfString:@">" withString:@""] stringByReplacingOccurrencesOfString:@" " withString:@""];
    USERINFO.device_tokens = token;
    NSLog(@"\n\ndeviceToken:%@", token);
}
@end
