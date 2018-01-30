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
#import "WOTSpaceModel.h"
#import "SKBaseResponseModel.h"
#import "SKSalesOrderModel.h"
#import "SKSalesOrderLogModel.h"

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


#pragma mark - 用户
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
#pragma mark - 获取所有的空间列表
+(void)getSapaceFromGroupBlockSuccess:(success)success fail:(fail)fail
{
    [WOTHTTPNetwork getSapaceWithPage:@1 pageSize:@1000 success:success fail:fail];
}

+(void)getSapaceWithPage:(NSNumber *)page pageSize:(NSNumber *)pageSize success:(success)success fail:(fail)fail
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/Space/find"];
    NSDictionary *parameters = @{@"pageNo":page,
                                 @"pageSize":pageSize
                                 };
    [WOTHTTPNetRequest doRequestWithParameters:parameters useUrl:urlstring complete:^WOTBaseModel *(id responseDic) {
        WOTSpaceModel_msg * spacemodel = [[WOTSpaceModel_msg alloc]initWithDictionary:responseDic error:nil];
        return  spacemodel;
    } success:success fail:fail];
}

#pragma mark - 销售
+(void)addSalesOrderWithParam:(NSDictionary *)parameters success:(success)success fail:(fail)fail
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/Sell/addSell"];
    [WOTHTTPNetRequest doRequestWithParameters:parameters useUrl:urlstring complete:^WOTBaseModel *(id responseDic) {
        SKBaseResponseModel * spacemodel = [[SKBaseResponseModel alloc]initWithDictionary:responseDic error:nil];
        return  spacemodel;
    } success:success fail:fail];
}

+(void)getSalesOrderWithState:(NSString *)state success:(success)success fail:(fail)fail
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/Sell/find"];
    NSMutableDictionary *parameters = [@{@"pageNo":@(1),
                                         @"pageSize":@(10000),
                                         @"userId":[WOTUserSingleton shared].userInfo.staffId,
                                         } mutableCopy];
    if (!strIsEmpty(state)) {
        [parameters setValue:state forKey:@"stage"];
    }
    [WOTHTTPNetRequest doRequestWithParameters:parameters useUrl:urlstring complete:^WOTBaseModel *(id responseDic) {
        SKSalesOrder_msg * spacemodel = [[SKSalesOrder_msg alloc]initWithDictionary:responseDic error:nil];
        return  spacemodel;
    } success:success fail:fail];
}

+(void)updateSalesOrderInfoWithParam:(NSDictionary *)parameters success:(success)success fail:(fail)fail
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/Sell/addSell"];
    [WOTHTTPNetRequest doRequestWithParameters:parameters useUrl:urlstring complete:^WOTBaseModel *(id responseDic) {
        SKBaseResponseModel * spacemodel = [[SKBaseResponseModel alloc]initWithDictionary:responseDic error:nil];
        return  spacemodel;
    } success:success fail:fail];
}


#pragma mark - 销售日志
+(void)addSalesOrderLogWithParam:(NSDictionary *)parameters success:(success)success fail:(fail)fail
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/SellLog/addSellLog"];
    [WOTHTTPNetRequest doRequestWithParameters:parameters useUrl:urlstring complete:^WOTBaseModel *(id responseDic) {
        SKBaseResponseModel * spacemodel = [[SKBaseResponseModel alloc]initWithDictionary:responseDic error:nil];
        return  spacemodel;
    } success:success fail:fail];
}

+(void)getSalesOrderLogWithSellId:(NSNumber *)sellId success:(success)success fail:(fail)fail
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/SellLog/find"];
    NSDictionary *parameters = @{@"pageNo":@(1),
                                 @"pageSize":@(1000),
                                 @"sellId":sellId,
                                 };
    [WOTHTTPNetRequest doRequestWithParameters:parameters useUrl:urlstring complete:^WOTBaseModel *(id responseDic) {
        SKSalesOrderLog_msg * spacemodel = [[SKSalesOrderLog_msg alloc] initWithDictionary:responseDic error:nil];
        return  spacemodel;
    } success:success fail:fail];
}

#pragma mark - 销售问题
+(void)getSalesOrderQuestionSuccess:(success)success fail:(fail)fail
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/Sell/addSell"];
//    NSDictionary *parameters = @{@"pageNo":@(1),
//                                 @"pageSize":@(1000),
//                                 @"sellId":sellId,
//                                 };
//    [WOTHTTPNetRequest doRequestWithParameters:parameters useUrl:urlstring complete:^WOTBaseModel *(id responseDic) {
//        SKBaseResponseModel * spacemodel = [[SKBaseResponseModel alloc]initWithDictionary:responseDic error:nil];
//        return  spacemodel;
//    } success:success fail:fail];
}

@end
