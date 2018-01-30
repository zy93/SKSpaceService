//
//  SKQuestionModel.h
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/29.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "WOTBaseModel.h"

@protocol SKQuestionModel
@end

@interface SKQuestionModel : WOTBaseModel
@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSNumber *sellId;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSNumber *userId;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *time;

@end

@interface SKQuestionList : WOTBaseModel
@property (nonatomic, strong) NSNumber * bottomPageNo;
@property (nonatomic, strong) NSNumber * nextPageNo;
@property (nonatomic, strong) NSNumber * pageNo;
@property (nonatomic, strong) NSNumber * pageSize;
@property (nonatomic, strong) NSNumber * previousPageNo;
@property (nonatomic, strong) NSNumber * topPageNo;
@property (nonatomic, strong) NSNumber * totalPages;
@property (nonatomic, strong) NSNumber * totalRecords;
@property (nonatomic, strong) NSArray <SKQuestionModel> *list;
@end


@interface SKQuestion_msg : WOTBaseModel
@property (nonatomic, strong) SKQuestionList *msg;
@end
