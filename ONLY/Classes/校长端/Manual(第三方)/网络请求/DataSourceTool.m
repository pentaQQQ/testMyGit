//
//  DataSourceTool.m
//  OA
//
//  Created by George on 16/10/31.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import "DataSourceTool.h"
#import "HttpTool.h"
@implementation DataSourceTool


/* 保存登录和注册时返回的个人信息 */
+(void)saveUserInfo:(NSDictionary *)response {
    USERINFO.memberId = response[@"member_id"];
    USERINFO.memberName = response[@"member_name"];
    USERINFO.mobile = response[@"mobile"];
    USERINFO.email = response[@"email"];
    USERINFO.portrait = response[@"portrait"];
    USERINFO.department = response[@"department"];
    USERINFO.status = response[@"status"];
    USERINFO.vip = response[@"vip"];
    USERINFO.address = response[@"address"];
    USERINFO.point = response[@"point"];
    USERINFO.sex = response[@"sex"];
    USERINFO.birthday = response[@"birthday"];
    USERINFO.service_count = response[@"service_count"];
    USERINFO.service_price = response[@"service_price"];
    USERINFO.typeId =  response[@"type"];
    USERINFO.login = YES;
}

+(void)saveMemberUserInfo:(NSDictionary *)response
{
    USERINFO.MmemberId = response[@"member_id"];
    USERINFO.MmemberName = response[@"member_name"];
    USERINFO.Mportrait = response[@"portrait"];
    USERINFO.memberLogin = YES;

}

//登录
+(NSURLSessionDataTask *)requestLogin:(NSString *)mobile
                             password:(NSString *)pwd
                                type :(NSString *)type
                     toViewController:(UIViewController *) target
                              success:(void(^)(id json)) success
                              failure:(void(^)(NSError* error))failure {
    
    NSDictionary *params = @{@"mobile":mobile,
                             @"password":pwd,
                             @"type"   :type,
                             @"is_system":@"1",
                             @"device_tokens" :USERINFO.device_tokens?USERINFO.device_tokens:@""
                             };
    
    return [HttpTool PostWithLoading:@"/api/v1/user/mobileLogin" params:params toViewController:target loadString:nil success:success failure:failure];
}

/**
 *  注册
 */
+(NSURLSessionDataTask *) requestRegister:(NSString *)mobile
                                    password:(NSString *)pwd
                                    code:(NSString *)code
                                                   toViewController:(UIViewController *) target
                                                            success:(void(^)(id json)) success
                                                            failure:(void(^)(NSError* error))failure
{
    
    NSDictionary *params = @{
                             @"mobile" :mobile,
                             @"password" :pwd,
                             @"sendCode" :code,
                             @"is_system":@"1",
                             @"device_tokens" :USERINFO.device_tokens
                             };
    return [HttpTool PostWithLoading:@"/api/v1/user/register" params:params toViewController:target loadString:nil success:success failure:failure];
}

/**
 *  获取验证码
 */
+(NSURLSessionDataTask *) requestMobileCode:(NSString *)mobile typePhone:(NSString *)typePhone
                                                   toViewController:(UIViewController *) target
                                                            success:(void(^)(id json)) success
                                                            failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"mobile" :mobile,
                             @"typePhone" :typePhone
                             };
    return [HttpTool PostWithLoading:@"/api/v1/user/sendCode" params:params toViewController:target loadString:nil success:success failure:failure];
}

/**
 *  忘记密码
 */
+(NSURLSessionDataTask *)forGotPassword:(NSString *)mobile
                           toViewController:(UIViewController *) target
                                    success:(void(^)(id json)) success
                                    failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"mobile" :mobile
                             
                             };
    return [HttpTool PostWithLoading:@"/api/v1/user/findPhone" params:params toViewController:target loadString:nil success:success failure:failure];
}


/**
 *  找回密码
 */
+(NSURLSessionDataTask *) findPassword:(NSString *)mobile
                                 password:(NSString *)pwd
                                     code:(NSString *)code
                         toViewController:(UIViewController *) target
                                  success:(void(^)(id json)) success
                                  failure:(void(^)(NSError* error))failure
{
    
    NSDictionary *params = @{
                             @"mobile" :mobile,
                             @"password" :pwd,
                             @"sendCode" :code
                             
                             };
    return [HttpTool PostWithLoading:@"/api/v1/user/findPassword" params:params toViewController:target loadString:nil success:success failure:failure];
}

/**
 *  兴趣设置
 */
+(NSURLSessionDataTask *) findTypetoViewController:(UIViewController *) target
                               success:(void(^)(id json)) success
                               failure:(void(^)(NSError* error))failure
{
    
   
    return [HttpTool PostWithLoading:@"/api/v1/user/findType" params:nil toViewController:target loadString:nil success:success failure:failure];
}



/**
 *  修改头像
 */
+(NSURLSessionDataTask *)uploadImg:(NSData *)imageData
                      toViewController:(UIViewController *) target
                               success:(void(^)(id json)) success
                               failure:(void(^)(NSError* error))failure
{

    NSDictionary *params = @{
                             @"mobile" :USERINFO.mobile,
                             @"id" :USERINFO.memberId
                             };
    return  [HttpTool Upload:@"/api/v1/user/uploadImg" params:params file:imageData toViewController:target loadString:@"上传" success:success failure:failure];
}

/**
 *  完善个人信息
 */

+(NSURLSessionDataTask *) updateMineInformation:(NSString *)mykey
                              myValue:(NSString *)myValue
                      toViewController:(UIViewController *) target
                               success:(void(^)(id json)) success
                               failure:(void(^)(NSError* error))failure
{
    
    NSDictionary *params = @{
                             mykey  :myValue,
                             @"id"  :USERINFO.memberId
                             };
    return [HttpTool PostWithLoading:@"/api/v1/user/update" params:params toViewController:target loadString:nil success:success failure:failure];
}

/**
 *   我的设置里面的修改手机号
 */
+(NSURLSessionDataTask *) changePhoneNum:(NSString *)mobile
                              memberId:(NSString *)memberId
                                  code:(NSString *)code
                      toViewController:(UIViewController *) target
                               success:(void(^)(id json)) success
                               failure:(void(^)(NSError* error))failure
{
    
    NSDictionary *params = @{
                             @"mobile" :mobile,
                             @"id" :memberId,
                             @"sendCode" :code
                             };
    return [HttpTool PostWithLoading:@"/api/v1/user/phone" params:params toViewController:target loadString:nil success:success failure:failure];
}

/**
 *   我的设置里面修改密码接口
 */
+(NSURLSessionDataTask *) modifyPasswd:(NSString *)mobile
                                oldpwd:(NSString *)oldpwd
                                    pwd:(NSString *)pwd
                                    repwd:(NSString *)repwd
                        toViewController:(UIViewController *) target
                                 success:(void(^)(id json)) success
                                 failure:(void(^)(NSError* error))failure
{
    
    NSDictionary *params = @{
                             @"mobile" :mobile,
                             @"oldpwd" :oldpwd,
                             @"pwd"    :pwd,
                             @"repwd"  :repwd
                             };
    return [HttpTool PostWithLoading:@"/api/v1/user/modifyPasswd" params:params toViewController:target loadString:nil success:success failure:failure];
}

