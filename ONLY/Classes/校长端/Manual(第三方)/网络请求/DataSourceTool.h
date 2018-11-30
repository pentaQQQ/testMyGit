//
//  DataSourceTool.h
//  OA
//
//  Created by George on 16/10/31.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpTool.h"

@interface DataSourceTool : NSObject
+(void)saveUserInfo:(NSDictionary *)response;
+(void)saveMemberUserInfo:(NSDictionary *)response;
//登录
+(NSURLSessionDataTask *)requestLogin:(NSString *)mobile
                             password:(NSString *)pwd
                                type :(NSString *)type
                     toViewController:(UIViewController *) target
                              success:(void(^)(id json)) success
                              failure:(void(^)(NSError* error))failure;

/**
 *  获取验证码
 */

+(NSURLSessionDataTask *) requestMobileCode:(NSString *)mobile typePhone:(NSString *)typePhone
                           toViewController:(UIViewController *) target
                                    success:(void(^)(id json)) success
                                    failure:(void(^)(NSError* error))failure;

/**
 *  注册
 */
+(NSURLSessionDataTask *) requestRegister:(NSString *)mobile
                                 password:(NSString *)pwd
                                     code:(NSString *)code
                         toViewController:(UIViewController *) target
                                  success:(void(^)(id json)) success
                                  failure:(void(^)(NSError* error))failure;

+(NSURLSessionDataTask *)forGotPassword:(NSString *)mobile
                       toViewController:(UIViewController *) target
                                success:(void(^)(id json)) success
                                failure:(void(^)(NSError* error))failure;

/**
 *  找回密码
 */
+(NSURLSessionDataTask *) findPassword:(NSString *)mobile
                              password:(NSString *)pwd
                                  code:(NSString *)code
                      toViewController:(UIViewController *) target
                               success:(void(^)(id json)) success
                               failure:(void(^)(NSError* error))failure;

/**
 *  兴趣设置
 */
+(NSURLSessionDataTask *) findTypetoViewController:(UIViewController *) target
                                           success:(void(^)(id json)) success
                                           failure:(void(^)(NSError* error))failure;


/**
 *  修改头像
 */
+(NSURLSessionDataTask *)uploadImg:(NSData *)imageData
                  toViewController:(UIViewController *) target
                           success:(void(^)(id json)) success
                           failure:(void(^)(NSError* error))failure;


/**
 *  完善个人信息
 */
+(NSURLSessionDataTask *) updateMineInformation:(NSString *)mykey
                                        myValue:(NSString *)myValue
                               toViewController:(UIViewController *) target
                                        success:(void(^)(id json)) success
                                        failure:(void(^)(NSError* error))failure;

/**
 *   我的设置里面的修改手机号
 */
+(NSURLSessionDataTask *) changePhoneNum:(NSString *)mobile
                                memberId:(NSString *)memberId
                                    code:(NSString *)code
                        toViewController:(UIViewController *) target
                                 success:(void(^)(id json)) success
                                 failure:(void(^)(NSError* error))failure;

/**
 *   我的设置里面修改密码接口
 */
+(NSURLSessionDataTask *) modifyPasswd:(NSString *)mobile
                                oldpwd:(NSString *)oldpwd
                                   pwd:(NSString *)pwd
                                 repwd:(NSString *)repwd
                      toViewController:(UIViewController *) target
                               success:(void(^)(id json)) success
                               failure:(void(^)(NSError* error))failure;

/**
 *   地址管理
 */
+(NSURLSessionDataTask *) findAddressStaus:(NSString *)status ViewController:(UIViewController *) target
                                   success:(void(^)(id json)) success
                                   failure:(void(^)(NSError* error))failure;



/**
 *   添加新的地址
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
                              failure:(void(^)(NSError* error))failure;

/**
 *   删除地址
 */
+(NSURLSessionDataTask *) deleteAddress:(NSString *)member_address_id
                       toViewController:(UIViewController *) target
                                success:(void(^)(id json)) success
                                failure:(void(^)(NSError* error))failure;


/**
 *  设置为默认
 */

+(NSURLSessionDataTask *) defaultAddress:(NSString *)member_address_id
                        toViewController:(UIViewController *) target
                                 success:(void(^)(id json)) success
                                 failure:(void(^)(NSError* error))failure;


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
                                failure:(void(^)(NSError* error))failure;

/**
 *  购车列表
 */

+(NSURLSessionDataTask *) cartListtoViewController:(UIViewController *) target
                                           success:(void(^)(id json)) success
                                           failure:(void(^)(NSError* error))failure;


