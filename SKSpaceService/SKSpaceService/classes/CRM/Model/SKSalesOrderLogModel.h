//
//  SKSalesOrderLogModel.h
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/30.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "WOTBaseModel.h"

@protocol SKSalesOrderLogModel
@end

@interface SKSalesOrderLogModel : WOTBaseModel

@end

@interface SKSalesOrderLogList : WOTBaseModel
@property (nonatomic, strong) NSNumber * bottomPageNo;
@property (nonatomic, strong) NSNumber * nextPageNo;
@property (nonatomic, strong) NSNumber * pageNo;
@property (nonatomic, strong) NSNumber * pageSize;
@property (nonatomic, strong) NSNumber * previousPageNo;
@property (nonatomic, strong) NSNumber * topPageNo;
@property (nonatomic, strong) NSNumber * totalPages;
@property (nonatomic, strong) NSNumber * totalRecords;
@property (nonatomic, strong) NSArray <SKSalesOrderLogModel> *list;
@end

@interface SKSalesOrderLog_msg : WOTBaseModel
@property (nonatomic, strong) SKSalesOrderLogList * msg;
@end


