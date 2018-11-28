//
//  WOTUserSingleton.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/12.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SKLoginModel.h"

//系统权限
#define permissionList @[@"报修管理", @"销控管理", @"服务商管理",@"运营管理",@"数据统计"]
#define permissionVCNameList @{@"报修管理":@"SKRepairVC", @"销控管理":@"SKSalesMainVC", @"服务商管理":@"SKProviderMainVC",@"运营管理":@"SKAllReserveOrderVC",@"数据统计":@"SKStatisticsTableView"}


@interface WOTUserSingleton : NSObject

//用户信息
@property (nonatomic, strong) SKLoginModel *userInfo;
@property (nonatomic, assign, getter=isFirstLoad) BOOL firstLoad;
@property (nonatomic, assign, getter=isLogin) BOOL login;


+(instancetype)shared;
-(void)saveUserInfoToPlistWithModel:(SKLoginModel *)model;
-(NSArray *)getUserPermissions;
-(void)userLogout;
-(void)updateUserInfoByServer;
@end