//修改购物车中商品数量
+(NSURLSessionDataTask *) editNumgoods_id:(NSString *)goods_id
                                  cart_id:(NSString *)cart_id
                                      num:(NSString *)num
                           ViewController:(UIViewController *) target
                                  success:(void(^)(id json)) success
                                  failure:(void(^)(NSError* error))failure;


/**
 *  删除订单
 */
+(NSURLSessionDataTask *) deleteOrderID:(NSString *)car_ids
                         ViewController:(UIViewController *) target
                                success:(void(^)(id json)) success
                                failure:(void(^)(NSError* error))failure;


/**
 *  去结算
 */
+(NSURLSessionDataTask *) settleOrderID:(NSString *)car_ids
                         ViewController:(UIViewController *) target
                                success:(void(^)(id json)) success
                                failure:(void(^)(NSError* error))failure;

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
                              failure:(void(^)(NSError* error))failure;



//*************************购物车里面的按钮各种状态的点击事件*****************************//

//删除订单
+(NSURLSessionDataTask *) deleteOrder:(NSInteger)type
                             order_sn:(NSString *)order_sn
                           order_type:(NSString *)order_type
                       ViewController:(UIViewController *) target
                              success:(void(^)(id json)) success
                              failure:(void(^)(NSError* error))failure;



//********************************END**********************************************//


//////////////////////我的界面的产品众筹//////////////////////////
//已购买
+(NSURLSessionDataTask *) purchaseListPage:(NSString *)page
                                  pageSize:(NSString *)pageSize
                                       Url:(NSString *)url
                            ViewController:(UIViewController *) target
                                   success:(void(^)(id json)) success
                                   failure:(void(^)(NSError* error))failure;

//众筹详情
+(NSURLSessionDataTask *) getOfferDetailID:(NSString *)apply_id
                            ViewController:(UIViewController *) target
                                   success:(void(^)(id json)) success
                                   failure:(void(^)(NSError* error))failure;

//人员列表
+(NSURLSessionDataTask *) mypersonListViewController:(UIViewController *) target
                                             success:(void(^)(id json)) success
                                             failure:(void(^)(NSError* error))failure;

//删除人员
+(NSURLSessionDataTask *) deletePerson:(NSString *)person_id ViewController:(UIViewController *) target
                               success:(void(^)(id json)) success
                               failure:(void(^)(NSError* error))failure;



//修改人员列表
+(NSURLSessionDataTask *) changePerson:(NSString *)person_id
                                   key:(NSString *)key
                                 vakue:(NSString *)vakue
                        ViewController:(UIViewController *) target
                               success:(void(^)(id json)) success
                               failure:(void(^)(NSError* error))failure;


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
                                failure:(void(^)(NSError* error))failure;


//******************************我的金电子模块**************************//

+(NSURLSessionDataTask *) goodIdea:(NSInteger )type page:(NSInteger)page
                    ViewController:(UIViewController *) target
                           success:(void(^)(id json)) success
                           failure:(void(^)(NSError* error))failure;



////////*********************产品众筹订单**********************///////////////////

+(NSURLSessionDataTask *) crowOrderInfoPage:(NSString *)page
                               order_status:(NSString *)order_status
                             ViewController:(UIViewController *) target
                                    success:(void(^)(id json)) success
                                    failure:(void(^)(NSError* error))failure;



//*******************************我的界面的回忆培训*******************//
+(NSURLSessionDataTask *) buyListPage:(NSString *)page
                             pageSize:(NSString *)pageSize
                                  Url:(NSString *)url
                       ViewController:(UIViewController *) target
                              success:(void(^)(id json)) success
                              failure:(void(^)(NSError* error))failure;



//产品众筹订单详情
+(NSURLSessionDataTask *) crowOrderDetailID:(NSString *)apply_id
                             ViewController:(UIViewController *) target
                                    success:(void(^)(id json)) success
                                    failure:(void(^)(NSError* error))failure;


//提交评价
+(NSURLSessionDataTask *) addDiscussTypeId:(NSString *)is_privated
                           comment_content:(NSString *)comment_content
                              comment_type:(NSString *)comment_type
                               comment_img:(NSArray *)comment_img
                              comment_star:(NSString *)comment_star
                                comment_id:(NSString *)comment_id
                            ViewController:(UIViewController *) target
                                   success:(void(^)(id json)) success
                                   failure:(void(^)(NSError* error))failure;


