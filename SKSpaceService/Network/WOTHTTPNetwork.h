//
//  WOTHTTPNetwork.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/4.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WOTHTTPNetRequest.h"

@interface WOTHTTPNetwork : NSObject

#pragma mark - 用户
/**
 * 登录接口
 @param telOrEmail  登录账号手机号或邮箱
 @param pwd         登录密码 md5加密
 @param alias       用户设备alias
 @param success     成功回调
 @param fail        失败回调
 */
+(void)userLoginWithTelOrEmail:(NSString *)telOrEmail password:(NSString *)pwd alias:(NSString *)alias success:(success)success fail:(fail)fail;

+(void)updateUserInfoUserId:(NSNumber *)userId success:(success)success fail:(fail)fail;

/**
 * 发送手机验证码
 @param tel  电话
 @param success     成功回调
 @param fail        失败回调
 */
+(void)userGetVerifyWitTel:(NSString *)tel success:(success)success fail:(fail)fail;

/**
 添加消息

 @param userId 用户id
 @param type 类型
 @param summary 消息内容
 @param success 成功回调
 @param fail 失败回调
 */
+(void)sendMessageWithUserId:(NSNumber *)userId type:(NSString *)type summary:(NSString*)summary success:(success)success fail:(fail)fail;

#pragma mark - 维修订单
/**
 查询订单

 @param spaceList 空间id数组
 @param statuscode 订单状态，1 待维修  2 已接单   3 维修中    4 维修完成
 @param pickUpUserID 接单人的id
 @param success 成功回调
 @param fail 失败回调
 */
+(void)queryRepairsOrderWithSpaceList:(NSString *)spaceList statuscode:(NSString *)statuscode pickUpUserID:(NSNumber *)pickUpUserID success:(success)success fail:(fail)fail;

/**
 接受订单

 @param username 接单人的名字
 @param infoId 信息id
 @param pickUpUserID 接单人id
 @param success 成功回调
 @param fail 失败回调
 */

+(void)acceptAnOrderWithUserName:(NSString *)username infoId:(NSNumber *)infoId pickUpUserID:(NSNumber *)pickUpUserID success:(success)success fail:(fail)fail;


/**
 开始维修

 @param infoId 信息id
 @param imageArray 图片数组
 @param success 成功回调
 @param fail 失败回调
 */
+(void)startServiceWithInfoId:(NSNumber *)infoId  imageArray:(NSArray *)imageArray success:(success)success fail:(fail)fail;


/**
 维修完成

 @param infoId 信息id
 @param imageArray 图片数组
 @param success 成功回调
 @param fail 失败回调
 */
+(void)serviceFinishWithInfoId:(NSNumber *)infoId  imageArray:(NSArray *)imageArray success:(success)success fail:(fail)fail;


#pragma mark - 空间

/**
 获取所有空间列表
 
 @param success 成功回调
 @param fail 失败回调
 */
+(void)getSapaceFromGroupBlockSuccess:(success)success fail:(fail)fail;

/**
 分页获取空间列表
 
 @param page 页码
 @param pageSize 数据量
 @param success 成功回调
 @param fail 失败回调
 */
+(void)getSapaceWithPage:(NSNumber *)page pageSize:(NSNumber *)pageSize success:(success)success fail:(fail)fail;

#pragma mark - 销售
/**
 添加销售订单
 
 @param parameters 参数字典
 @param success 成功回调
 @param fail 失败回调
 */
+(void)addSalesOrderWithParam:(NSDictionary *)parameters success:(success)success fail:(fail)fail;

/**
 获取未处理销售订单

 @param success 成功回调
 @param fail 失败回调
 */
+(void)getUntreatedSalesOrderSuccess:(success)success fail:(fail)fail;
/**
 获取用户销售订单记录
 
 @param state 订单状态
 @param success 成功回调
 @param fail 失败回调
 */
+(void)getSalesOrderWithState:(NSString *)state success:(success)success fail:(fail)fail;

/**
 更新销售订单信息
 
 @param parameters 更新内容
 @param success 成功回调
 @param fail 失败回调
 */
+(void)updateSalesOrderInfoWithParam:(NSDictionary *)parameters success:(success)success fail:(fail)fail;

#pragma mark - 销售日志
/**
 添加销售日志
 
 @param parameters 参数列表
 @param success 成功回调
 @param fail 失败回调
 */
+(void)addSalesOrderLogWithParam:(NSDictionary *)parameters  success:(success)success fail:(fail)fail;
/**
 获取日志
 
 @param sellId 销售订单id
 @param success 成功回调
 @param fail 失败回调
 */
