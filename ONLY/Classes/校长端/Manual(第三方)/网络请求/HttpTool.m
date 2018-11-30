//
//  HttpTool.m
//  OA
//
//  Created by George on 16/10/31.
//  Copyright © 2016年 虞嘉伟. All rights reserved.
//

#import "HttpTool.h"
#import "MBProgressHUD+Extension.h"
//#import "MBProgressHUD+HUD.h"
//#import "MBProgressHUD.h"

@interface HttpTool()
@property (nonatomic,strong)AFHTTPSessionManager * manager;
@end

@implementation HttpTool

+ (instancetype)sharedHttpTool {
    static HttpTool * sharedHttpTool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHttpTool = [[HttpTool alloc]init];
    });
    
    return sharedHttpTool;
}

+(NSURLSessionDataTask *)getAccessTokenToView:(UIView *)view Complete:(void(^)(BOOL success))completeBlock {
    
    HttpTool *tool = [HttpTool sharedHttpTool];
    NSDictionary *params =@{@"grant_type":@"client_credentials",
                            @"client_id":@"746cabae9cfc3dc5f8ebc967f0ad92b0",
                            @"client_secret":@"f6dafa0490ea3309b3002239f3943e461898e6f2",
                            @"redirect_uri" : @"http://angliweidian.idea-source.net"};
    return [tool requestWithType:RequestTypePost url:@"/oauth2/token" params:params file:nil toView:view loading:NO loadString:nil success:^(id response) {
        
        if (response[@"access_token"]) {
            USERINFO.accessToken = response[@"access_token"];  //存储access_token
            completeBlock(YES);
        } else {
            completeBlock(NO);
        }
        NSLog(@"\naccessToken:%@\n", response[@"access_token"]);
        
    } failure:^(NSError *error) {
        NSLog(@"error:%@", error);
    }];
}

//Post网络请求
+(NSURLSessionDataTask *)PostOutLoading:(NSString *)url params:(NSDictionary *)params toViewController:(UIViewController *)target success:(void(^)(id response))successBlock failure:(void(^)(NSError *error))failureBlock {
    return [[HttpTool sharedHttpTool]requestWithType:RequestTypePost url:url params:params file:nil toView:target.view loading:NO loadString:nil success:successBlock failure:failureBlock];
}
+(NSURLSessionDataTask *)PostWithLoading:(NSString *)url params:(NSDictionary *)params toViewController:(UIViewController *)target loadString:(NSString *)str success:(void(^)(id response))successBlock failure:(void(^)(NSError *error))failureBlock {
    return [[HttpTool sharedHttpTool] requestWithType:RequestTypePost url:url params:params file:nil toView:target.view loading:YES loadString:str success:successBlock failure:failureBlock];
}

//图片资源上传
+(NSURLSessionDataTask *)Upload:(NSString *)url params:(NSDictionary *)params file:(NSData *)data toViewController:(UIViewController *)target loadString:(NSString *)str success:(void(^)(id response))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    return [[HttpTool sharedHttpTool] requestWithType:RequestTypeImage url:url params:params file:data toView:target.view loading:YES loadString:str success:successBlock failure:failureBlock];
}

//多张图片
+(NSURLSessionDataTask *)UploadManyImg:(NSString *)url params:(NSDictionary *)params file:(NSArray *)array toViewController:(UIViewController *)target loadString:(NSString *)str success:(void(^)(id response))successBlock failure:(void(^)(NSError *error))failureBlock
{
  return [[HttpTool sharedHttpTool] requestWithImg:RequestTypeImage url:url params:params file:array toView:target.view loading:YES loadString:str success:successBlock failure:failureBlock];

}

//yong jiang  don't touch  
+(NSURLSessionDataTask *)UploadMediaSource:(NSString *)url params:(NSDictionary *)params fileData:(NSArray *)fileDataArray name:(NSArray*)nameArray fileName:(NSArray *)fileNameArray fileTypeName:(NSArray *)fileTypeNameArray toViewController:(UIViewController *)target loadString:(NSString *)str success:(void(^)(id response))successBlock failure:(void(^)(NSError *error))failureBlock
{
  return [[HttpTool sharedHttpTool] requestWithImgAndMedia:RequestTypeImage url:url params:params fileData:fileDataArray name:nameArray fileName:fileNameArray fileTypeName:fileTypeNameArray toView:target.view loading:YES loadString:str success:successBlock failure:failureBlock];

}

