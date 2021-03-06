//
//  WOTWorkStationHistoryModel.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/1/12.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "WOTBaseModel.h"

@protocol WOTWorkStationHistoryModel
@end

@interface WOTWorkStationHistoryModel : JSONModel

@property (nonatomic, strong) NSString * appId ;
@property (nonatomic, strong) NSString * commodityName;
@property (nonatomic, strong) NSString * commodityKind;
@property (nonatomic, strong) NSNumber * commodityNum ;
@property (nonatomic, strong) NSString * commodityNumList;//
@property (nonatomic, strong) NSNumber * contractMode;
@property (nonatomic, strong) NSString * dealMode;
@property (nonatomic, strong) NSNumber * deduction ;
@property (nonatomic, strong) NSNumber * deductionTimes;
@property (nonatomic, strong) NSString * endTime ;
@property (nonatomic, strong) NSString * evaluate ;
@property (nonatomic, strong) NSString * imageSite ;
@property (nonatomic, strong) NSNumber * money ;
@property (nonatomic, strong) NSString * orderNum ;
@property (nonatomic, strong) NSString * orderState;
@property (nonatomic, strong) NSString * orderTime ;
@property (nonatomic, strong) NSNumber * payMode;
@property (nonatomic, strong) NSString * payObject;
@property (nonatomic, strong) NSNumber * payType ;
@property (nonatomic, strong) NSString * productNum;
@property (nonatomic, strong) NSNumber * spaceId ;
@property (nonatomic, strong) NSString * spaceName;
@property (nonatomic, strong) NSString * starTime;
@property (nonatomic, strong) NSNumber * userId;
@property (nonatomic, strong) NSString * userName;
@property (nonatomic, strong) NSString * userTel;
@property (nonatomic, strong) NSString *invoiceState;
@property (nonatomic, strong) NSString *invoiceType;
@property (nonatomic, strong) NSString *invoiceTitle;
@property (nonatomic, strong) NSString *invoiceTaxNum;
@property (nonatomic, strong) NSString *invoiceRemark;
@property (nonatomic,copy) NSString *orderCancel;

@end


@interface WOTWorkStationHistoryModel_list : JSONModel
@property (nonatomic, strong) NSNumber * bottomPageNo;
@property (nonatomic, strong) NSNumber * nextPageNo;
@property (nonatomic, strong) NSNumber * pageNo;
@property (nonatomic, strong) NSNumber * pageSize;
@property (nonatomic, strong) NSNumber * previousPageNo;
@property (nonatomic, strong) NSNumber * topPageNo;
@property (nonatomic, strong) NSNumber * totalPages;
@property (nonatomic, strong) NSNumber * totalRecords;
@property (nonatomic, strong) NSArray <WOTWorkStationHistoryModel> *list;
@end


@interface WOTWorkStationHistoryModel_msg : WOTBaseModel
@property(nonatomic,strong)WOTWorkStationHistoryModel_list *msg;
@end
