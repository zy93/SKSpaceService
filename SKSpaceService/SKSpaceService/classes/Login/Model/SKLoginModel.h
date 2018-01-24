//
//  SKLoginModel.h
//  SKSpaceService
//
//  Created by 张雨 on 2018/1/23.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "WOTBaseModel.h"

@protocol SKLoginModel
@end

@interface SKLoginModel : JSONModel
@property (nonatomic, strong) NSString *alias ;
@property (nonatomic, strong) NSString *appId;
@property (nonatomic, strong) NSString *birthDate;
@property (nonatomic, strong) NSString *contacts ;
@property (nonatomic, strong) NSNumber *departmentId ;
@property (nonatomic, strong) NSString *departmentName ;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *headPortrait;
@property (nonatomic, strong) NSString *jurisdiction;
@property (nonatomic, strong) NSString *realName ;
@property (nonatomic, strong) NSString *registerTime ;
@property (nonatomic, strong) NSString *sex ;
@property (nonatomic, strong) NSString *spaceList;
@property (nonatomic, strong) NSNumber *staffId ;
@property (nonatomic, strong) NSString *staffName ;
@property (nonatomic, strong) NSNumber *staffType;
@property (nonatomic, strong) NSNumber *state ;
@property (nonatomic, strong) NSString *tel ;
@end

@interface SKLoginModel_msg : WOTBaseModel
@property (nonatomic, strong) SKLoginModel *msg;
@end