//get请求
+(NSURLSessionDataTask *)GetWithLoading:(NSString *)url params:(NSDictionary *)params toViewController:(UIViewController *)target success:(void(^)(id response))successBlock failure:(void(^)(NSError *error))failureBlock
{
   return [[HttpTool sharedHttpTool]requestWithType:RequestTypeGet url:url params:params file:nil toView:target.view loading:NO loadString:nil success:successBlock failure:failureBlock];

}


#pragma mark - 私有方法 不许改动
-(NSURLSessionDataTask *)requestWithType:(RequestType)type url:(NSString *)url params:(NSDictionary *)params file:(NSData *)data toView:(UIView *)view loading:(BOOL)loading  loadString:(NSString *)str success:(void(^)(id response))successBlock failure:(void(^)(NSError *error))failureBlock {
    kWeakSelf(self);
    AFHTTPSessionManager *manager = [weakself Manager];
    
    NSAssert(url || url.length > 0, @"URL路径不能为空");
    
    NSString *requestUrl = @""; //全路径
    
    if (USERINFO.accessToken.length > 0 ) {
        requestUrl = [NSString stringWithFormat:@"%@%@?access_token=%@", Choose_Base_URL, url, USERINFO.accessToken];
    }
    else {
        requestUrl = [NSString stringWithFormat:@"%@%@", Choose_Base_URL, url];
    }
    
    //[self showLoadingAnimation:loading];
    [weakself showLoadingToView:view animation:loading];
    
    NSLog(@"请求路径:\n%@", requestUrl);
    NSLog(@"请求参数:\n%@", params);
    
    switch (type) {
        case RequestTypeGet: {
            return [weakself.manager GET:requestUrl parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
                
                //这里可以获取到目前数据请求的进度
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                if (successBlock) {
                    
                    successBlock(responseObject);
                }
                [weakself dismissLoadingAnimation:loading];
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                if (failureBlock) {
                    failureBlock(error);
                }
                [weakself dismissLoadingAnimation:loading];
                
            }];
            
       
            break;
        }
        case RequestTypePost: {
            
            return [weakself.manager POST:requestUrl parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
                
                //这里可以获取到目前数据请求的进度
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                //状态栏上的菊花停掉
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                
                //access_token过期的情况下，会重新请求一次access_token
                if ([responseObject[@"errcode"] intValue] == 10002) {
                    [HttpTool getAccessTokenToView:view Complete:^(BOOL success) {
                        
                        [weakself requestWithType:type url:url params:params file:data toView:view loading:loading loadString:str success:successBlock failure:failureBlock];
                        
                    }];
                }
                else if ([responseObject[@"errcode"] intValue] != 0) {
                    [MBProgressHUD showFailure:responseObject[@"errmsg"] toView:view complete:^{
                        if (successBlock) {
                            successBlock(responseObject);
                        }
                    }];
                }
                else {
                    NSLog(@"响应参数:\n%@", responseObject);
                    
                    [MBProgressHUD hideHUDForView:view animated:NO];
                    if (str.length > 0) {
                        
                        NSString *success = [NSString stringWithFormat:@"%@成功", str];
                        [MBProgressHUD showSuccess:success toView:view complete:^{
                            
                            if (successBlock) {
                                
                                successBlock(responseObject);
                            }
                        }];
                    }
                    else {
                        if (successBlock) {
                            
                            successBlock(responseObject);
                        }
                    }
                    
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

                //状态栏上的菊花停掉
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                
                //不是通过取消网络请求而引发的error都要回调
                if (![error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"cancelled"]) {
                    
                    //请求超时的时候提示框;
                    if (error.code == -1001) {
                        
                        [MBProgressHUD showFailure:@"请求超时" toView:view complete:^{
                            if (failureBlock) {
                                failureBlock(error);
                            }
                        }];
                        
                    }
                    else {
                        if (str.length > 0) {
                            NSString *failure = [NSString stringWithFormat:@"%@失败", str];
                            [MBProgressHUD showFailure:failure toView:view complete:^{
                                if (failureBlock) {
                                    failureBlock(error);
                                }
                            }];
                        }
                        else {
                            [MBProgressHUD showFailure:@"请求错误" toView:view complete:^{
                                if (failureBlock) {
                                    failureBlock(error);
                                }
                            }];
                        }
                        
                    }
                }
                
            }];
            
            break;
        }
        case RequestTypeImage: {
            
            return [weakself.manager POST:requestUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                
                NSAssert(data, @"头像数据不能为空");
                
                [formData appendPartWithFileData:data name:@"portrail" fileName:@"portrail.jpg" mimeType:@"image.jpeg"];
                
            } progress:^(NSProgress * _Nonnull uploadProgress) {
                
                //这里可以获取到目前数据请求的进度
                
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                //状态栏上的菊花停掉
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                
                //access_token过期的情况下，会重新请求一次access_token
                if ([responseObject[@"errcode"] intValue] == 10002) {
                    [HttpTool getAccessTokenToView:view Complete:^(BOOL success) {
                        
                        [weakself requestWithType:type url:url params:params file:data toView:view loading:loading loadString:str success:successBlock failure:failureBlock];
                        
                    }];
                    
                }
                else {
                    NSLog(@"响应参数:\n%@", responseObject);
                    if (loading) {
                        NSString *success = [NSString stringWithFormat:@"%@成功", str];
                        [MBProgressHUD showSuccess:success toView:view complete:^{
                            if (successBlock) {
                                
                                successBlock(responseObject);
                            }
                        }];
                    }
                    else {
                        if (successBlock) {
                            
                            successBlock(responseObject);
                        }
                    }
                    
                }
                
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                //状态栏上的菊花停掉
                [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
                
                //不是通过取消网络请求而引发的error都要回调
                if (![error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"cancelled"]) {
                    
                    //请求超时的时候提示框;
                    if (error.code == -1001) {
                        
                        [MBProgressHUD showFailure:@"请求超时" toView:view complete:^{
                            if (failureBlock) {
                                failureBlock(error);
                            }
                        }];
                    }
                    else {
                        
                        if (loading) {
                            NSString *failure = [NSString stringWithFormat:@"%@错误", str];
                            [MBProgressHUD showFailure:failure toView:view complete:^{
                                if (failureBlock) {
                                    failureBlock(error);
                                }
                            }];
                        }
                        else {
                            if (failureBlock) {
                                failureBlock(error);
                            }
                        }
                    }
                }
            }];
            
            break;
        }
        default:
            break;
    }
    //    return manager;
}