/**
 *   地址管理
 */
+(NSURLSessionDataTask *) findAddressStaus:(NSString *)status ViewController:(UIViewController *) target
                                 success:(void(^)(id json)) success
                                 failure:(void(^)(NSError* error))failure
{
    
    NSDictionary *params = @{
                             @"id" :USERINFO.memberId,
                             @"status" :status
                             };
    return [HttpTool PostWithLoading:@"/api/v1/user/findAddress" params:params toViewController:target loadString:nil success:success failure:failure];
    
}

/**
 *  添加收货地址接口address
 */

+(NSURLSessionDataTask *) saveAddress:(NSString *)mobile
                                consignee:(NSString *)consignee
                                contact_phone:(NSString *)contact_phone
                                is_status:(NSString *)is_status
                                province_name:(NSString *)province_name
                                city_name:(NSString *)city_name
                                address:(NSString *)address
                                area_name:(NSString *)area_name
                      toViewController:(UIViewController *) target
                               success:(void(^)(id json)) success
                               failure:(void(^)(NSError* error))failure
{
    
    NSDictionary *params = @{
                             @"member_id"     :USERINFO.memberId,
                             @"contact_phone" :contact_phone,
                             @"is_status"     :is_status,
                             @"province_name" :province_name,
                             @"city_name"     :city_name,
                             @"address"       :address,
                             @"area_name"     :area_name,
                             @"consignee"     :consignee
                             };
    return [HttpTool PostWithLoading:@"/api/v1/user/saveAddress" params:params toViewController:target loadString:nil success:success failure:failure];
}

/**
 *  删除收获地址
 */
+(NSURLSessionDataTask *) deleteAddress:(NSString *)member_address_id
                      toViewController:(UIViewController *) target
                               success:(void(^)(id json)) success
                               failure:(void(^)(NSError* error))failure
{
    
    NSDictionary *params = @{
                             @"member_address_id" :member_address_id,
                             };
    return [HttpTool PostWithLoading:@"/api/v1/user/deleteAddress" params:params toViewController:target loadString:nil success:success failure:failure];
}


/**
 *  修改收货地址
 */

+(NSURLSessionDataTask *) updateAddress:(NSString *)member_address_id
                            consignee:(NSString *)consignee
                        contact_phone:(NSString *)contact_phone
                            is_status:(NSString *)is_status
                        province_name:(NSString *)province_name
                            city_name:(NSString *)city_name
                              address:(NSString *)address
                            area_name:(NSString *)area_name
                     toViewController:(UIViewController *) target
                              success:(void(^)(id json)) success
                              failure:(void(^)(NSError* error))failure
{
    
    NSDictionary *params = @{
                             @"member_address_id" :member_address_id,
                             @"contact_phone" :contact_phone,
                             @"is_status"     :is_status,
                             @"province_name" :province_name,
                             @"city_name"     :city_name,
                             @"address"       :address,
                             @"area_name"     :area_name,
                             @"consignee"     :consignee
                             };
    return [HttpTool PostWithLoading:@"/api/v1/user/updateAddress" params:params toViewController:target loadString:nil success:success failure:failure];
}

/**
 *  设置为默认
 */

+(NSURLSessionDataTask *) defaultAddress:(NSString *)member_address_id
                       toViewController:(UIViewController *) target
                                success:(void(^)(id json)) success
                                failure:(void(^)(NSError* error))failure
{
    
    NSDictionary *params = @{
                             @"member_address_id" :member_address_id,
                             @"member_id"  :USERINFO.memberId
                             };
    return [HttpTool PostWithLoading:@"/api/v1/user/updateStatus" params:params toViewController:target loadString:nil success:success failure:failure];
}

/**
 *   读取金币列表
 */
+(NSURLSessionDataTask *) coinListtoViewController:(UIViewController *) target
                                 success:(void(^)(id json)) success
                                 failure:(void(^)(NSError* error))failure
{
    
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.memberId
                             };
    return [HttpTool PostWithLoading:@"/api/v1/point/find" params:params toViewController:target loadString:nil success:success failure:failure];
}


//*************************购物车模块*****************************//
/**
 *  购车列表
 */

+(NSURLSessionDataTask *) cartListtoViewController:(UIViewController *) target
                                 success:(void(^)(id json)) success
                                 failure:(void(^)(NSError* error))failure
{
    
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.memberId
                             };
    
    return [HttpTool PostWithLoading:@"/api/v1/cart/findAll" params:params toViewController:target loadString:nil success:success failure:failure];
}



/**
 *  删除订单
 */
+(NSURLSessionDataTask *) deleteOrderID:(NSString *)car_ids
                                       ViewController:(UIViewController *) target
                                       success:(void(^)(id json)) success
                                       failure:(void(^)(NSError* error))failure
{
    
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.memberId,
                             @"cart_ids"    :car_ids
                             };
    
    return [HttpTool PostWithLoading:@"/api/v1/cart/delete" params:params toViewController:target loadString:nil success:success failure:failure];
}

/**
 *  去结算
 */

+(NSURLSessionDataTask *) settleOrderID:(NSString *)car_ids
                         ViewController:(UIViewController *) target
                                success:(void(^)(id json)) success
                                failure:(void(^)(NSError* error))failure
{
    
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.memberId,
                             @"cart_ids"    :car_ids
                             };
    
    return [HttpTool PostWithLoading:@"/api/v1/cart/settlement" params:params toViewController:target loadString:nil success:success failure:failure];
}


/**
 *  确认订单
 */
+(NSURLSessionDataTask *) sureOrderID:(NSString *)car_ids
                           address_id:(NSString *)address_id
                         has_invoice :(NSString *)has_invoice
                        invoice_type :(NSString *)invoice_type
                        invoice_title:(NSString *)invoice_title
                        invoice_taxes:(NSString *)invoice_taxes
                         ViewController:(UIViewController *) target
                                success:(void(^)(id json)) success
                                failure:(void(^)(NSError* error))failure
{
    
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.memberId,
                             @"cart_ids"    :car_ids,
                             @"has_invoice" :has_invoice,
                             @"invoice_type" :invoice_type,
                             @"invoice_title" :invoice_title,
                             @"invoice_taxes" :invoice_taxes,
                             @"address_id"  :address_id
                             };
    
    return [HttpTool PostWithLoading:@"/api/v1/cart/changeToOrder" params:params toViewController:target loadString:nil success:success failure:failure];
}

