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
#import "WOTSpaceModel.h"
#import "SKBaseResponseModel.h"
#import "SKSalesOrderModel.h"
#import "SKSalesOrderLogModel.h"
#import "SKQuestionModel.h"
#import "SKDemandModel.h"
#import "SKDemandeLogModel.h"
#import "WOTGetVerifyModel.h"
#import "WOTWorkStationHistoryModel.h"

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

+(void)updateUserInfoUserId:(NSNumber *)userId success:(success)success fail:(fail)fail
{
    NSDictionary *dic = @{@"staffId" :userId,
                          };
    NSString * string = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/Staff/findById"];
    
    [WOTHTTPNetRequest doRequestWithParameters:dic useUrl:string complete:^WOTBaseModel *(id responseDic) {
        SKLoginModel_msg *model = [[SKLoginModel_msg alloc] initWithDictionary:responseDic error:nil];
        return model;
    } success:success fail:fail];
}

+(void)userGetVerifyWitTel:(NSString *)tel success:(success)success fail:(fail)fail
{
    NSDictionary *dic = @{@"tel" :tel};
    NSString * string = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/User/sendVerify"];
    [WOTHTTPNetRequest doRequestWithParameters:dic useUrl:string complete:^WOTBaseModel *(id responseDic) {
        WOTGetVerifyModel *model = [[WOTGetVerifyModel alloc] initWithDictionary:responseDic error:nil];
        return model;
    } success:success fail:fail];
}

+(void)sendMessageWithUserId:(NSNumber *)userId type:(NSString *)type summary:(NSString*)summary success:(success)success fail:(fail)fail
{
    NSDictionary *dic = @{@"userId":userId,@"type":type,@"summary":summary};
    NSString * string = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/Newslists/add"];
    [WOTHTTPNetRequest doRequestWithParameters:dic useUrl:string complete:^WOTBaseModel *(id responseDic) {
        WOTBaseModel *model = [[WOTBaseModel alloc] initWithDictionary:responseDic error:nil];
        return model;
    } success:success fail:fail];
}


#pragma mark - 维修订单
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

//开始维修
+(void)startServiceWithInfoId:(NSNumber *)infoId  imageArray:(NSArray *)imageArray success:(success)success fail:(fail)fail
{
    NSDictionary *dic = @{@"infoId" :infoId
                          };
    NSString * string = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/MaintainInfo/confirmInfo"];
    [WOTHTTPNetRequest doFileRequestWithParameters:dic useUrl:string image:imageArray complete:^WOTBaseModel *(id responseDic) {
        SKAcceptAnOrderModel *model = [[SKAcceptAnOrderModel alloc] initWithDictionary:responseDic error:nil];
        return model;
    }success:success fail:fail];
}

//维修完成
+(void)serviceFinishWithInfoId:(NSNumber *)infoId  imageArray:(NSArray *)imageArray success:(success)success fail:(fail)fail
{
    NSDictionary *dic = @{@"infoId" :infoId
                          };
    NSString * string = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/MaintainInfo/mainInfo"];
    [WOTHTTPNetRequest doFileRequestWithParameters:dic useUrl:string image:imageArray complete:^WOTBaseModel *(id responseDic) {
        SKAcceptAnOrderModel *model = [[SKAcceptAnOrderModel alloc] initWithDictionary:responseDic error:nil];
        return model;
    }success:success fail:fail];
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
        WOTSpaceModel_msg * model_msg = [[WOTSpaceModel_msg alloc]initWithDictionary:responseDic error:nil];
        return  model_msg;
    } success:success fail:fail];
}

#pragma mark - 销售
+(void)addSalesOrderWithParam:(NSDictionary *)parameters success:(success)success fail:(fail)fail
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/Sell/addSell"];
    [WOTHTTPNetRequest doRequestWithParameters:parameters useUrl:urlstring complete:^WOTBaseModel *(id responseDic) {
        SKBaseResponseModel * model_msg = [[SKBaseResponseModel alloc]initWithDictionary:responseDic error:nil];
        return  model_msg;
    } success:success fail:fail];
}

+(void)getUntreatedSalesOrderSuccess:(success)success fail:(fail)fail
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/Sell/findSOO"];
    NSDictionary *parameters = @{@"leaderId":[WOTUserSingleton shared].userInfo.staffId,
                                };
    [WOTHTTPNetRequest doRequestWithParameters:parameters useUrl:urlstring complete:^WOTBaseModel *(id responseDic) {
        SKUntreatedSalesOrder_msg * model_msg = [[SKUntreatedSalesOrder_msg alloc]initWithDictionary:responseDic error:nil];
        return  model_msg;
    } success:success fail:fail];
}

+(void)getSalesOrderWithState:(NSString *)state success:(success)success fail:(fail)fail
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/Sell/find"];
    NSMutableDictionary *parameters = [@{@"pageNo":@(1),
                                         @"pageSize":@(10000),
                                         @"leaderId":[WOTUserSingleton shared].userInfo.staffId,
                                         } mutableCopy];
    if (!strIsEmpty(state)) {
        [parameters setValue:state forKey:@"stage"];
    }
    [WOTHTTPNetRequest doRequestWithParameters:parameters useUrl:urlstring complete:^WOTBaseModel *(id responseDic) {
        SKSalesOrder_msg * model_msg = [[SKSalesOrder_msg alloc]initWithDictionary:responseDic error:nil];
        return  model_msg;
    } success:success fail:fail];
}