-(NSURLSessionDataTask *)requestWithImg:(RequestType)type url:(NSString *)url params:(NSDictionary *)params file:(NSArray *)dataArray toView:(UIView *)view loading:(BOOL)loading  loadString:(NSString *)str success:(void(^)(id response))successBlock failure:(void(^)(NSError *error))failureBlock
{
    kWeakSelf(self);
    AFHTTPSessionManager *manager = [weakself Manager];
    
    NSAssert(url || url.length > 0, @"URL路径不能为空");
    
    NSString *requestUrl = @""; //全路径
    
    if (USERINFO.accessToken.length > 0 ) {
        requestUrl = [NSString stringWithFormat:@"%@%@?access_token=%@", Choose_Base_URL, url, USERINFO.accessToken];
    }
    else {
        requestUrl = [NSString stringWithFormat:@"%@%@", Choose_Base_URL, url];
    }
    
    //[self showLoadingAnimation:loading];
    [weakself showLoadingToView:view animation:loading];
    
    NSLog(@"请求路径:\n%@", requestUrl);
    NSLog(@"请求参数:\n%@", params);

    return [weakself.manager POST:requestUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
          NSAssert(dataArray, @"头像数据不能为空");
//        [formData appendPartWithFileData:data name:@"portrail" fileName:@"portrail.jpg" mimeType:@"image.jpeg"];
        NSInteger i = 0;
        for (NSData *data in dataArray) {
            if (data) {
                i++;
                NSString *imageName = [@"image_" stringByAppendingString:[@(i) stringValue]];
                [formData appendPartWithFileData:data name:imageName fileName:@"image.jpg" mimeType:@"image/jpeg"];
            }
        }

        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //这里可以获取到目前数据请求的进度
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //状态栏上的菊花停掉
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        //access_token过期的情况下，会重新请求一次access_token
        if ([responseObject[@"errcode"] intValue] == 10002) {
            [HttpTool getAccessTokenToView:view Complete:^(BOOL success) {
                
                [weakself requestWithImg:type url:url params:params file:dataArray toView:view loading:loading loadString:str success:successBlock failure:failureBlock];
                
            }];
            
        }
        else {
            NSLog(@"响应参数:\n%@", responseObject);
            if (loading) {
                NSString *success = [NSString stringWithFormat:@"%@成功", str];
                [MBProgressHUD showSuccess:success toView:view complete:^{
                    if (successBlock) {
                        
                        successBlock(responseObject);
                    }
                }];
            }
            else {
                if (successBlock) {
                    
                    successBlock(responseObject);
                }
            }
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //状态栏上的菊花停掉
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        //不是通过取消网络请求而引发的error都要回调
        if (![error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"cancelled"]) {
            
            //请求超时的时候提示框;
            if (error.code == -1001) {
                
                [MBProgressHUD showFailure:@"请求超时" toView:view complete:^{
                    if (failureBlock) {
                        failureBlock(error);
                    }
                }];
            }
            else {
                
                if (loading) {
                    NSString *failure = [NSString stringWithFormat:@"%@错误", str];
                    [MBProgressHUD showFailure:failure toView:view complete:^{
                        if (failureBlock) {
                            failureBlock(error);
                        }
                    }];
                }
                else {
                    if (failureBlock) {
                        failureBlock(error);
                    }
                }
            }
        }
    }];

}