//首页的确认订单
+(NSURLSessionDataTask *) firstPagesureOrderID:(NSString *)car_ids
                           address_id:(NSString *)address_id
                         has_invoice :(NSString *)has_invoice
                        invoice_type :(NSString *)invoice_type
                        invoice_title:(NSString *)invoice_title
                        invoice_taxes:(NSString *)invoice_taxes
                        number:(NSInteger)num
                       ViewController:(UIViewController *) target
                              success:(void(^)(id json)) success
                              failure:(void(^)(NSError* error))failure
{
    
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.memberId,
                             @"good_id"    :car_ids,
                             @"has_invoice" :has_invoice,
                             @"invoice_type" :invoice_type,
                             @"invoice_title" :invoice_title,
                             @"address_id"  :address_id,
                             @"invoice_taxes" :invoice_taxes,
                             @"number"    :@(num)
                             };
    
    return [HttpTool PostWithLoading:@"/api/v1/cart/buyNowToOrder" params:params toViewController:target loadString:nil success:success failure:failure];
}

//修改购物车中商品数量
+(NSURLSessionDataTask *) editNumgoods_id:(NSString *)goods_id
                          cart_id:(NSString *)cart_id
                              num:(NSString *)num
                       ViewController:(UIViewController *) target
                              success:(void(^)(id json)) success
                              failure:(void(^)(NSError* error))failure
{
    
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.memberId,
                             @"cart_id"    :cart_id,
                             @"goods_id"  :goods_id,
                             @"num"  :num
                             };
    
    return [HttpTool PostWithLoading:@"/api/v1/cart/editNum" params:params toViewController:target loadString:nil success:success failure:failure];
}







//*************************购物车里面的按钮各种状态的点击事件*****************************//

//删除订单
+(NSURLSessionDataTask *) deleteOrder:(NSInteger)type
                                     order_sn:(NSString *)order_sn
                                      order_type:(NSString *)order_type
                           ViewController:(UIViewController *) target
                                  success:(void(^)(id json)) success
                                  failure:(void(^)(NSError* error))failure
{
    
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.memberId,
                             @"order_sn"    :order_sn,
                             @"order_type"  :order_type
                             };
    //删除订单
    if (type==0) {
         return [HttpTool PostWithLoading:@"/api/v1/order/deleteOrder" params:params toViewController:target loadString:nil success:success failure:failure];
    }
    //取消订单
    else if (type==1)
    {
         return [HttpTool PostWithLoading:@"/api/v1/order/cancelOrder" params:params toViewController:target loadString:nil success:success failure:failure];
    }
    //众筹订单确认收货
    else if (type==2)
    {
        return [HttpTool PostWithLoading:@"/api/v1/order/confirmOrder" params:params toViewController:target loadString:nil success:success failure:failure];
    }
    //市场人员结束服务
    else if (type==3)
    {
        return [HttpTool PostWithLoading:@"/api/v1/order/endSupportOrder" params:params toViewController:target loadString:nil success:success failure:failure];
    }
    //校长支持服务确认结束
    else if (type==4)
    {
        return [HttpTool PostWithLoading:@"/api/v1/order/confirmSupportOrder" params:params toViewController:target loadString:nil success:success failure:failure];
    }
    //市场人员开始服务
    else
    {
        return [HttpTool PostWithLoading:@"/api/v1/order/beginSupportOrder" params:params toViewController:target loadString:nil success:success failure:failure];
    }
 
}

//order_type  Int	删除的订单类型
//0：众筹订单
//1：培训订单
//2：支持服务订单

//********************************END**********************************************//












//////////////////////我的界面的产品众筹//////////////////////////

//已购买
+(NSURLSessionDataTask *) purchaseListPage:(NSString *)page
                                  pageSize:(NSString *)pageSize
                                       Url:(NSString *)url
                   ViewController:(UIViewController *) target
                          success:(void(^)(id json)) success
                          failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.memberId,
                             @"page"    :page,
                             @"pageSize" :pageSize
                             };
    
    if ([url isEqualToString:@"0"]) {
        
        return [HttpTool PostWithLoading:@"/api/v1/fund/purchaseList" params:params toViewController:target loadString:nil success:success failure:failure];
    }
    else if ([url isEqualToString:@"1"])
    {
        return [HttpTool PostWithLoading:@"/api/v1/fund/thumbList" params:params toViewController:target loadString:nil success:success failure:failure];
    }
    else
    {
        return [HttpTool PostWithLoading:@"/api/v1/fund/applyList" params:params toViewController:target loadString:nil success:success failure:failure];
    }
    
}

//*******************************我的界面的回忆培训*******************//
+(NSURLSessionDataTask *) buyListPage:(NSString *)page
                                  pageSize:(NSString *)pageSize
                                       Url:(NSString *)url
                            ViewController:(UIViewController *) target
                                   success:(void(^)(id json)) success
                                   failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.memberId,
                             @"page"    :page,
                             @"pageSize" :pageSize
                             };
    
    if ([url isEqualToString:@"0"]) {
        
        return [HttpTool PostWithLoading:@"/api/v1/course/buyList" params:params toViewController:target loadString:nil success:success failure:failure];
    }
    else if ([url isEqualToString:@"1"])
    {
        return [HttpTool PostWithLoading:@"/api/v1/course/focusList" params:params toViewController:target loadString:nil success:success failure:failure];
    }
    else
    {
        return [HttpTool PostWithLoading:@"/api/v1/course/addList" params:params toViewController:target loadString:nil success:success failure:failure];
    }
    
}



//众筹详情
+(NSURLSessionDataTask *) getOfferDetailID:(NSString *)apply_id
                         ViewController:(UIViewController *) target
                                success:(void(^)(id json)) success
                                failure:(void(^)(NSError* error))failure
{
    
    NSDictionary *params = @{
                             @"apply_id"  :apply_id
                             };
    
    return [HttpTool PostWithLoading:@"/api/v1/fund/getOfferDetail" params:params toViewController:target loadString:nil success:success failure:failure];
}

////////*********************产品众筹订单*****************//

+(NSURLSessionDataTask *) crowOrderInfoPage:(NSString *)page
                                  order_status:(NSString *)order_status
                            ViewController:(UIViewController *) target
                                   success:(void(^)(id json)) success
                                   failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.memberId,
                             @"page"    :page,
                             @"limit" :@"10",
                             @"order_status" :order_status
                             };
    
  
    return [HttpTool PostWithLoading:@"/api/v1/order/crowOrderInfo" params:params toViewController:target loadString:nil success:success failure:failure];
  
}

//产品众筹订单详情
+(NSURLSessionDataTask *) crowOrderDetailID:(NSString *)apply_id
                            ViewController:(UIViewController *) target
                                   success:(void(^)(id json)) success
                                   failure:(void(^)(NSError* error))failure
{
    
    NSDictionary *params = @{
                             @"order_sn"  :apply_id,
                             @"member_id" :USERINFO.memberId
                             };
    
    return [HttpTool PostWithLoading:@"/api/v1/order/crowOrderDetail" params:params toViewController:target loadString:nil success:success failure:failure];
}

