//
//  WOTHTTPNetRequest.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/11.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "WOTBaseModel.h"

typedef void(^success)(id bean);
typedef void(^fail)(NSInteger errorCode, NSString *errorMessage);
typedef WOTBaseModel *(^complete)(id responseDic);


@interface WOTHTTPNetRequest : NSObject
//网络请求
+(void)doRequestWithParameters:(NSDictionary *)parameters
                        useUrl:(NSString *)Url
                      complete:(complete)complete
                       success:(success)success
                          fail:(fail)fail;




+(void)doFileRequestWithParameters:(NSDictionary *)parameters
                            useUrl:(NSString *)Url
                             image:(NSArray<UIImage *> *)images
                          complete:(complete)complete
                           success:(success)success
                              fail:(fail)fail;







@end