+(void)getSalesOrderLogWithSellId:(NSNumber *)sellId success:(success)success fail:(fail)fail;

#pragma mark - 销售问题

/**
 添加销售问题

 @param parameters 参数列表
 @param success 成功回调
 @param fail 失败回调
 */
+(void)addSalesOrderQuestionWithParam:(NSDictionary *)parameters success:(success)success fail:(fail)fail;
/**
 获取问题列表
 @param sellId 销售订单id
 @param success 成功回调
 @param fail 失败回调
 */
+(void)getSalesOrderQuestionWithSellId:(NSNumber *)sellId success:(success)success fail:(fail)fail;


#pragma mark - 服务商

/**
 获取未处理的服务商需求
 @param state 状态  未处理、处理中、已处理
 @param success 成功回调
 @param fail 失败回调
 */
+(void)getDemandWithState:(NSString *)state success:(success)success fail:(fail)fail;

/**
 处理服务商需求

 @param params 参数列表
 @param success 成功回调
 @param fail 失败回调
 */
+(void)setDemandWithParams:(NSDictionary *)params  success:(success)success fail:(fail)fail;

/**
 添加需求日志

 @param demandId 需求id
 @param content 内容
 @param success 成功回调
 @param fail 失败回调
 */
+(void)addDemandLogWithDemandId:(NSNumber *)demandId content:(NSString *)content success:(success)success fail:(fail)fail;

/**
 获取需求日志

 @param demandId 需求id
 @param success 成功回调
 @param fail 失败回调
 */
+(void)getDemandLogWithDemandId:(NSNumber *)demandId success:(success)success fail:(fail)fail;



#pragma mark - 运营人员接收到的用户下工位订单

/**
 运营人员接收到的用户下工位订单

 @param dict 查询参数
 @param success 成功回调
 @param fail 失败回调
 */
+(void)getReserveBookStationOrderWithPict:(NSDictionary *)dict success:(success)success fail:(fail)fail;

#pragma mark - 数据统计

/**
 会员人数统计
 @param success 成功回调
 @param fail 失败回调
 */
+(void)queryVipNumberWithSuccess:(success)success fail:(fail)fail;

/**
 查询订单数量

 @param dict 查询参数
 @param success 成功回调
 @param fail 失败回调
 */
+(void)queryOrderNumberWithPict:(NSDictionary *)dict success:(success)success fail:(fail)fail;

/**
 查询礼包数量

 @param dict 查询参数
 @param success 成功回调
 @param fail 失败回调
 */
+(void)queryGiftBagNumberWithPict:(NSDictionary *)dict success:(success)success fail:(fail)fail;

/**
 查询长租工位或空间空位统计

 @param dict 查询参数
 @param success 成功回调
 @param fail 失败回调
 */
+(void)queryLongTimeBookStationWithPict:(NSDictionary *)dict success:(success)success fail:(fail)fail;

/**
 查询项目收益

 @param dict 查询参数
 @param success 成功回调
 @param fail 失败回调
 */
+(void)queryProjectEarningsWithPict:(NSDictionary *)dict success:(success)success fail:(fail)fail;

/**
 所有空间企业统计
 @param success 成功回调
 @param fail 失败回调
 */
+(void)statisticsAllSpaceCompanyWithSuccess:(success)success fail:(fail)fail;


/**
 所有空间工位数量
 @param success 成功回调
 @param fail 失败回调
 */
+(void)queryAllSpaceBookStationNumberyWithSuccess:(success)success fail:(fail)fail;

/**
 查询服务商点击top10
 
 @param dict 查询参数
 @param success 成功回调
 @param fail 失败回调
 */
+(void)queryFacilitatorTopWithPict:(NSDictionary *)dict success:(success)success fail:(fail)fail;

/**
活动报名统计
 
 @param dict 查询参数
 @param success 成功回调
 @param fail 失败回调
 */
+(void)activityApplyStatisticsWithPict:(NSDictionary *)dict success:(success)success fail:(fail)fail;

/**
查询单个服务商点击统计
 
 @param dict 查询参数
 @param success 成功回调
 @param fail 失败回调
 */
+(void)queryStatisticsOneFacilitatorWithPict:(NSDictionary *)dict success:(success)success fail:(fail)fail;

/**
 查询所有服务商
 
 @param dict 查询参数
 @param success 成功回调
 @param fail 失败回调
 */
+(void)queryAllFacilitatorWithPict:(NSDictionary *)dict success:(success)success fail:(fail)fail;
@end