//支持服务的列表
+(NSURLSessionDataTask *) supportOrders:(NSString *)page
                           order_status:(NSString *)order_status
                         ViewController:(UIViewController *) target
                                success:(void(^)(id json)) success
                                failure:(void(^)(NSError* error))failure;


//支持服务订单详情
+(NSURLSessionDataTask *) supportOrderDetailID:(NSString *)apply_id
                                ViewController:(UIViewController *) target
                                       success:(void(^)(id json)) success
                                       failure:(void(^)(NSError* error))failure;

//会议培训列表
+(NSURLSessionDataTask *) trainOrders:(NSString *)page
                         order_status:(NSString *)order_status
                       ViewController:(UIViewController *) target
                              success:(void(^)(id json)) success
                              failure:(void(^)(NSError* error))failure;
//会议培训列表详情
+(NSURLSessionDataTask *) trainOrderDetailID:(NSString *)apply_id
                              ViewController:(UIViewController *) target
                                     success:(void(^)(id json)) success
                                     failure:(void(^)(NSError* error))failure;


//查看课表
+(NSURLSessionDataTask *) findTimetableID:(NSString *)apply_id
                           ViewController:(UIViewController *) target
                                  success:(void(^)(id json)) success
                                  failure:(void(^)(NSError* error))failure;

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
                              failure:(void(^)(NSError* error))failure;

//服务提议
+(NSURLSessionDataTask *) addPXTypeId:(NSString *)type_id
                           apply_name:(NSString *)apply_name
                           apply_desc:(NSString *)apply_desc
                           apply_type:(NSString *)apply_type
                                 file:(NSArray *)array
                       ViewController:(UIViewController *) target
                              success:(void(^)(id json)) success
                              failure:(void(^)(NSError* error))failure;

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
                                    failure:(void(^)(NSError* error))failure;


//众筹提议学科类别

+(NSURLSessionDataTask *) typeList:(NSString *)apply_id
                    ViewController:(UIViewController *) target
                           success:(void(^)(id json)) success
                           failure:(void(^)(NSError* error))failure;



//我的服务已提议列表
+(NSURLSessionDataTask *) addList:(NSString *)page
                   ViewController:(UIViewController *) target
                          success:(void(^)(id json)) success
                          failure:(void(^)(NSError* error))failure;



/**
 *   读取金币列表
 */
+(NSURLSessionDataTask *) coinListtoViewController:(UIViewController *) target
                                           success:(void(^)(id json)) success
                                           failure:(void(^)(NSError* error))failure;



//反馈建议的弹窗列表
+(NSURLSessionDataTask *) disTypeViewController:(UIViewController *) target
                                        success:(void(^)(id json)) success
                                        failure:(void(^)(NSError* error))failure;

//提交反馈经验
+(NSURLSessionDataTask *) disConfirm:(NSString *)person_id
                            synopsis:(NSString *)synopsis
                         position_id:(NSString *)position_id
                              mobile:(NSString *)mobile
                                file:(NSArray *)file
                      ViewController:(UIViewController *) target
                             success:(void(^)(id json)) success
                             failure:(void(^)(NSError* error))failure;

////历史反馈列表
+(NSURLSessionDataTask *) findComplaintViewController:(UIViewController *) target
                                              success:(void(^)(id json)) success
                                              failure:(void(^)(NSError* error))failure;

//详情 
+(NSURLSessionDataTask *) getComplaint:(NSString *)complaint_id
                        ViewController:(UIViewController *) target
                               success:(void(^)(id json)) success
                               failure:(void(^)(NSError* error))failure;


//反馈的评论
+(NSURLSessionDataTask *) addComment:(NSString *)complaint_id
                                desc:(NSString *)desc
                      ViewController:(UIViewController *) target
                             success:(void(^)(id json)) success
                             failure:(void(^)(NSError* error))failure;

//大比拼
+(NSURLSessionDataTask *) findMyDBPList:(NSString *)page
                                   type:(NSInteger)type
                         ViewController:(UIViewController *) target
                                success:(void(^)(id json)) success
                                failure:(void(^)(NSError* error))failure;

///////////////////////////////////////////////////////////////////
//****************************首页的模块**************************//
//**************************************************************//
//**************************************************************//
//////////////////////////////////////////////////////////////////

#pragma mark - 首页

/**
 *  首页数据
 */
+(NSURLSessionDataTask *)homePageWithParam:(NSDictionary *)param
                      toViewController:(UIViewController *) target
                               success:(void(^)(id json)) success
                               failure:(void(^)(NSError* error))failure;