//支持服务的列表
+(NSURLSessionDataTask *) supportOrders:(NSString *)page
                               order_status:(NSString *)order_status
                             ViewController:(UIViewController *) target
                                    success:(void(^)(id json)) success
                                    failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.memberId,
                             @"page"    :page,
                             @"limit" :@"10",
                             @"order_status" :order_status
                             };
    
    
    return [HttpTool PostWithLoading:@"/api/v1/order/supportOrders" params:params toViewController:target loadString:nil success:success failure:failure];
}

//支持服务订单详情
+(NSURLSessionDataTask *) supportOrderDetailID:(NSString *)apply_id
                             ViewController:(UIViewController *) target
                                    success:(void(^)(id json)) success
                                    failure:(void(^)(NSError* error))failure
{
    
    NSDictionary *params = @{
                             @"order_sn"  :apply_id,
                             @"member_id" :USERINFO.memberId
                             };
    
    return [HttpTool PostWithLoading:@"/api/v1/order/supportOrderDetail" params:params toViewController:target loadString:nil success:success failure:failure];
}


//会议培训列表
+(NSURLSessionDataTask *) trainOrders:(NSString *)page
                           order_status:(NSString *)order_status
                         ViewController:(UIViewController *) target
                                success:(void(^)(id json)) success
                                failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.memberId,
                             @"page"    :page,
                             @"limit" :@"10",
                             @"order_status" :order_status
                             };
    
    
    return [HttpTool PostWithLoading:@"/api/v1/order/trainOrders" params:params toViewController:target  loadString:nil success:success failure:failure];
}

//会议培训列表详情
+(NSURLSessionDataTask *) trainOrderDetailID:(NSString *)apply_id
                                ViewController:(UIViewController *) target
                                       success:(void(^)(id json)) success
                                       failure:(void(^)(NSError* error))failure
{
    
    NSDictionary *params = @{
                             @"order_sn"  :apply_id,
                             @"member_id" :USERINFO.memberId
                             };
    
    return [HttpTool PostWithLoading:@"/api/v1/order/trainOrderDetail" params:params toViewController:target loadString:nil success:success failure:failure];
}



//查看课表
+(NSURLSessionDataTask *) findTimetableID:(NSString *)apply_id
                              ViewController:(UIViewController *) target
                                     success:(void(^)(id json)) success
                                     failure:(void(^)(NSError* error))failure
{
    
    NSDictionary *params = @{
                             @"course_id" : apply_id
                            };
    
    return [HttpTool PostWithLoading:@"/api/v1/course/findTimetable" params:params toViewController:target loadString:nil success:success failure:failure];
}


//******************************发布模块**************************//

//众筹提议
+(NSURLSessionDataTask *) addZCTypeId:(NSString *)type_id
                           apply_name:(NSString *)apply_name
                           apply_desc:(NSString *)apply_desc
                          apply_price:(NSString *)apply_price
                           apply_type:(NSString *)apply_type
                                 file:(NSArray *)array
                                ViewController:(UIViewController *) target
                                       success:(void(^)(id json)) success
                                       failure:(void(^)(NSError* error))failure
{

    NSDictionary *params = @{
                             @"type_id"  :type_id,
                             @"apply_type": apply_type,
                             @"apply_price": apply_price,
                             @"apply_name" : apply_name,
                             @"member_id" :USERINFO.memberId,
                             @"apply_desc" :apply_desc
                             };

    return [HttpTool UploadManyImg:@"/api/v1/fund/add" params:params file:array toViewController:target loadString:@"提议" success:success failure:failure];
}

//培训提议
+(NSURLSessionDataTask *) addPXTypeId:(NSString *)type_id
                           apply_name:(NSString *)apply_name
                           apply_desc:(NSString *)apply_desc
                           apply_type:(NSString *)apply_type
                                 file:(NSArray *)array
                       ViewController:(UIViewController *) target
                              success:(void(^)(id json)) success
                              failure:(void(^)(NSError* error))failure
{
    
    NSDictionary *params = @{
                                 @"member_id" :USERINFO.memberId,
                                 @"apply_name":apply_name,
                                 @"type_id":type_id,
                                 @"apply_desc" :apply_desc
                             };
    if ([apply_type isEqualToString:@"1"]) {
        
       return [HttpTool UploadManyImg:@"/api/v1/course/add" params:params file:array toViewController:target loadString:@"提议" success:success failure:failure];
    }
    
    else
    {
     return [HttpTool UploadManyImg:@"/api/v1/service/add" params:params file:array toViewController:target loadString:@"提议" success:success failure:failure];
    }
    
   
}


//金点子提议
+(NSURLSessionDataTask *) addGoodIdeaTypeId:(NSString *)type_id
                           apply_name:(NSString *)apply_name
                           apply_desc:(NSString *)apply_desc
                          apply_price:(NSString *)apply_price
                           keywords:(NSString *)keywords
                                 support_id:(NSString *)support_id
                                 file:(NSArray *)array
                       ViewController:(UIViewController *) target
                              success:(void(^)(id json)) success
                              failure:(void(^)(NSError* error))failure
{
    
    NSDictionary *params = @{
                             @"type_id"  :type_id,
                             @"keywords": keywords,
                             @"apply_name" : apply_name,
                             @"member_id" :USERINFO.memberId,
                             @"apply_desc" :apply_desc,
                             @"support_id" :support_id
                             };

    return [HttpTool UploadManyImg:@"/api/v1/idea/add" params:params file:array toViewController:target loadString:@"提议" success:success failure:failure];
}

//提交评价
+(NSURLSessionDataTask *) addDiscussTypeId:(NSString *)is_privated
                           comment_content:(NSString *)comment_content
                           comment_type:(NSString *)comment_type
                           comment_img:(NSArray *)comment_img
                           comment_star:(NSString *)comment_star
                                comment_id:(NSString *)comment_id
                       ViewController:(UIViewController *) target
                              success:(void(^)(id json)) success
                              failure:(void(^)(NSError* error))failure
{
    
    NSDictionary *params = @{
                             @"is_privated"  :is_privated,
                             @"comment_img": comment_img,
                             @"comment_type": comment_type,
                             @"comment_content" : comment_content,
                             @"member_id" :USERINFO.memberId,
                             @"comment_star":comment_star,
                             @"comment_id" :comment_id
                             };
    
    return [HttpTool UploadManyImg:@"/api/v1/comment/add" params:params file:comment_img toViewController:target loadString:@"提交" success:success failure:failure];
}


//众筹提议学科类别

+(NSURLSessionDataTask *) typeList:(NSString *)apply_id
                                ViewController:(UIViewController *) target
                                       success:(void(^)(id json)) success
                                       failure:(void(^)(NSError* error))failure
{
    
    NSDictionary *params = @{
                             @"type"  :apply_id,
                             
                             };
    
    return [HttpTool PostWithLoading:@"/api/v1/fund/typeList" params:params toViewController:target loadString:nil success:success failure:failure];
}



