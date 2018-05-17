//
//  SKTextViewVC.h
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/26.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKSalesOrderModel.h"

typedef NS_ENUM(NSInteger, SKTextViewVCTYPE) {
    SKTextViewVCTYPE_EDIT_LOG = 0,   //编辑日志
    SKTextViewVCTYPE_EDIT_CLIENT_NAME,   //编辑客户姓名
    SKTextViewVCTYPE_EDIT_CLIENT_TEL ,   //编辑客户电话
    SKTextViewVCTYPE_EDIT_CLIENT_COMPANY,//编辑客户公司
    SKTextViewVCTYPE_EDIT_CLIENT_SPECIFIC_SOURCE, //编辑客户具体来源
    SKTextViewVCTYPE_EDIT_CLIENT_APPOINTMENT_PEOPLENUM,//编辑预约人数
    SKTextViewVCTYPE_EDIT_CLIENT_APPOINTMENT_TIME,//编辑预约时间
    SKTextViewVCTYPE_EDIT_CLIENT_REMARK,//编辑备注
};

@interface SKTextViewVC : UIViewController

@property (nonatomic, strong) SKSalesOrderModel * model;
@property (nonatomic, assign) SKTextViewVCTYPE type;

@end