#pragma mark - 微点资讯
/**
 *  微点资讯
 */
+(NSURLSessionDataTask *)onlyNewsListWithParam:(NSDictionary *)param
                          toViewController:(UIViewController *) target
                                   success:(void(^)(id json)) success
                                   failure:(void(^)(NSError* error))failure;

#pragma mark - 众筹模块
/**
 *  获取众筹列表
 */
+(NSURLSessionDataTask *)listWithParam:(NSDictionary *)param
                      toViewController:(UIViewController *) target
                               success:(void(^)(id json)) success
                               failure:(void(^)(NSError* error))failure;

/**
 *  获取众筹详情
 */
+(NSURLSessionDataTask *)crowdFundDetailWithParam:(NSDictionary *)param
                      toViewController:(UIViewController *) target
                               success:(void(^)(id json)) success
                               failure:(void(^)(NSError* error))failure;


/**
 *  获取筛选列表
 */
+(NSURLSessionDataTask *)filterListWithParam:(NSDictionary *)param
                      toViewController:(UIViewController *) target
                               success:(void(^)(id json)) success
                               failure:(void(^)(NSError* error))failure;

/**
 *  点赞
 */
+(NSURLSessionDataTask *)thumbFundWithParam:(NSDictionary *)param
                           toViewController:(UIViewController *) target
                                    success:(void(^)(id json)) success
                                    failure:(void(^)(NSError* error))failure;

/**
 *  关注
 */
+(NSURLSessionDataTask *)collectFundWithParam:(NSDictionary *)param
                           toViewController:(UIViewController *) target
                                    success:(void(^)(id json)) success
                                    failure:(void(^)(NSError* error))failure;

/**
 *  获取评论列表
 */
+(NSURLSessionDataTask *)commentListWithParam:(NSDictionary *)param
                             toViewController:(UIViewController *) target
                                      success:(void(^)(id json)) success
                                      failure:(void(^)(NSError* error))failure;

#pragma mark - 会议培训模块
/**
 *  获取会议列表
 */
+(NSURLSessionDataTask *)conferenceListWithParam:(NSDictionary *)param
                             toViewController:(UIViewController *) target
                                      success:(void(^)(id json)) success
                                      failure:(void(^)(NSError* error))failure;

/**
 *  获取即将报名会议列表
 */
+(NSURLSessionDataTask *)conferenceSoonEnrollListWithParam:(NSDictionary *)param
                                toViewController:(UIViewController *) target
                                         success:(void(^)(id json)) success
                                         failure:(void(^)(NSError* error))failure;


/**
 *  获取会议详情
 */
+(NSURLSessionDataTask *)conferenceDetailWithParam:(NSDictionary *)param
                                toViewController:(UIViewController *) target
                                         success:(void(^)(id json)) success
                                         failure:(void(^)(NSError* error))failure;

/**
 *  人员列表
 */
+(NSURLSessionDataTask *)peopleListWithParam:(NSDictionary *)param
                                  toViewController:(UIViewController *) target
                                           success:(void(^)(id json)) success
                                           failure:(void(^)(NSError* error))failure;

/**
 *  添加会议培训订单
 */
+(NSURLSessionDataTask *)addConferenceOrderListWithParam:(NSDictionary *)param
                                     toViewController:(UIViewController *) target
                                              success:(void(^)(id json)) success
                                              failure:(void(^)(NSError* error))failure;

/**
 *  会议培训关注
 */
+(NSURLSessionDataTask *)conferenceFollowWithParam:(NSDictionary *)param
                                        toViewController:(UIViewController *) target
                                                 success:(void(^)(id json)) success
                                                 failure:(void(^)(NSError* error))failure;


#pragma mark - 支持服务模块
/**
 *  获取服务列表
 */
+(NSURLSessionDataTask *)serviceListWithParam:(NSDictionary *)param
                             toViewController:(UIViewController *) target
                                      success:(void(^)(id json)) success
                                      failure:(void(^)(NSError* error))failure;

/**
 *  获取服务详情
 */
+(NSURLSessionDataTask *)serviceDetailWithParam:(NSDictionary *)param
                             toViewController:(UIViewController *) target
                                      success:(void(^)(id json)) success
                                      failure:(void(^)(NSError* error))failure;


/**
 *  获取服务人员列表
 */