////视频  图片
-(NSURLSessionDataTask *)requestWithImgAndMedia:(RequestType)type url:(NSString *)url params:(NSDictionary *)params fileData:(NSArray *)fileDataArray name:(NSArray*)nameArray fileName:(NSArray *)fileNameArray  fileTypeName:(NSArray *)fileTypeNameArray toView:(UIView *)view loading:(BOOL)loading  loadString:(NSString *)str success:(void(^)(id response))successBlock failure:(void(^)(NSError *error))failureBlock
{
    kWeakSelf(self);
   // AFHTTPSessionManager *manager = [weakself Manager];
    
    NSAssert(url || url.length > 0, @"URL路径不能为空");
    
    NSString *requestUrl = @""; //全路径
    
    if (USERINFO.accessToken.length > 0 ) {
        requestUrl = [NSString stringWithFormat:@"%@%@?access_token=%@", Choose_Base_URL, url, USERINFO.accessToken];
    }
    else {
        requestUrl = [NSString stringWithFormat:@"%@%@", Choose_Base_URL, url];
    }
    
    //[self showLoadingAnimation:loading];
    [weakself showLoadingToView:view animation:loading];
    
    NSLog(@"请求路径:\n%@", requestUrl);
    NSLog(@"请求参数:\n%@", params);
    
    return [weakself.manager POST:requestUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        NSAssert(fileDataArray, @"头像数据不能为空");
        //        [formData appendPartWithFileData:data name:@"portrail" fileName:@"portrail.jpg" mimeType:@"image.jpeg"];
        NSInteger i = 0;
        for (NSData *data in fileDataArray) {
            if (data) {
                NSString *name = nameArray[i];
                NSString *fileName = fileNameArray[i];
                NSString *typeName = fileTypeNameArray[i];
                [formData appendPartWithFileData:data name:name fileName:fileName mimeType:typeName];
                i++;
            }
        }
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //这里可以获取到目前数据请求的进度
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //状态栏上的菊花停掉
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        //access_token过期的情况下，会重新请求一次access_token
        if ([responseObject[@"errcode"] intValue] == 10002) {
            [HttpTool getAccessTokenToView:view Complete:^(BOOL success) {
                
                [weakself requestWithImg:type url:url params:params file:fileDataArray toView:view loading:loading loadString:str success:successBlock failure:failureBlock];
                
            }];
            
        }else if ([responseObject[@"errcode"] intValue] != 0){
            [MBProgressHUD showFailure:responseObject[@"errmsg"] toView:view complete:^{
                if (successBlock) {
                    successBlock(responseObject);
                }
            }];
        }
        else {
            NSLog(@"响应参数:\n%@", responseObject);
            if (loading) {
                NSString *success = [NSString stringWithFormat:@"%@成功", str];
                [MBProgressHUD showSuccess:success toView:view complete:^{
                    if (successBlock) {
                        
                        successBlock(responseObject);
                    }
                }];
            }
            else {
                if (successBlock) {
                    
                    successBlock(responseObject);
                }
            }
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //状态栏上的菊花停掉
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        
        //不是通过取消网络请求而引发的error都要回调
        if (![error.userInfo[@"NSLocalizedDescription"] isEqualToString:@"cancelled"]) {
            
            //请求超时的时候提示框;
            if (error.code == -1001) {
    
                [MBProgressHUD showFailure:@"请求超时" toView:view complete:^{
                    if (failureBlock) {
                        failureBlock(error);
                    }
                }];
            }
            else {
              
                if (loading) {
                    NSString *failure = [NSString stringWithFormat:@"%@错误", str];
                    [MBProgressHUD showFailure:failure toView:view complete:^{
                        if (failureBlock) {
                            failureBlock(error);
                        }
                    }];
                }
                else {
                    if (failureBlock) {
                        failureBlock(error);
                    }
                }
            }
        }
    }];
    
}


