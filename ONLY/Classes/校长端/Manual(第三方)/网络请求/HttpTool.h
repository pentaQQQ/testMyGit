//
//  HttpTool.h
//  OA
//
//  Created by George on 16/10/31.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import <Foundation/Foundation.h>


//#define Choose_Base_URL @"http://192.168.0.48:8091"
//#define Choose_Base_URL @"http://192.168.0.54:835"
//#define Choose_Base_URL @"http://192.168.0.40:8084"

//#define Choose_Base_URL @"http://192.168.0.53:8041"
#define Choose_Base_URL @"http://angliweidian.idea-source.net"

typedef NS_ENUM(NSInteger, RequestType) {
    RequestTypePost      = 1,
    RequestTypeGet       = 2,
    RequestTypeImage     = 3,
};


@interface HttpTool : NSObject


+(instancetype)sharedHttpTool;


//获取 Access_token
+(NSURLSessionDataTask *)getAccessTokenToView:(UIView *)view Complete:(void(^)(BOOL success))completeBlock;



//Post网络请求
+(NSURLSessionDataTask *)PostOutLoading:(NSString *)url params:(NSDictionary *)params toViewController:(UIViewController *)target success:(void(^)(id response))successBlock failure:(void(^)(NSError *error))failureBlock;

+(NSURLSessionDataTask *)PostWithLoading:(NSString *)url params:(NSDictionary *)params toViewController:(UIViewController *)target loadString:(NSString *)str success:(void(^)(id response))successBlock failure:(void(^)(NSError *error))failureBlock;

//Get 网络请求
+(NSURLSessionDataTask *)GetWithLoading:(NSString *)url params:(NSDictionary *)params toViewController:(UIViewController *)target success:(void(^)(id response))successBlock failure:(void(^)(NSError *error))failureBlock;

//单张图片资源上传
+(NSURLSessionDataTask *)Upload:(NSString *)url params:(NSDictionary *)params file:(NSData *)data toViewController:(UIViewController *)target loadString:(NSString *)str success:(void(^)(id response))successBlock failure:(void(^)(NSError *error))failureBlock;


//多张图片
+(NSURLSessionDataTask *)UploadManyImg:(NSString *)url params:(NSDictionary *)params file:(NSArray *)array toViewController:(UIViewController *)target loadString:(NSString *)str success:(void(^)(id response))successBlock failure:(void(^)(NSError *error))failureBlock;


//上传图片和视频资源
+(NSURLSessionDataTask *)UploadMediaSource:(NSString *)url params:(NSDictionary *)params fileData:(NSArray *)fileDataArray name:(NSArray*)nameArray fileName:(NSArray *)fileNameArray fileTypeName:(NSArray *)fileTypeArray toViewController:(UIViewController *)target loadString:(NSString *)str success:(void(^)(id response))successBlock failure:(void(^)(NSError *error))failureBlock;


@end









