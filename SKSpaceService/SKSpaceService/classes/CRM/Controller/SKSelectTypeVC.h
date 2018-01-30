//
//  SKSelectTypeVC.h
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/25.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "WOTBaseTableViewController.h"
#import "SKSalesOrderModel.h"

typedef NS_ENUM(NSInteger, SKSelectTypeVCTYPE) {
    SKSelectTypeVCTYPE_SELECT, //选择（选择某一行后直接返回）
    SKSelectTypeVCTYPE_ORDER_STATE, //修改订单状态
    SKSelectTypeVCTYPE_CLIENT_SOURCE,//修改客户来源
};

@interface SKSelectTypeVC : WOTBaseTableViewController
@property (nonatomic, copy) void(^selectSpaceBlock)(id model);
@property (nonatomic, strong) NSArray *tableList;
@property (nonatomic, assign) SKSelectTypeVCTYPE type;
@property (nonatomic, strong) SKSalesOrderModel *model;

@end