//我的服务已提议列表
+(NSURLSessionDataTask *) addList:(NSString *)page
                         ViewController:(UIViewController *) target
                                success:(void(^)(id json)) success
                                failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.memberId,
                             @"page"    :page,
                             @"pageSize" :@"5",
                             };
    
    
    return [HttpTool PostWithLoading:@"/api/v1/service/addList" params:params toViewController:target loadString:nil  success:success failure:failure];
}


//人员列表
+(NSURLSessionDataTask *) mypersonListViewController:(UIViewController *) target
                          success:(void(^)(id json)) success
                          failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.memberId,

                            };

    return [HttpTool PostWithLoading:@"/api/v1/course/personList" params:params toViewController:target loadString:nil  success:success failure:failure];
}

//修改人员列表
+(NSURLSessionDataTask *) changePerson:(NSString *)person_id
                                  key:(NSString *)key
                                 vakue:(NSString *)vakue
                        ViewController:(UIViewController *) target
                               success:(void(^)(id json)) success
                               failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.memberId,
                             @"person_id"  :person_id,
                             key           :vakue
                             };
    
    return [HttpTool PostWithLoading:@"/api/v1/course/updatePerson" params:params toViewController:target loadString:nil  success:success failure:failure];
}




//删除人员
+(NSURLSessionDataTask *) deletePerson:(NSString *)person_id ViewController:(UIViewController *) target
                                             success:(void(^)(id json)) success
                                             failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.memberId,
                             @"person_id"  :person_id
                             };
    
    return [HttpTool PostWithLoading:@"/api/v1/course/deletePerson" params:params toViewController:target loadString:nil  success:success failure:failure];
}

//添加培训人员
+(NSURLSessionDataTask *) addPersonname:(NSString *)name
                           identity_id:(NSString *)identity_id
                                mobile:(NSString *)mobile
                                  work:(NSString *)work
                                 email:(NSString *)email
                                 campus:(NSString *)campus
                            master_name:(NSString *)master_name
                        ViewController:(UIViewController *) target
                               success:(void(^)(id json)) success
                               failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.memberId,
                             @"name"       :name,
                             @"identity_id" :identity_id,
                             @"mobile"  :mobile,
                             @"email" :email,
                             @"work" :work,
                             @"campus": campus,
                             @"master_name" :master_name
                             };
    
    return [HttpTool PostWithLoading:@"/api/v1/course/addPerson" params:params toViewController:target loadString:nil  success:success failure:failure];
}

//******************************我的金电子模块**************************//
+(NSURLSessionDataTask *) goodIdea:(NSInteger )type page:(NSInteger)page
                               ViewController:(UIViewController *) target
                               success:(void(^)(id json)) success
                               failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.memberId,
                             @"page"        :@(page)
                             };
    if(type==0){
    //已点赞
    return [HttpTool PostWithLoading:@"/api/v1/idea/findThumbs" params:params toViewController:target loadString:nil  success:success failure:failure];
    }
    else if (type==1)
    {
        //一收藏
     return [HttpTool PostWithLoading:@"/api/v1/idea/findCollection" params:params toViewController:target loadString:nil  success:success failure:failure];
    }
    else
    {
         //已提议
          return [HttpTool PostWithLoading:@"/api/v1/idea/findProposal" params:params toViewController:target loadString:nil  success:success failure:failure];
    }
}


//反馈建议的弹窗列表
+(NSURLSessionDataTask *) disTypeViewController:(UIViewController *) target
                                success:(void(^)(id json)) success
                                failure:(void(^)(NSError* error))failure
{
    return [HttpTool PostWithLoading:@"/api/v1/complaint/findPosition" params:nil toViewController:target loadString:nil  success:success failure:failure];
}

//提交反馈
+(NSURLSessionDataTask *) disConfirm:(NSString *)person_id
                            synopsis:(NSString *)synopsis
                         position_id:(NSString *)position_id
                              mobile:(NSString *)mobile
                                file:(NSArray *)file
                      ViewController:(UIViewController *) target
                               success:(void(^)(id json)) success
                             failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.memberId,
                             @"synopsis"  :synopsis,
                             @"position_id" :position_id,
                             @"mobile"  :mobile
                             };
    ///api/v1/course/deletePerson
    return [HttpTool UploadManyImg:@"/api/v1/complaint/add" params:params file:file toViewController:target loadString:@"提交" success:success failure:failure];
}

////历史反馈列表
+(NSURLSessionDataTask *) findComplaintViewController:(UIViewController *) target
                                        success:(void(^)(id json)) success
                                        failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.memberId
                             };
    
    return [HttpTool PostWithLoading:@"/api/v1/complaint/findComplaint" params:params toViewController:target loadString:nil  success:success failure:failure];
}

//详情
+(NSURLSessionDataTask *) getComplaint:(NSString *)complaint_id
                                             ViewController:(UIViewController *) target
                                              success:(void(^)(id json)) success
                                              failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"complaint_id"  :complaint_id
                             };
    
    return [HttpTool PostWithLoading:@"/api/v1/complaint/getComplaint" params:params toViewController:target loadString:nil  success:success failure:failure];
}

//反馈的评论
+(NSURLSessionDataTask *) addComment:(NSString *)complaint_id
                                desc:(NSString *)desc
                        ViewController:(UIViewController *) target
                               success:(void(^)(id json)) success
                               failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"complaint_id"  :complaint_id,
                             @"synopsis" :desc
                             };
    
    return [HttpTool PostWithLoading:@"/api/v1/complaint/addComment" params:params toViewController:target loadString:nil  success:success failure:failure];
}

//大比拼
+(NSURLSessionDataTask *) findMyDBPList:(NSString *)page
                                   type:(NSInteger)type
                   ViewController:(UIViewController *) target
                          success:(void(^)(id json)) success
                          failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.memberId,
                             @"page"    :page,
                             @"pageSize" :@"10",
                             @"type"  :@(type)
                             };
    
    
    return [HttpTool PostWithLoading:@"/api/v1/match/findMyList" params:params toViewController:target loadString:nil  success:success failure:failure];
}


//////////////////////////////////////////////////////////////////
//****************************首页的模块**************************//
//**************************************************************//
//**************************************************************//
//////////////////////////////////////////////////////////////////


+(NSURLSessionDataTask *)homePageWithParam:(NSDictionary *)param
                          toViewController:(UIViewController *) target
                                   success:(void(^)(id json)) success
                                   failure:(void(^)(NSError* error))failure{
    
    return [HttpTool PostWithLoading:@"/api/v1/common/index" params:param toViewController:target loadString:nil success:success failure:failure];
}

#pragma mark - 微点资讯
/**
 *  微点资讯
 */