-(AFHTTPSessionManager *)Manager {
    
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        // 超时时间
        _manager.requestSerializer.timeoutInterval = 6;
        
        // 声明上传的是json格式的参数，需要你和后台约定好，不然会出现后台无法获取到你上传的参数问题
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
        //    manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传JSON格式
        
        // 声明获取到的数据格式
        //    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
        _manager.responseSerializer = [AFJSONResponseSerializer serializer]; // AFN会JSON解析返回的数据
        // 个人建议还是自己解析的比较好，有时接口返回的数据不合格会报3840错误，大致是AFN无法解析返回来的数据
        
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/plain", @"application/json", nil];

    }
    

    return _manager;
}

#pragma mark - 显示加载动画

-(void)showLoadingToView:(UIView *)view animation:(BOOL)animation {
    if (animation) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
        [MBProgressHUD showLoadingToView:view];
    }
}

#pragma mark - 隐藏加载动画
-(void)dismissLoadingAnimation:(BOOL)loading {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [SVProgressHUD dismiss];
    });
}

















-(NSURLSessionTask *)postUrl:(NSString *)urlString params:(NSDictionary *)params InView:(UIView *)view show:(BOOL)flag success:(void(^)(id response))successBlock failure:(void(^)(NSError *error))failureBlock {
    
    // 1、创建URL资源地址
    NSURL *url = [NSURL URLWithString:urlString];
    // 2、创建Reuest请求
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // 3、配置Request
    request.timeoutInterval = 10.0;
    request.HTTPMethod = @"POST";
    // 4、构造请求参数
    // 4.1、创建字典参数，将参数放入字典中，可防止程序员在主观意识上犯错误，即参数写错。
    NSDictionary *parametersDict = @{@"key":@"value"};
    // 4.2、遍历字典，以“key=value&”的方式创建参数字符串。
    NSMutableString *parameterString = [NSMutableString string];
    
    for (NSString *key in parametersDict.allKeys) {
        // 拼接字符串
        [parameterString appendFormat:@"%@=%@&", key, parametersDict[key]];
    }
    // 4.3、截取参数字符串，去掉最后一个“&”，并且将其转成NSData数据类型。
    NSData *parametersData = [[parameterString substringToIndex:parameterString.length - 1] dataUsingEncoding:NSUTF8StringEncoding];
    
    // 5、设置请求报文
    request.HTTPBody = parametersData;
    // 6、构造NSURLSessionConfiguration
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    // 7、创建网络会话
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
    // 8、创建会话任务
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // 10、判断是否请求成功
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            if (failureBlock) {
                failureBlock(error);
            }
        } else {
            // 如果请求成功，则解析数据。
            id object = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
            // 11、判断是否解析成功
            if (error) {
                NSLog(@"%@", error.localizedDescription);
                if (failureBlock) {
                    failureBlock(error);
                }
            }else {
                // 解析成功，处理数据，通过GCD获取主队列，在主线程中刷新界面。
                NSLog(@"%@", object);
                dispatch_async(dispatch_get_main_queue(), ^{
                    // 刷新界面...
                    if (successBlock) {
                        successBlock(object);
                    }
                });
            }
        }
    }];
    // 9、执行任务
    [task resume];
    
    return task;
    
    
}

-(void)showLoadingInView:(UIView *)view {
    UILabel *label = [UILabel new];
    label.text = @"这是一个指示器";
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeDeterminate;
//    hud.label = label;
}


@end