+(NSURLSessionDataTask *)serviceManListWithParam:(NSDictionary *)param
                                toViewController:(UIViewController *) target
                                         success:(void(^)(id json)) success
                                         failure:(void(^)(NSError* error))failure;


/**
 *  添加服务订单
 */
+(NSURLSessionDataTask *)addServiceOrderListWithParam:(NSDictionary *)param
                                toViewController:(UIViewController *) target
                                         success:(void(^)(id json)) success
                                         failure:(void(^)(NSError* error))failure;

#pragma mark - 大比拼
/**
 *  大比拼列表
 */
+(NSURLSessionDataTask *)competitionListWithParam:(NSDictionary *)param
                           toViewController:(UIViewController *) target
                                    success:(void(^)(id json)) success
                                    failure:(void(^)(NSError* error))failure;

/**
 *  大比拼详情
 */
+(NSURLSessionDataTask *)competitionDetailWithParam:(NSDictionary *)param
                                 toViewController:(UIViewController *) target
                                          success:(void(^)(id json)) success
                                          failure:(void(^)(NSError* error))failure;
/**
 *  大比拼报名
 */
+(NSURLSessionDataTask *)competitionEnrollWithParam:(NSDictionary *)param
                                           fileData:(NSArray *)fileDataArray
                                               name:(NSArray *)nameArray
                                           fileName:(NSArray *)fileNameArray
                                           fileType:(NSArray *)fileTypeArray
                                   toViewController:(UIViewController *) target
                                            success:(void(^)(id json)) success
                                            failure:(void(^)(NSError* error))failure;

/**
 *  大比拼投票人员列表
 */
+(NSURLSessionDataTask *)competitionVoteListWithParam:(NSDictionary *)param
                                   toViewController:(UIViewController *) target
                                            success:(void(^)(id json)) success
                                            failure:(void(^)(NSError* error))failure;

/**
 *  大比拼投票
 */
+(NSURLSessionDataTask *)competitionVoteWithParam:(NSDictionary *)param
                                     toViewController:(UIViewController *) target
                                              success:(void(^)(id json)) success
                                              failure:(void(^)(NSError* error))failure;

/**
 *  大比拼人员详情
 */
+(NSURLSessionDataTask *)competitionCandidateDetailWithParam:(NSDictionary *)param
                                 toViewController:(UIViewController *) target
                                          success:(void(^)(id json)) success
                                          failure:(void(^)(NSError* error))failure;
/**
 *  大比拼结果
 */
+(NSURLSessionDataTask *)competitionResultWithParam:(NSDictionary *)param
                                            toViewController:(UIViewController *) target
                                                     success:(void(^)(id json)) success
                                                     failure:(void(^)(NSError* error))failure;

#pragma mark - 金点子模块
/**
 *  获取金点子列表
 */
+(NSURLSessionDataTask *)ideaListWithParam:(NSDictionary *)param
                             toViewController:(UIViewController *) target
                                      success:(void(^)(id json)) success
                                      failure:(void(^)(NSError* error))failure;

/**
 *  获取金点子详情
 */
+(NSURLSessionDataTask *)ideaDetailWithParam:(NSDictionary *)param
                          toViewController:(UIViewController *) target
                                   success:(void(^)(id json)) success
                                   failure:(void(^)(NSError* error))failure;

/**
 *  金点子排行榜
 */
+(NSURLSessionDataTask *)ideaRankingListWithParam:(NSDictionary *)param
                          toViewController:(UIViewController *) target
                                   success:(void(^)(id json)) success
                                   failure:(void(^)(NSError* error))failure;

/**
 *  金点子点赞
 */
+(NSURLSessionDataTask *)ideaThumbWithParam:(NSDictionary *)param
                                 toViewController:(UIViewController *) target
                                          success:(void(^)(id json)) success
                                          failure:(void(^)(NSError* error))failure;

/**
 *  金点子收藏
 */
+(NSURLSessionDataTask *)ideaCollectWithParam:(NSDictionary *)param
                             toViewController:(UIViewController *) target
                                      success:(void(^)(id json)) success
                                      failure:(void(^)(NSError* error))failure;

#pragma mark - 文件下载
/**
 *  文件列表
 */
+(NSURLSessionDataTask *)downLoadTypeListWithParam:(NSDictionary *)param
                                 toViewController:(UIViewController *) target
                                          success:(void(^)(id json)) success
                                          failure:(void(^)(NSError* error))failure;
#pragma mark - 支付
+(NSURLSessionDataTask *)payWithParam:(NSDictionary *)param
                                  toViewController:(UIViewController *) target
                                           success:(void(^)(id json)) success
                                           failure:(void(^)(NSError* error))failure;