+(NSURLSessionDataTask *)onlyNewsListWithParam:(NSDictionary *)param
                          toViewController:(UIViewController *) target
                                   success:(void(^)(id json)) success
                                   failure:(void(^)(NSError* error))failure{
    return [HttpTool PostWithLoading:@"/api/v1/news/newsList" params:param toViewController:target loadString:nil success:success failure:failure];
}


#pragma mark - 众筹模块

+(NSURLSessionDataTask *)listWithParam:(NSDictionary *)param
                     toViewController:(UIViewController *) target
                                  success:(void(^)(id json)) success
                                  failure:(void(^)(NSError* error))failure{

    return [HttpTool PostWithLoading:@"/api/v1/fund/findAll" params:param toViewController:target loadString:nil success:success failure:failure];

}

+(NSURLSessionDataTask *)crowdFundDetailWithParam:(NSDictionary *)param
                                 toViewController:(UIViewController *) target
                                          success:(void(^)(id json)) success
                                          failure:(void(^)(NSError* error))failure{
    
    return [HttpTool PostWithLoading:@"/api/v1/fund/detail" params:param toViewController:target loadString:nil success:success failure:failure];

}

+(NSURLSessionDataTask *)filterListWithParam:(NSDictionary *)param
                            toViewController:(UIViewController *) target
                                     success:(void(^)(id json)) success
                                     failure:(void(^)(NSError* error))failure{
    return [HttpTool PostOutLoading:@"/api/v1/fund/typeList" params:param toViewController:target success:success failure:failure];
}

+(NSURLSessionDataTask *)thumbFundWithParam:(NSDictionary *)param
                            toViewController:(UIViewController *) target
                                     success:(void(^)(id json)) success
                                     failure:(void(^)(NSError* error))failure{
    return [HttpTool PostOutLoading:@"/api/v1/fund/thumbFund" params:param toViewController:target success:success failure:failure];
}

+(NSURLSessionDataTask *)collectFundWithParam:(NSDictionary *)param
                             toViewController:(UIViewController *) target
                                      success:(void(^)(id json)) success
                                      failure:(void(^)(NSError* error))failure{
    
    return [HttpTool PostOutLoading:@"/api/v1/fund/collectFund" params:param toViewController:target success:success failure:failure];
    
}

+(NSURLSessionDataTask *)commentListWithParam:(NSDictionary *)param
                             toViewController:(UIViewController *) target
                                      success:(void(^)(id json)) success
                                      failure:(void(^)(NSError* error))failure{
    return [HttpTool PostOutLoading:@"/api/v1/common/commentList" params:param toViewController:target success:success failure:failure];
}
#pragma mark - 会议培训模块
/**
 *  获取会议列表
 */
+(NSURLSessionDataTask *)conferenceListWithParam:(NSDictionary *)param
                                toViewController:(UIViewController *) target
                                         success:(void(^)(id json)) success
                                         failure:(void(^)(NSError* error))failure{
    return [HttpTool PostWithLoading:@"/api/v1/course/indexList" params:param toViewController:target loadString:nil success:success failure:failure];
}

/**
 *  获取即将报名会议列表
 */
+(NSURLSessionDataTask *)conferenceSoonEnrollListWithParam:(NSDictionary *)param
                                          toViewController:(UIViewController *) target
                                                   success:(void(^)(id json)) success
                                                   failure:(void(^)(NSError* error))failure{
    return [HttpTool PostWithLoading:@"/api/v1/course/soonList" params:param toViewController:target loadString:nil success:success failure:failure];
}



/**
 *  获取会议详情
 */
+(NSURLSessionDataTask *)conferenceDetailWithParam:(NSDictionary *)param
                                  toViewController:(UIViewController *) target
                                           success:(void(^)(id json)) success
                                           failure:(void(^)(NSError* error))failure{
    return [HttpTool PostWithLoading:@"/api/v1/course/detail" params:param toViewController:target loadString:nil success:success failure:failure];
}

/**
 *  人员列表
 */
+(NSURLSessionDataTask *)peopleListWithParam:(NSDictionary *)param
                            toViewController:(UIViewController *) target
                                     success:(void(^)(id json)) success
                                     failure:(void(^)(NSError* error))failure{
    return [HttpTool PostWithLoading:@"/api/v1/course/personList" params:param toViewController:target loadString:nil success:success failure:failure];
}

/**
 *  添加会议培训订单
 */
+(NSURLSessionDataTask *)addConferenceOrderListWithParam:(NSDictionary *)param
                                        toViewController:(UIViewController *) target
                                                 success:(void(^)(id json)) success
                                                 failure:(void(^)(NSError* error))failure{
    return [HttpTool PostWithLoading:@"/api/v1/order/addTrainOrder" params:param toViewController:target loadString:nil success:success failure:failure];
}


/**
 *  会议培训关注
 */
+(NSURLSessionDataTask *)conferenceFollowWithParam:(NSDictionary *)param
                                  toViewController:(UIViewController *) target
                                           success:(void(^)(id json)) success
                                           failure:(void(^)(NSError* error))failure{
    return [HttpTool PostWithLoading:@"/api/v1/course/focus" params:param toViewController:target loadString:nil success:success failure:failure];
}


#pragma mark - 支持服务模块

+(NSURLSessionDataTask *)serviceListWithParam:(NSDictionary *)param
                            toViewController:(UIViewController *) target
                                     success:(void(^)(id json)) success
                                     failure:(void(^)(NSError* error))failure{
    return [HttpTool PostWithLoading:@"/api/v1/service/findAll" params:param toViewController:target loadString:nil success:success failure:failure];
}


+(NSURLSessionDataTask *)serviceDetailWithParam:(NSDictionary *)param
                               toViewController:(UIViewController *)target
                                        success:(void(^)(id json)) success
                                        failure:(void(^)(NSError* error))failure{
    return [HttpTool PostWithLoading:@"/api/v1/service/detail" params:param toViewController:target loadString:nil success:success failure:failure];
}

+(NSURLSessionDataTask *)serviceManListWithParam:(NSDictionary *)param
                                      toViewController:(UIViewController *) target
                                               success:(void(^)(id json)) success
                                               failure:(void(^)(NSError* error))failure{
    return [HttpTool PostWithLoading:@"/api/v1/service/personList" params:param toViewController:target loadString:nil success:success failure:failure];
}

+(NSURLSessionDataTask *)addServiceOrderListWithParam:(NSDictionary *)param
                                     toViewController:(UIViewController *) target
                                              success:(void(^)(id json)) success
                                              failure:(void(^)(NSError* error))failure{
    
    return [HttpTool PostWithLoading:@"/api/v1/order/addSupportOrder" params:param toViewController:target loadString:nil success:success failure:failure];
    
}

#pragma mark - 大比拼
/**
 *  大比拼列表
 */
+(NSURLSessionDataTask *)competitionListWithParam:(NSDictionary *)param
                                 toViewController:(UIViewController *) target
                                          success:(void(^)(id json)) success
                                          failure:(void(^)(NSError* error))failure{
    return [HttpTool PostWithLoading:@"/api/v1/match/findList" params:param toViewController:target loadString:nil success:success failure:failure];
    
}

