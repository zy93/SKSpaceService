//
//  SKSalesOrderModel.h
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/29.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "WOTBaseModel.h"

@protocol SKSalesOrderModel
@end

@interface SKSalesOrderModel : WOTBaseModel
@property (nonatomic, strong) NSString *clientName ;
@property (nonatomic, strong) NSString *companyName;
@property (nonatomic, strong) NSString *companyType ;
@property (nonatomic, strong) NSString *contacts;
@property (nonatomic, strong) NSString *createTime ;
@property (nonatomic, strong) NSString *endTime;
@property (nonatomic, strong) NSString *industry;
@property (nonatomic, strong) NSString *intention ;
@property (nonatomic, strong) NSNumber *leaderId;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSString *leaderName ;
@property (nonatomic, strong) NSString *record ;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSNumber *sellId;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSNumber *spaceId;
@property (nonatomic, strong) NSString *spaceName;
@property (nonatomic, strong) NSString *specificSource;
@property (nonatomic, strong) NSString *stage;
@property (nonatomic, strong) NSString *state;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSString *will ;
@property (nonatomic, strong) NSString *appointmentTime;
@property (nonatomic, strong) NSNumber *peopleNum;
@end

@interface SKSalesOrderList : WOTBaseModel
@property (nonatomic, strong) NSNumber * bottomPageNo;
@property (nonatomic, strong) NSNumber * nextPageNo;
@property (nonatomic, strong) NSNumber * pageNo;
@property (nonatomic, strong) NSNumber * pageSize;
@property (nonatomic, strong) NSNumber * previousPageNo;
@property (nonatomic, strong) NSNumber * topPageNo;
@property (nonatomic, strong) NSNumber * totalPages;
@property (nonatomic, strong) NSNumber * totalRecords;
@property (nonatomic, strong) NSArray <SKSalesOrderModel> *list;
@end


@interface SKSalesOrder_msg : WOTBaseModel
@property (nonatomic, strong) SKSalesOrderList *msg;
@end

//未处理销售订单
@interface SKUntreatedSalesOrder_msg : WOTBaseModel
@property (nonatomic, strong) NSArray <SKSalesOrderModel> *msg;
@end


