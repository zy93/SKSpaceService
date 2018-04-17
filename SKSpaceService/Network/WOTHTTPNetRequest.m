//
//  WOTHTTPNetRequest.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/11.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTHTTPNetRequest.h"

#define kMaxRequestCount 3
@interface WOTHTTPNetRequest()

@end


@implementation WOTHTTPNetRequest


//网络请求
+(void)doRequestWithParameters:(NSDictionary *)parameters
                        useUrl:(NSString *)Url
                      complete:(complete)complete
                       success:(success)success
                          fail:(fail)fail
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", nil];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         @"text/plain",nil];
    
    manager.requestSerializer=[AFJSONRequestSerializer serializer];
    //manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithArray:@[@"POST", @"GET", @"HEAD"]];
    
    [manager POST:Url parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"**********request URL:%@",task.originalRequest.URL.absoluteString);
//        NSString *responseStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
////        NSLog(@"**********responseStr:%@",responseStr);
//        NSError *error = nil;
//        NSData *jsonData = [responseStr dataUsingEncoding:NSUTF8StringEncoding];
//        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        
        WOTBaseModel *model = complete(responseObject);
        if ([model.code isEqualToString:@"200"]) {
            if (success) {
                success(model);
            }
        }
        else {
            if (fail) {
                NSLog(@"********** request url: %@ error: %@",model.code,model.result);
                fail(model.code.integerValue,model.result);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"********** request url: %@ error: %@",task.originalRequest.URL.absoluteString,error.userInfo[NSLocalizedDescriptionKey]);
        if (fail) {
            fail(error.code,error.description);
        }
    }];
}


+(NSDictionary*)paramEncoding:(NSDictionary*)parameters{
    NSMutableDictionary *mutaDic = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    for (NSString *key in [mutaDic allKeys]) {
        NSString * strEncoding= [mutaDic[key] UrlEncodedString];
        mutaDic[key] = strEncoding;
    }
    return mutaDic;
}

//上传文件网络请求
+(void)doFileRequestWithParameters:(NSDictionary *)parameters
                            useUrl:(NSString *)Url
                             image:(NSArray<UIImage *> *)images
                          complete:(complete)complete
                           success:(success)success
                              fail:(fail)fail
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [manager.requestSerializer setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"image/jpeg",@"image/png",@"application/octet-stream",@"text/json",nil];
    manager.requestSerializer= [AFHTTPRequestSerializer serializer];
    manager.responseSerializer= [AFHTTPResponseSerializer serializer];
    [manager POST:Url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //
        //        NSData *data = UIImagePNGRepresentation(images[0]);
        //
        //        //上传的参数(上传图片，以文件流的格式)
        //        [formData appendPartWithFileData:data
        //
        //                                    name:@"file"
        //
        //                                fileName:@"gauge.png"
        //                                mimeType:@"image/png"];
        //
        int i = 0;
        //根据当前系统时间生成图片名称
        NSDate *date = [NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        [formatter setDateFormat:@"yyyy年MM月dd日"];
        NSString *dateString = [formatter stringFromDate:date];
        
        for (UIImage *image in images) {
            NSString *fileName = [NSString stringWithFormat:@"%@%d.png",dateString,i];
            NSData *imageData;
            
            imageData = UIImageJPEGRepresentation(image, 1.0f);
            
            imageData = UIImageJPEGRepresentation(image,1.f);
            if (!imageData) {
                imageData = UIImagePNGRepresentation(image);
            }
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
            
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"request URL:%@",task.originalRequest.URL.absoluteString);
        NSString *responseStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"responseStr:%@",responseStr);
        NSError *error = nil;
        NSData *jsonData = [responseStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *responseDic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
        
        WOTBaseModel *model = complete(responseDic);
        if ([model.code isEqualToString:@"200"]) {
            if (success) {
                success(model);
            }
        }
        else {
            if (fail) {
                NSLog(@"********** request url: %@ error: %@",model.code,model.result);
                fail(model.code.integerValue,model.result);
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"********** request url: %@ error: %@",task.originalRequest.URL.absoluteString,error.userInfo[NSLocalizedDescriptionKey]);
        if (fail) {
            fail(error.code,error.description);
        }
    }];
}
@end