/**
 *  大比拼详情
 */
+(NSURLSessionDataTask *)competitionDetailWithParam:(NSDictionary *)param
                                   toViewController:(UIViewController *) target
                                            success:(void(^)(id json)) success
                                            failure:(void(^)(NSError* error))failure{
    return [HttpTool PostWithLoading:@"/api/v1/match/findDetail" params:param toViewController:target loadString:nil success:success failure:failure];
}


/**
 *  大比拼报名
 */
+(NSURLSessionDataTask *)competitionEnrollWithParam:(NSDictionary *)param
                                           fileData:(NSArray *)fileDataArray
                                               name:(NSArray *)nameArray
                                           fileName:(NSArray *)fileNameArray
                                           fileType:(NSArray *)fileTypeNameArray
                                   toViewController:(UIViewController *) target
                                            success:(void(^)(id json)) success
                                            failure:(void(^)(NSError* error))failure{
    
    return [HttpTool UploadMediaSource:@"/api/v1/match/add" params:param fileData:fileDataArray name:nameArray fileName:fileNameArray fileTypeName:fileTypeNameArray toViewController:target loadString:@"报名" success:success failure:failure];
}

/**
 *  大比拼投票人员列表
 */
+(NSURLSessionDataTask *)competitionVoteListWithParam:(NSDictionary *)param
                                     toViewController:(UIViewController *) target
                                              success:(void(^)(id json)) success
                                              failure:(void(^)(NSError* error))failure{
    return [HttpTool PostWithLoading:@"/api/v1/match/findVote" params:param toViewController:target loadString:nil success:success failure:failure];
}


/**
 *  大比拼投票
 */
+(NSURLSessionDataTask *)competitionVoteWithParam:(NSDictionary *)param
                                 toViewController:(UIViewController *) target
                                          success:(void(^)(id json)) success
                                          failure:(void(^)(NSError* error))failure{
    return [HttpTool PostWithLoading:@"/api/v1/match/addVote" params:param toViewController:target loadString:nil success:success failure:failure];
}

/**
 *  大比拼人员详情
 */
+(NSURLSessionDataTask *)competitionCandidateDetailWithParam:(NSDictionary *)param
                                            toViewController:(UIViewController *) target
                                                     success:(void(^)(id json)) success
                                                     failure:(void(^)(NSError* error))failure{
    return [HttpTool PostWithLoading:@"/api/v1/match/findMemberInfo" params:param toViewController:target loadString:nil success:success failure:failure];
}

/**
 *  大比拼结果
 */
+(NSURLSessionDataTask *)competitionResultWithParam:(NSDictionary *)param
                                   toViewController:(UIViewController *) target
                                            success:(void(^)(id json)) success
                                            failure:(void(^)(NSError* error))failure{
    return [HttpTool PostWithLoading:@"/api/v1/match/findVoteResult" params:param toViewController:target loadString:nil success:success failure:failure];
}

#pragma mark - 金点子模块

/**
 *  获取金点子列表
 */
+(NSURLSessionDataTask *)ideaListWithParam:(NSDictionary *)param
                          toViewController:(UIViewController *) target
                                   success:(void(^)(id json)) success
                                   failure:(void(^)(NSError* error))failure{
    return [HttpTool PostWithLoading:@"/api/v1/idea/findAllApply" params:param toViewController:target loadString:nil success:success failure:failure];
}

/**
 *  获取金点子详情
 */
+(NSURLSessionDataTask *)ideaDetailWithParam:(NSDictionary *)param
                            toViewController:(UIViewController *) target
                                     success:(void(^)(id json)) success
                                     failure:(void(^)(NSError* error))failure{
    return [HttpTool PostWithLoading:@"/api/v1/idea/find" params:param toViewController:target loadString:nil success:success failure:failure];
}

/**
 *  金点子排行榜
 */
+(NSURLSessionDataTask *)ideaRankingListWithParam:(NSDictionary *)param
                                 toViewController:(UIViewController *) target
                                          success:(void(^)(id json)) success
                                          failure:(void(^)(NSError* error))failure{
    return [HttpTool PostWithLoading:@"/api/v1/idea/findRanking" params:param toViewController:target loadString:nil success:success failure:failure];
}

/**
 *  金点子点赞
 */
+(NSURLSessionDataTask *)ideaThumbWithParam:(NSDictionary *)param
                               toViewController:(UIViewController *) target
                                        success:(void(^)(id json)) success
                                        failure:(void(^)(NSError* error))failure{
    return [HttpTool PostWithLoading:@"/api/v1/idea/addThumbs" params:param toViewController:target loadString:@"点赞" success:success failure:failure];
}

/**
 *  金点子收藏
 */
+(NSURLSessionDataTask *)ideaCollectWithParam:(NSDictionary *)param
                           toViewController:(UIViewController *) target
                                    success:(void(^)(id json)) success
                                    failure:(void(^)(NSError* error))failure{
    return [HttpTool PostWithLoading:@"/api/v1/idea/addCollection" params:param toViewController:target loadString:@"收藏" success:success failure:failure];
}


#pragma mark - 文件下载
/**
 *  文件列表
 */
+(NSURLSessionDataTask *)downLoadTypeListWithParam:(NSDictionary *)param
                                  toViewController:(UIViewController *) target
                                           success:(void(^)(id json)) success
                                           failure:(void(^)(NSError* error))failure{
    return [HttpTool PostWithLoading:@"/api/v1/download/findDownloadTypes" params:param toViewController:target loadString:nil success:success failure:failure];
}

#pragma mark - 支付
+(NSURLSessionDataTask *)payWithParam:(NSDictionary *)param
                     toViewController:(UIViewController *) target
                              success:(void(^)(id json)) success
                              failure:(void(^)(NSError* error))failure{
    return [HttpTool PostWithLoading:@"/api/v1/pay/wxPay" params:param toViewController:target loadString:nil success:success failure:failure];
}
/**
 *  支付宝
 */
+(NSURLSessionDataTask *)aliPayWithParam:(NSDictionary *)param
                     toViewController:(UIViewController *) target
                              success:(void(^)(id json)) success
                              failure:(void(^)(NSError* error))failure{
    return [HttpTool PostWithLoading:@"/api/v1/pay/aliPay" params:param toViewController:target loadString:nil success:success failure:failure];
}

#pragma mark - 购物车

+(NSURLSessionDataTask *)addToCartWithParam:(NSDictionary *)param
                           toViewController:(UIViewController *) target
                                    success:(void(^)(id json)) success
                                    failure:(void(^)(NSError* error))failure{
    return [HttpTool PostWithLoading:@"/api/v1/cart/add" params:param toViewController:target loadString:nil success:success failure:failure];
}



#pragma mark - 消息的模块
/**
 *  查询消息
 */
