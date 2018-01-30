//
//  SKOrderInfoModel.h
//  SKSpaceService
//
//  Created by wangxiaodong on 2018/1/30.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "WOTBaseModel.h"

@protocol SKOrderInfoModel
@end

@protocol SKOrderInfoModel_result
@end

@interface SKOrderInfoModel : JSONModel
@property(nonatomic,strong)NSString *address;
@property(nonatomic,strong)NSString *alias;
@property(nonatomic,strong)NSString *appointmentTime;
@property(nonatomic,strong)NSString *evaluation;
@property(nonatomic,strong)NSString *evaluationTime;
@property(nonatomic,strong)NSString *finishTime;
@property(nonatomic,strong)NSString *info;
@property(nonatomic,strong)NSString *orderOverTime;
@property(nonatomic,strong)NSString *orderTime;
@property(nonatomic,strong)NSString *phone;
@property(nonatomic,strong)NSString *pictureFour;
@property(nonatomic,strong)NSString *pictureOne;
@property(nonatomic,strong)NSString *pictureThree;
@property(nonatomic,strong)NSString *pictureTwo;
@property(nonatomic,strong)NSString *sorderTime;
@property(nonatomic,strong)NSString *star;
@property(nonatomic,strong)NSString *startTime;
@property(nonatomic,strong)NSString *state;
@property(nonatomic,strong)NSString *statuscode;
@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *userId;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSNumber *infoId;
@property(nonatomic,strong)NSNumber *spaceId;
@end

@interface SKOrderInfoModel_msg:JSONModel
@property(nonatomic,strong)NSArray <SKOrderInfoModel>*list;
@property(nonatomic,strong)NSNumber *pageCount;
@property(nonatomic,strong)NSNumber *totalRecords;
@end


@interface SKOrderInfoModel_result : WOTBaseModel
@property(nonatomic,strong)SKOrderInfoModel_msg *msg;

@end
