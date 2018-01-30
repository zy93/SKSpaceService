//
//  WOTHTTPNetwork.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/4.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTHTTPNetwork.h"
#import "header.h"
#import "SKLoginModel.h"
#import "SKOrderInfoModel.h"
#import "SKAcceptAnOrderModel.h"

#define kMaxRequestCount 3
@interface WOTHTTPNetwork()

@property(nonatomic,assign)NSInteger requestcount;

@end
@implementation WOTHTTPNetwork
-(instancetype)init{
    self = [super init];
    if (self) {
        _requestcount = 0;
    }
    return self;
}



//登录
+(void)userLoginWithTelOrEmail:(NSString *)telOrEmail password:(NSString *)pwd alias:(NSString *)alias success:(success)success fail:(fail)fail
{
    NSDictionary *dic = @{@"tel" :telOrEmail,
                          @"password":[WOTUitls md5HexDigestByString:pwd],
                          @"alias":alias
                          };
    NSString * string = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/Staff/Login"];
    
    [WOTHTTPNetRequest doRequestWithParameters:dic useUrl:string complete:^WOTBaseModel *(id responseDic) {
        SKLoginModel_msg *model = [[SKLoginModel_msg alloc] initWithDictionary:responseDic error:nil];
        return model;
    } success:success fail:fail];
}

//查询报修订单
+(void)queryRepairsOrderWithSpaceList:(NSString *)spaceList statuscode:(NSString *)statuscode pickUpUserID:(NSNumber *)pickUpUserID success:(success)success fail:(fail)fail;
{
    
    NSMutableDictionary *dic = [@{@"spaceList" :spaceList,
                          @"statuscode":statuscode
                          }mutableCopy];
    
    if (![pickUpUserID isEqualToNumber:@0]) {
        [dic setValue:pickUpUserID forKey:@"pickUpUserID"];
    }
    NSString * string = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/MaintainInfo/findBySpaceListId"];
    
    [WOTHTTPNetRequest doRequestWithParameters:dic useUrl:string complete:^WOTBaseModel *(id responseDic) {
        SKOrderInfoModel_result *model = [[SKOrderInfoModel_result alloc] initWithDictionary:responseDic error:nil];
        return model;
    } success:success fail:fail];
}

//接受订单
+(void)acceptAnOrderWithUserName:(NSString *)username infoId:(NSNumber *)infoId pickUpUserID:(NSNumber *)pickUpUserID success:(success)success fail:(fail)fail;
{
    NSDictionary *dic = @{@"username" :username,
                          @"infoId":infoId,
                          @"pickUpUserID":pickUpUserID
                          };
    NSString * string = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/MaintainInfo/order"];
    
    [WOTHTTPNetRequest doRequestWithParameters:dic useUrl:string complete:^WOTBaseModel *(id responseDic) {
        SKAcceptAnOrderModel *model = [[SKAcceptAnOrderModel alloc] initWithDictionary:responseDic error:nil];
        return model;
    } success:success fail:fail];
}


@end