+(NSURLSessionDataTask *) findNewsType:(NSString *)tiding_type ViewController:(UIViewController *) target success:(void(^)(id json)) success failure:(void(^)(NSError* error))failure
{
    NSString *myid = @"";
    if(USERINFO.personal == YES)
    {
        myid = USERINFO.MmemberId;
    }
    else
    {
      myid = USERINFO.memberId;
    }
    NSDictionary *params = @{
                             @"member_id"  :myid,
                             @"tiding_type"  :tiding_type
                             };
    
    return [HttpTool PostWithLoading:@"/api/v1/tiding/find" params:params toViewController:target loadString:nil  success:success failure:failure];
}

/**
 *  设置为已读
 */
+(NSURLSessionDataTask *) hasReadedType:(NSString *)tiding_type newsId:(NSString *)newsId ViewController:(UIViewController *) target success:(void(^)(id json)) success failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.memberId,
                             @"tiding_type"  :tiding_type,
                             @"id"           :newsId
                             };
    
    return [HttpTool PostWithLoading:@"/api/v1/tiding/update" params:params toViewController:target loadString:nil  success:success failure:failure];
}


/**
 *  全部设置为已读
 */
+(NSURLSessionDataTask *) NewsAllReadViewController:(UIViewController *) target success:(void(^)(id json)) success failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.memberId,
                        
                             };
    
    return [HttpTool PostWithLoading:@"/api/v1/tiding/updateAll" params:params toViewController:target loadString:nil  success:success failure:failure];
}

/**
 *  查询未读数量
 */
+(NSURLSessionDataTask *) NewsNotReadViewController:(UIViewController *) target success:(void(^)(id json)) success failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.memberId,
                             
                             };
    
    return [HttpTool PostWithLoading:@"/api/v1/tiding/count" params:params toViewController:target loadString:nil  success:success failure:failure];
}


#pragma mark - 搜索模块

//热门搜索
+(NSURLSessionDataTask *) recommend:(NSInteger)type   ViewController:(UIViewController *) target success:(void(^)(id json)) success failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.memberId,
                            };
    
    return [HttpTool PostWithLoading:@"/api/v1/common/recommend" params:params toViewController:target loadString:nil  success:success failure:failure];
}

//热门搜索历史
+(NSURLSessionDataTask *) historykeyWord:(NSString *)keyword keyType:(NSInteger)keyType ViewController:(UIViewController *) target success:(void(^)(id json)) success failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"member_id": USERINFO.memberId,
                             @"search_name": keyword,
                             @"search_type": @(keyType)
                             
                            };
    
    return [HttpTool PostWithLoading:@"/api/v1/common/addSearchHistory" params:params toViewController:target loadString:nil  success:success failure:failure];
}


#pragma mark - 市场人员端 对接口  😔😔😔😔😔😔难受

//列表
+(NSURLSessionDataTask *) getMarketSupportOrders:(NSString *)page
                                            type:(NSInteger)type
                             ViewController:(UIViewController *) target
                                    success:(void(^)(id json)) success
                                    failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.MmemberId,
                             @"page"    :page,
                             @"limit" :@"10",
                             @"type" :@(type)
                             };
    
    
    return [HttpTool PostWithLoading:@"/api/v1/order/getMarketSupportOrders" params:params toViewController:target loadString:nil success:success failure:failure];
    
}

//详情
+(NSURLSessionDataTask *) getMarketSupportDetail:(NSString *)order_sn
                                  ViewController:(UIViewController *) target
                                         success:(void(^)(id json)) success
                                         failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.MmemberId,
                             @"order_sn"    :order_sn,
        
                             };
    
    
    return [HttpTool PostWithLoading:@"/api/v1/order/getMarketSupportDetail" params:params toViewController:target loadString:nil success:success failure:failure];
    
}

//市场人员是否接受支持服务订单
+(NSURLSessionDataTask *) acceptSupportOrder:(NSString *)order_sn
                                  is_receive:(NSString *)is_receive
                                  ViewController:(UIViewController *) target
                                         success:(void(^)(id json)) success
                                         failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.memberId,
                             @"order_sn"    :order_sn,
                             @"is_receive" :is_receive
                             };
    
    
    return [HttpTool PostWithLoading:@"/api/v1/order/acceptSupportOrder" params:params toViewController:target loadString:nil success:success failure:failure];
    
}

//市场人员开始服务
+(NSURLSessionDataTask *) beginSupportOrder:(NSString *)order_sn
                              ViewController:(UIViewController *) target
                                     success:(void(^)(id json)) success
                                     failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.MmemberId,
                             @"order_sn"    :order_sn,
                             };
    
    
    return [HttpTool PostWithLoading:@"/api/v1/order/beginSupportOrder" params:params toViewController:target loadString:nil success:success failure:failure];
    
}

//市场人员结束服务
+(NSURLSessionDataTask *) endSupportOrder:(NSString *)order_sn
                             ViewController:(UIViewController *) target
                                    success:(void(^)(id json)) success
                                    failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.MmemberId,
                             @"order_sn"    :order_sn,
                             };
    
    
    return [HttpTool PostWithLoading:@"/api/v1/order/endSupportOrder" params:params toViewController:target loadString:nil success:success failure:failure];
    
}

//市场人员的级别和服务次数
+(NSURLSessionDataTask *) serviceTimes:(NSString *)order_sn
                           ViewController:(UIViewController *) target
                                  success:(void(^)(id json)) success
                                  failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.MmemberId,
                             };
    
    
    return [HttpTool PostWithLoading:@"/api/v1/user/service" params:params toViewController:target loadString:nil success:success failure:failure];
    
}


//金币规则
+(NSURLSessionDataTask *) coinRule:(NSString *)order_sn
                        ViewController:(UIViewController *) target
                               success:(void(^)(id json)) success
                               failure:(void(^)(NSError* error))failure
{
    
    return [HttpTool PostWithLoading:@"/api/v1/point/findConfig" params:nil toViewController:target loadString:nil success:success failure:failure];
}

//文件下载
+(NSURLSessionDataTask *) findMyRecords:(NSString *)order_sn
                        ViewController:(UIViewController *) target
                               success:(void(^)(id json)) success
                               failure:(void(^)(NSError* error))failure
{
    NSDictionary *params = @{
                             @"member_id"  :USERINFO.memberId,
                             };
    
    
    return [HttpTool PostWithLoading:@"/api/v1/download/findMyRecords" params:params toViewController:target loadString:nil success:success failure:failure];
    
}

//文件下载
+(NSURLSessionDataTask *) support:(NSString *)order_sn
                         ViewController:(UIViewController *) target
                                success:(void(^)(id json)) success
                                failure:(void(^)(NSError* error))failure
{
  
    return [HttpTool PostWithLoading:@"/api/v1/idea/support" params:nil toViewController:target loadString:nil success:success failure:failure];
}

@end





