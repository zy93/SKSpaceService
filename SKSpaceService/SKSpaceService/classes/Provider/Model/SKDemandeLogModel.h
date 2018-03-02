//
//  SKDemandeLogModel.h
//  SKSpaceService
//
//  Created by 张雨 on 2018/3/2.
//  Copyright © 2018年 张雨. All rights reserved.
//

#import "WOTBaseModel.h"

@protocol SKDemandeLogModel

@end

@interface SKDemandeLogModel : WOTBaseModel
@property (nonatomic, strong) NSNumber * id;
@property (nonatomic, strong) NSNumber * demandId;
@property (nonatomic, strong) NSString * log;
@property (nonatomic, strong) NSString * time;
@end


@interface SKDemandeLogModel_msg : WOTBaseModel
@property (nonatomic, strong) NSArray <SKDemandeLogModel> *msg;
@end