/**
 *  支付宝
 */
+(NSURLSessionDataTask *)aliPayWithParam:(NSDictionary *)param
                        toViewController:(UIViewController *) target
                                 success:(void(^)(id json)) success
                                 failure:(void(^)(NSError* error))failure;

#pragma mark - 购物车

/**
 *  加入购物车
 */
+(NSURLSessionDataTask *)addToCartWithParam:(NSDictionary *)param
                                toViewController:(UIViewController *) target
                                         success:(void(^)(id json)) success
                                         failure:(void(^)(NSError* error))failure;


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
                                       failure:(void(^)(NSError* error))failure;


#pragma mark - 消息模块

/**
 *  查询消息
 */
+(NSURLSessionDataTask *) findNewsType:(NSString *)tiding_type ViewController:(UIViewController *) target success:(void(^)(id json)) success failure:(void(^)(NSError* error))failure;

/**
 *  设置为已读
 */
+(NSURLSessionDataTask *) hasReadedType:(NSString *)tiding_type newsId:(NSString *)newsId ViewController:(UIViewController *) target success:(void(^)(id json)) success failure:(void(^)(NSError* error))failure;

/**
 *  全部设置为已读
 */
+(NSURLSessionDataTask *) NewsAllReadViewController:(UIViewController *) target success:(void(^)(id json)) success failure:(void(^)(NSError* error))failure;

/**
 *  查询未读数量
 */
+(NSURLSessionDataTask *) NewsNotReadViewController:(UIViewController *) target success:(void(^)(id json)) success failure:(void(^)(NSError* error))failure;


//热门搜索
+(NSURLSessionDataTask *) recommend:(NSInteger)type   ViewController:(UIViewController *) target success:(void(^)(id json)) success failure:(void(^)(NSError* error))failure;

//热门搜索历史
+(NSURLSessionDataTask *) historykeyWord:(NSString *)keyword keyType:(NSInteger)keyType ViewController:(UIViewController *) target success:(void(^)(id json)) success failure:(void(^)(NSError* error))failure;

#pragma mark - 市场人员端 对接口  😔😔😔难受
+(NSURLSessionDataTask *) getMarketSupportOrders:(NSString *)page
                                            type:(NSInteger)type
                                  ViewController:(UIViewController *) target
                                         success:(void(^)(id json)) success
                                         failure:(void(^)(NSError* error))failure;

//详情
+(NSURLSessionDataTask *) getMarketSupportDetail:(NSString *)order_sn
                                  ViewController:(UIViewController *) target
                                         success:(void(^)(id json)) success
                                         failure:(void(^)(NSError* error))failure;
//市场人员是否接受支持服务订单
+(NSURLSessionDataTask *) acceptSupportOrder:(NSString *)order_sn
                                  is_receive:(NSString *)is_receive
                              ViewController:(UIViewController *) target
                                     success:(void(^)(id json)) success
                                     failure:(void(^)(NSError* error))failure;

//市场人员结束服务
+(NSURLSessionDataTask *) endSupportOrder:(NSString *)order_sn
                           ViewController:(UIViewController *) target
                                  success:(void(^)(id json)) success
                                  failure:(void(^)(NSError* error))failure;



//市场人员开始服务
+(NSURLSessionDataTask *) beginSupportOrder:(NSString *)order_sn
                             ViewController:(UIViewController *) target
                                    success:(void(^)(id json)) success
                                    failure:(void(^)(NSError* error))failure;

+(NSURLSessionDataTask *) serviceTimes:(NSString *)order_sn
                        ViewController:(UIViewController *) target
                               success:(void(^)(id json)) success
                               failure:(void(^)(NSError* error))failure;

//金币规则
+(NSURLSessionDataTask *) coinRule:(NSString *)order_sn
                    ViewController:(UIViewController *) target
                           success:(void(^)(id json)) success
                           failure:(void(^)(NSError* error))failure;

//文件下载
+(NSURLSessionDataTask *) findMyRecords:(NSString *)order_sn
                         ViewController:(UIViewController *) target
                                success:(void(^)(id json)) success
                                failure:(void(^)(NSError* error))failure;
//文件下载
+(NSURLSessionDataTask *) support:(NSString *)order_sn
                   ViewController:(UIViewController *) target
                          success:(void(^)(id json)) success
                          failure:(void(^)(NSError* error))failure;
@end
