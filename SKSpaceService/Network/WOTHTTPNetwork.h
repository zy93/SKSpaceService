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
 获取问题列表
 
 @param success 成功回调
 @param fail 失败回调
 */
+(void)getSalesOrderQuestionSuccess:(success)success fail:(fail)fail;



@end