+(void)updateSalesOrderInfoWithParam:(NSDictionary *)parameters success:(success)success fail:(fail)fail
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/Sell/addSell"];
    [WOTHTTPNetRequest doRequestWithParameters:parameters useUrl:urlstring complete:^WOTBaseModel *(id responseDic) {
        SKBaseResponseModel * model_msg = [[SKBaseResponseModel alloc]initWithDictionary:responseDic error:nil];
        return  model_msg;
    } success:success fail:fail];
}


#pragma mark - 销售日志
+(void)addSalesOrderLogWithParam:(NSDictionary *)parameters success:(success)success fail:(fail)fail
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/SellLog/addSellLog"];
    [WOTHTTPNetRequest doRequestWithParameters:parameters useUrl:urlstring complete:^WOTBaseModel *(id responseDic) {
        SKBaseResponseModel * model_msg = [[SKBaseResponseModel alloc]initWithDictionary:responseDic error:nil];
        return  model_msg;
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
        SKSalesOrderLog_msg * model_msg = [[SKSalesOrderLog_msg alloc] initWithDictionary:responseDic error:nil];
        return  model_msg;
    } success:success fail:fail];
}

#pragma mark - 销售问题
+(void)addSalesOrderQuestionWithParam:(NSDictionary *)parameters success:(success)success fail:(fail)fail
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/SellIssue/addSellIssue"];
    [WOTHTTPNetRequest doRequestWithParameters:parameters useUrl:urlstring complete:^WOTBaseModel *(id responseDic) {
        SKBaseResponseModel * model_msg = [[SKBaseResponseModel alloc]initWithDictionary:responseDic error:nil];
        return  model_msg;
    } success:success fail:fail];
}

+(void)getSalesOrderQuestionWithSellId:(NSNumber *)sellId success:(success)success fail:(fail)fail
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/SellIssue/find"];
    NSDictionary *parameters = @{@"pageNo":@(1),
                                 @"pageSize":@(1000),
                                 @"sellId":sellId,
                                 };
    [WOTHTTPNetRequest doRequestWithParameters:parameters useUrl:urlstring complete:^WOTBaseModel *(id responseDic) {
        SKQuestion_msg * model_msg = [[SKQuestion_msg alloc] initWithDictionary:responseDic error:nil];
        return  model_msg;
    } success:success fail:fail];
}


#pragma mark - 服务商
+(void)getDemandWithState:(NSString *)state success:(success)success fail:(fail)fail
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/Demand/find"];
    NSMutableDictionary *parameters = [@{@"pageNo":@(1),
                                         @"pageSize":@(1000),
                                         @"dealState":state,
                                         } mutableCopy];
    if (![state isEqualToString:@"未处理"]) {
        [parameters setValue:[WOTUserSingleton shared].userInfo.staffId forKey:@"staffId"];
    }
    [WOTHTTPNetRequest doRequestWithParameters:parameters useUrl:urlstring complete:^WOTBaseModel *(id responseDic) {
        SKDemandModel_msg * model_msg = [[SKDemandModel_msg alloc] initWithDictionary:responseDic error:nil];
        return  model_msg;
    } success:success fail:fail];
}

+(void)setDemandWithParams:(NSDictionary *)params success:(success)success fail:(fail)fail
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/Demand/addDemand"];
    [WOTHTTPNetRequest doRequestWithParameters:params useUrl:urlstring complete:^WOTBaseModel *(id responseDic) {
        WOTBaseModel * model_msg = [[WOTBaseModel alloc] initWithDictionary:responseDic error:nil];
        return  model_msg;
    } success:success fail:fail];
}

+(void)addDemandLogWithDemandId:(NSNumber *)demandId content:(NSString *)content success:(success)success fail:(fail)fail
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/DemandLog/addDemandLog"];
    NSDictionary *parameters = @{@"demandId":demandId,
                                 @"log":content,
                                 };
    [WOTHTTPNetRequest doRequestWithParameters:parameters useUrl:urlstring complete:^WOTBaseModel *(id responseDic) {
        WOTBaseModel * model_msg = [[WOTBaseModel alloc] initWithDictionary:responseDic error:nil];
        return  model_msg;
    } success:success fail:fail];
}

+(void)getDemandLogWithDemandId:(NSNumber *)demandId success:(success)success fail:(fail)fail
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/DemandLog/findByDemanId"];
    NSDictionary *parameters = @{@"pageNo":@(1),
                                 @"pageSize":@(1000),
                                 @"demandId":demandId,
                                 };
    [WOTHTTPNetRequest doRequestWithParameters:parameters useUrl:urlstring complete:^WOTBaseModel *(id responseDic) {
        SKDemandeLogModel_msg * model_msg = [[SKDemandeLogModel_msg alloc] initWithDictionary:responseDic error:nil];
        return  model_msg;
    } success:success fail:fail];
}

+(void)getReserveBookStationOrderWithPict:(NSDictionary *)dict success:(success)success fail:(fail)fail
{
    NSString * urlstring = [NSString stringWithFormat:@"%@%@", HTTPBaseURL,@"/SKwork/Order/find"];
    
    [WOTHTTPNetRequest doRequestWithParameters:dict useUrl:urlstring complete:^WOTBaseModel *(id responseDic) {
        WOTWorkStationHistoryModel_msg * model_msg = [[WOTWorkStationHistoryModel_msg alloc] initWithDictionary:responseDic error:nil];
        return  model_msg;
    } success:success fail:fail];
}

@end
