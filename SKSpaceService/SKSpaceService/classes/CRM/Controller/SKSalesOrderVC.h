//
//  SKSalesOrderVC.h
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/24.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "WOTBaseTableViewController.h"

typedef NS_ENUM(NSInteger, SKSalesOrderVCTYPE) {
    SKSalesOrderVCTYPE_ALL = 0, //全部
    SKSalesOrderVCTYPE_CLIENT_CONSULTING,    //客户咨询
    SKSalesOrderVCTYPE_PRELIMINARY_CONTACT, //初步接洽
    SKSalesOrderVCTYPE_FURTHER_CONTACT, //深入接洽
    SKSalesOrderVCTYPE_FINISHED,      //已完成
    SKSalesOrderVCTYPE_UNFINISHED,  //未完成
};


@interface SKSalesOrderVC : WOTBaseTableViewController

@property (nonatomic, assign) SKSalesOrderVCTYPE type;

@end
