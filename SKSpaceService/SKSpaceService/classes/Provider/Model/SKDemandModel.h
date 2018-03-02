//
//  SKDemandModel.h
//  SKSpaceService
//
//  Created by 张雨 on 2018/3/1.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "WOTBaseModel.h"

@protocol SKDemandModel
@end

@interface SKDemandModel : WOTBaseModel
@property (nonatomic, strong) NSString *demandContent ;
@property (nonatomic, strong) NSNumber *demandId;
@property (nonatomic, strong) NSString *demandType ;
@property (nonatomic, strong) NSString *dealState;
@property (nonatomic, strong) NSNumber *facilitatorId;
@property (nonatomic, strong) NSString *firmName;
@property (nonatomic, strong) NSString *lookTime ;
@property (nonatomic, strong) NSString *putTime ;
@property (nonatomic, strong) NSString *needType;
@property (nonatomic, strong) NSNumber *spaceId;
@property (nonatomic, strong) NSString *spaceName ;
@property (nonatomic, strong) NSNumber *state ;
@property (nonatomic, strong) NSString *tel;
@property (nonatomic, strong) NSNumber *userId ;
@property (nonatomic, strong) NSString *userName ;
@end

@interface SKDemandModelList : WOTBaseModel
@property (nonatomic, strong) NSNumber * bottomPageNo;
@property (nonatomic, strong) NSNumber * nextPageNo;
@property (nonatomic, strong) NSNumber * pageNo;
@property (nonatomic, strong) NSNumber * pageSize;
@property (nonatomic, strong) NSNumber * previousPageNo;
@property (nonatomic, strong) NSNumber * topPageNo;
@property (nonatomic, strong) NSNumber * totalPages;
@property (nonatomic, strong) NSNumber * totalRecords;
@property (nonatomic, strong) NSArray <SKDemandModel> *list;
@end

@interface SKDemandModel_msg : WOTBaseModel
@property (nonatomic, strong) SKDemandModelList *msg;

@end
